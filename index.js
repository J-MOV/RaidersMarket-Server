const WebSocket = require("ws");
const { v4: uuidv4 } = require("uuid");

const wss = new WebSocket.Server({ port: 8080 }, () => {
	console.log("Game server started with Websocket");
});

var mysql = require("mysql");
var connection = mysql.createConnection({
	host: "localhost",
	user: "olle",
	password: "nicke",
	database: "game",
});

connection.connect();

/* connection.query("SELECT * FROM items_index", (error, results, fields) => {
	if (error) throw error;
}); */

wss.on("connection", (ws) => {
	console.log("Websocket connected");

	connection.query("SELECT * FROM items_index", (err, res) => {
		ws.send(Package("items_index", JSON.stringify(res)));
	});

	ws.on("message", (message) => {
		try {
			message = JSON.parse(message);

			var data = message.data;
			var identifier = message.identifier;

			if (identifier == "login") {
				var token = data;
				connection.query(
					"SELECT * FROM users WHERE token = ?",
					[token],
					(err, results) => {
						var user = results[0];

						if (!user) {
							console.log("No user found, creating a new one.");
							let new_token = uuidv4();

							connection.query(
								"INSERT INTO users (token) VALUES (?)",
								[new_token],
								(err, res) => {
									ws.send(Package("new_login", new_token));
								}
							);
						} else {
							console.log("Going to send the user");
							/* delete user.id;
							delete user.token;
							delete user.username; */
							ws.send(Package("logged_in", JSON.stringify(user)));

							getInventory(user.id, (inventory) => {
								console.log(inventory);
								ws.send(
									Package(
										"inventory",
										JSON.stringify(inventory)
									)
								);
							});
						}
					}
				);
			}
		} catch (e) {
			console.warn("Unwanted JSON got sent: ", message);
		}
	});
});

function Package(identifier, data) {
	return JSON.stringify({
		identifier,
		data,
	});
}

function getInventory(id, callback) {
	connection.query(
		"SELECT * FROM items WHERE owner = ? AND for_sale = 0",
		[id],
		(err, res) => {
			callback(res);
		}
	);
}

wss.on("listening", () => {
	console.log("Now listening");
});
