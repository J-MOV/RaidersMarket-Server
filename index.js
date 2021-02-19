const WebSocket = require("ws");
const wss = new WebSocket.Server({ port: 8080 }, () => {
	console.log("Game server started with Websocket");
});

wss.on("connection", (ws) => {
	console.log("UNITY CONNECTED!");

	ws.send("Test");

	ws.on("message", (data) => {
		console.log("GOT DATA: ", data);
	});
});

wss.on("listening", () => {
	console.log("Now listening");
});
