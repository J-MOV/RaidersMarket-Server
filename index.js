const port = 1113;

const http = require("http");
const express = require("express");

const app = express();
const server = http.createServer(app);

const WebSocket = require("ws");
const { v4: uuidv4 } = require("uuid");

const wss = new WebSocket.Server({ server });

var mysql = require("mysql");
var connection = mysql.createConnection({
	host: "localhost",
	user: "olle",
	password: "nicke",
	database: "game",
});

server.listen(port, () => {
	console.log(`Game server and website started on port ${port}`);
});

app.get("/", (req, res) => {
	res.end("Our Unity game server is hosted here!");
});

connection.connect();

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

wss.on("connection", (ws) => {
	connection.query("SELECT * FROM items_index", (err, res) => {
		indexedItems = res;
		ws.send(Package("items_index", JSON.stringify(res)));
	});

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
							console.log(
								"Get owner: " + item.owner + " : ",
								owner
							);
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
								console.log("Removed and updated user");
								sendUserUpdate(user, ws);
								sendUserMarketFront(ws);
							});
						}
					});
				});
			}

			if (identifier == "set_username") {
				getUser(token, (user) => {
					if (user.username == null) {
						connection.query(
							"SELECT * FROM users WHERE username = ?",
							[data],
							(err, res) => {
								if (res.length == 0) {
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

			if (identifier == "login") {
				connection.query(
					"SELECT * FROM users WHERE token = ?",
					[token],
					(err, results) => {
						var user = results[0];

						if (!user) {
							let new_token = uuidv4();
							console.log(
								"New user connected, generating a login for them: " +
									new_token
							);

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
								console.log(
									"User " + user.username + " logged in"
								);
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

function getUserFromId(id, callback) {
	connection.query("SELECT * FROM users WHERE id = ?", [id], (err, res) => {
		callback(res[0]);
	});
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
