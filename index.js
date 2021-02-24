const port = 1113;

const http = require("http");
const express = require("express");

const app = express();
const server = http.createServer(app);

const WebSocket = require("ws");
const { v4: uuidv4 } = require("uuid");

const wss = new WebSocket.Server({ server });

var mysql = require("mysql");
const { spawn } = require("child_process");
var connection = mysql.createConnection({
	host: "localhost",
	user: "local",
	password: "pass",
	database: "game",
});

server.listen(port, () => {
	console.log(`Game server and website started on port ${port}`);
});

app.get("/", (req, res) => {
	res.end("Our Unity game server is hosted here!");
});

connection.connect();
connection.query("SELECT * FROM items_index", (err, res) => {
    indexedItems = res;
});


var indexedItems;

function getIndexedItem(id) {
	for (var item of indexedItems) {
		if (item.id == id) {
			return item;
		}
	}
}

function setItemEquip(id, equipped) {
	console.count("Equip update");
	connection.query("UPDATE items SET equipped = ? WHERE id = ?", [
		equipped,
		id,
	]);
}

function giveUserGold(user, amount, callback = () => {}) {
	getUser(user.token, (latestUser) => {
		connection.query(
			"UPDATE users SET gold = ? WHERE id = ?",
			[latestUser.gold + amount, user.id],
			() => {
				callback();
			}
		);
	});
}


function query(text, variables){
    return new Promise((resolve, reject) => {
        connection.query(text, variables, (err, results) => {
            if(err) reject(err);
            else resolve(results);
        })
    })
}


wss.on("connection", (ws) => {

    ws.send(Package("items_index", JSON.stringify(indexedItems)));
	
	ws.on("message", (message) => {
		try {
			message = JSON.parse(message);

			var data = message.data;
			var identifier = message.identifier;
			var token = message.token;

			if (identifier == "buy") {
				getUser(token, (user) => {
					getItem(data, (item) => {
						getUserFromId(item.owner, (owner) => {
							if (
								item.for_sale === 1 &&
								item.price <= user.gold &&
								item.owner != user.id
							) {
								// Register the transaction
								connection.query(
									"INSERT INTO market_transactions (seller, buyer, item, price, date) VALUES (?, ?, ?, ?, ?)",
									[
										owner.id,
										user.id,
										item.id,
										item.price,
										new Date(),
									],
									() => {
                                        console.log(user.username + " bought an item from " + seller.username + " for " + item.price + " gold")
										// Assign the new owner and remove from market
										connection.query(
											"UPDATE items SET owner = ?, for_sale = 0, price = 0 WHERE id = ?",
											[user.id, item.id],
											() => {
												// Remove the gold price from the buyer
												giveUserGold(
													user,
													-item.price,
													() => {
														// Give the price amount to the previous item owner
														giveUserGold(
															owner,
															item.price,
															() => {
																// Update the user that everything is done.
																sendUserUpdate(
																	user,
																	ws
																);
																sendUserMarketFront(
																	ws
																);
															}
														);
													}
												);
											}
										);
									}
								);
							}
						});
					});
				});
			}

			if (identifier == "get_listings") {
				var listings = [];
				connection.query(
					"SELECT * FROM market_transactions WHERE item = ? ORDER BY price ASC LIMIT 1",
					[data],
					(req, lowestSoldFor) => {
						connection.query(
							"SELECT * FROM market_transactions WHERE item = ? ORDER BY date DESC LIMIT 1",
							[data],
							(err, lastSoldFor) => {
								connection.query(
									"SELECT items.*, users.username FROM items INNER JOIN users ON items.owner=users.id WHERE items.item = ? AND items.for_sale = 1 ORDER BY price ASC",
									[data],
									(err, res) => {
										for (var listing of res) {
											var seller = listing.username;
											delete listing.username;
											listings.push({
												item: listing,
												seller,
											});
										}

										ws.send(
											Package(
												"listings",
												JSON.stringify({
													items: listings,
													lastSoldFor:
														lastSoldFor.length > 0
															? lastSoldFor[0]
																	.price
															: "---",
													lowestSoldFor:
														lowestSoldFor.length > 0
															? lowestSoldFor[0]
																	.price
															: "---",
												})
											)
										);
									}
								);
							}
						);
					}
				);
			}

			if (identifier == "equip") {
				getUser(token, (user) => {
					getItem(data, (item) => {
						if (item.equipped === 1) {
							setItemEquip(item.id, 0);
							sendUserUpdate(user, ws);
						} else {
							var indexedItem = getIndexedItem(item.item);
							// Check that the user can wear the item
							if (item.owner == user.id && item.for_sale === 0) {
								getInventory(user.id, (inventory) => {
									for (var invenotryItem of inventory) {
										if (
											getIndexedItem(invenotryItem.item)
												.type == indexedItem.type
										) {
											setItemEquip(invenotryItem.id, 0);
										}
									}
									setItemEquip(item.id, 1);
									sendUserUpdate(user, ws);
								});
							}
						}
					});
				});
			}

			if (identifier == "get_market_front") {
				sendUserMarketFront(ws);
			}

			if (identifier == "check_username_availability") {
				connection.query(
					"SELECT * FROM users WHERE username = ?",
					[data],
					(err, res) => {
						ws.send(
							Package(
								"username_availability",
								JSON.stringify({
									username: data,
									available: res.length == 0,
								})
							)
						);
					}
				);
			}

			if (identifier == "create_listing") {
				data = JSON.parse(data);
				getUser(token, (user) => {
					getItem(data.item, (item) => {
						if (item.owner == user.id) {
							setItemSaleStatus(item.id, true, data.price, () => {
								sendUserUpdate(user, ws);
							});
						}
					});
				});
			}

			if (identifier == "remove_listing") {
				getUser(token, (user) => {
					getItem(Number(data), (item) => {
						if (item.owner == user.id) {
							setItemSaleStatus(item.id, false, 0, () => {
								sendUserUpdate(user, ws);
								sendUserMarketFront(ws);
							});
						}
					});
				});
			}

            if(identifier == "start_raid"){
                getUser(token, (user) => {
                    data = Number(data)
                    if(isNaN(data)) return;
                    if(data > user.lvl) return;

                    connection.query("INSERT INTO raids (user, lvl, started, earned_loot, completed) VALUES (?, ?, ?, ?, 0)", [user.id, data, new Date(), JSON.stringify([]), 0], (err, res) => {
                        ws.send(Package("start_raid"))
                    })
                })
            }

            if(identifier == "raid_ended"){
                getUser(token, user => {
                    getRaid(user.id, raid => {
                        var completed = JSON.parse(data);

                        var earned_loot = []
                        var earned_gold = 0

                        if(completed){
                            console.log(user.username + " completed a raid on lvl " + raid.lvl)                            
                            for(let originItemId of JSON.parse(raid.earned_loot)){
                                var spawnedItem = {
                                    item: originItemId,
                                    pattern: Math.random(),
                                    owner: user.id,
                                    for_sale: 0,
                                    price: 0,
                                    equipped: 0
                                }
                                earned_loot.push(spawnedItem)
                                connection.query(`INSERT INTO items (item, pattern, owner, creator, created) VALUES (?, ?, ?, ?, ?)`, [
                                    spawnedItem.item, spawnedItem.pattern, spawnedItem.owner, user.id, new Date()
                                ], (err, res) => {
                      
                                })
                            }
                            
                            // Give the player 1-10 Gold for every item they found in the raid
                            for(var i = 0; i < earned_loot.length; i++){
                                earned_gold += Math.floor(Math.random() * 10) +1;
                            }

                            // A 10% chance to drop 10-100 extra gold
                            if(Math.random() > .9){
                                earned_gold += Math.floor(Math.random() * 90) + 10
                            }

                            giveUserGold(user, earned_gold)
                            
                            connection.query("UPDATE users SET lvl = ? WHERE id = ?", [(user.lvl == raid.lvl ? user.lvl + 1 : user.lvl), user.id], (err, res) => {
                                sendUserUpdate(user, ws);
                            })
                            
                           

                        } else {
                            console.log(user.username + " failed a raid on lvl " + raid.lvl)
                        }
                        ws.send(Package("post_raid_info", JSON.stringify({
                            completed,
                            lvl: raid.lvl,
                            earnedGold: earned_gold,
                            earnedLoot: earned_loot 
                        })))     
                    })
                })
            }

            if(identifier == "killed_enemy"){
                getUser(token, user => {
                    getRaid(user.id, raid => {
                        generateLoot(raid.lvl, item => {
                            var earned_loot = JSON.parse(raid.earned_loot)
                            earned_loot.push(item)
                            connection.query("UPDATE raids SET earned_loot = ? WHERE id = ?", [JSON.stringify(earned_loot), raid.id], (err, res) => {
                                ws.send(Package("loot_rarity", getIndexedItem(item).rarity));
                            })
                        })
                    })
                })
            }   

			if (identifier == "set_username") {
				getUser(token, (user) => {
					if (user.username == null) {
						connection.query(
							"SELECT * FROM users WHERE username = ?",
							[data],
							(err, res) => {
								if (res.length == 0) {
                                    console.log("New user: " + data)
									connection.query(
										"UPDATE users SET username = ? WHERE id = ?",
										[data, user.id],
										(err, res) => {
											user.username = data;
											sendUserUpdate(user, ws);
										}
									);
								}
							}
						);
					}
				});
			}

            if(identifier == "history"){
                getItem(data, async item => {
                        var transactions = await query("SELECT * FROM market_transactions WHERE item = ? ORDER BY date DESC", item.id)
                        
                        for(let transaction of transactions){
                            var seller = await query("SELECT * FROM users WHERE id = ?", transaction.seller)
                            var buyer = await query("SELECT * FROM users WHERE id = ?", transaction.buyer)
                   
                            transaction.seller = seller[0].username;
                            transaction.buyer = buyer[0].username;
                        }

                        var creator = await query("SELECT * FROM users WHERE id = ?" , item.creator)
                        
                        creator = creator[0].username

                        ws.send(Package("history", JSON.stringify({
                            transactions, creator, created: item.created
                        })))                   
                })

            }

			if (identifier == "login") {
				connection.query(
					"SELECT * FROM users WHERE token = ?",
					[token],
					(err, results) => {
						var user = results[0];

						if (!user) {
							let new_token = uuidv4();
							
							connection.query(
								"INSERT INTO users (token) VALUES (?)",
								[new_token],
								(err, res) => {
									ws.send(Package("new_login", new_token));
								}
							);
						} else {
							if (user.username == null) {
								ws.send(Package("choose_username", ""));
							} else {
								sendUserUpdate(user, ws);   
							}
						}
					}
				);
			}
		} catch (e) {
			console.warn("Unwanted JSON got sent: ", message);
		}
	});
});

function sendUserMarketFront(ws) {
	connection.query(
		"SELECT items.* FROM items JOIN items_index ON items.item = items_index.id WHERE for_sale = 1 ORDER BY items_index.rarity DESC, items_index.name",
		(err, res) => {
			var market = res;

			var market_front = [];

			for (let item of market) {
				var found = false;
				for (let listingFront of market_front) {
					if (listingFront.item.item == item.item) {
						found = true;
						if (listingFront.item.price > item.price) {
							listingFront.item = item;
						}
						listingFront.amount++;
					}
				}
				if (!found) {
					// Not listing found for this item, create a new one
					market_front.push({
						item,
						amount: 1,
					});
				}
			}

			ws.send(Package("market_front", JSON.stringify(market_front)));
		}
	);
}

function setItemSaleStatus(item_id, for_sale, price = 0, callback = () => {}) {
	connection.query(
		"UPDATE items SET for_sale = ?, price = ?, equipped = 0 WHERE id = ?",
		[Number(for_sale), price, item_id],
		(err, res) => {
			callback();
		}
	);
}

function sendUserUpdate(user, ws) {
	getUser(user.token, (latest_user) => {
		delete user.token;

		ws.send(Package("logged_in", JSON.stringify(latest_user)));

		getInventory(latest_user.id, (inventory) => {
			ws.send(Package("inventory", JSON.stringify(inventory)));
		});
	});
}

function Package(identifier, data) {
	return JSON.stringify({
		identifier,
		data,
	});
}


function generateLoot(raid_level, callback){
    const rarity_table =  [
        59.8, // Common
        25, // Rare
        10, // Epic
        5, // Legendary
        .2 // Mythical
    ]

    var raritySeed = Math.random() * 100;
    var rarity;
    
    var total = 0;
    for(let i = 0; i < rarity_table.length; i++){
        total+= rarity_table[i]
        if(raritySeed < total){
            rarity = i;
            break;
        }
    }

    connection.query("SELECT * FROM items_index WHERE rarity = ?", [rarity], (err, res) => {
        var pool = []
        for(var indexItem of res){
            for(let i = 0; i < indexItem.loot; i++){
                pool.push(indexItem.id);
            }
        }
        
        var item = getIndexedItem(pool[Math.floor(Math.random() * pool.length)])
        
        callback(item.id);
    })
}

function getUserFromId(id, callback) {
	connection.query("SELECT * FROM users WHERE id = ?", [id], (err, res) => {
		callback(res[0]);
	});
}

function getRaid(user_id, callback){
    connection.query("SELECT * FROM raids WHERE user = ? ORDER BY started DESC", [user_id], (err, res) => {
        callback(res[0]);
    })
}

function getUser(token, callback) {
	connection.query(
		"SELECT * FROM users WHERE token = ?",
		[token],
		(err, res) => {
			callback(res[0]);
		}
	);
}

function getItem(id, callback) {
	connection.query("SELECT * FROM items WHERE id = ?", [id], (err, res) => {
		callback(res[0]);
	});
}

function getInventory(id, callback) {
	connection.query(
		//SELECT items.* FROM items JOIN items_index ON items.item = items_index.id WHERE for_sale = 1 ORDER BY items_index.rarity DESC
		"SELECT items.* FROM items JOIN items_index ON items.item = items_index.id WHERE owner = ? AND for_sale = 0 ORDER BY items_index.rarity DESC, items_index.name",
		[id],
		(err, res) => {
			callback(res);
		}
	);
}
