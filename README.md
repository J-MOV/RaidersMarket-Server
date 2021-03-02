# Raiders Market Server

## Game

The game repo is https://github.com/J-MOV/RaidersMarket

Check out the website for an explanation of the game, screenshots and downloads https://rm.ygstr.com/

## About

This server handles user authentication, inventory, market and raids.
It's written in JavaScript for NodeJS. It uses MySQL to store the data.

### Note

The official game server is hosted at dungeon.ygstr.com, which is written in [OnlineConnection.cs](https://github.com/J-MOV/RaidersMarket/blob/bf02d0d0b1218004d7abb02da45944a4a31593c9/Assets/Scripts/OnlineConnection.cs#L73).
If you want to start your own server for testing, you need to edit OnlineConnection.cs and enter your own url (Most likley ws://localhost:1113)

## Setting up your own verison of the server

### Prerequisites

-   NodeJS & NPM
-   MySQL

### Steps

1. Clone the repo `git clone https://github.com/J-MOV/raidersMarket-Server`
2. Enter the repo folder and install dependencies `npm i`
3. Setup MySQL server
    1. Create the database `mysql> CREATE DATABASE game;`
    2. Import the structure `sudo mysql game < sql_scemas/game.sql`
    3. Import Indexed Items `sudo mysql game < sql_scemas/items_index.sql`
4. Configure index.js with your MySQL login info
5. (Optional) Configure index.js ports (Default 1113 game, 1114 website)
6. Start the server `node index.js`

# Database structure

## Users

```
+-----+--------------+------+-----+--------------------------------------+
| id  | username     | gold | lvl | token                                |
+-----+--------------+------+-----+--------------------------------------+
| 912 | Viktor       |  126 |   3 | 577ed08e-3069-4ef2-bb31-945aabf22f5b |
| 913 | Mehmet       |    5 |   2 | 36026907-141e-4202-8d07-59e3ad381151 |
| 920 | Olle         | 2100 |  16 | 4013a946-9398-428e-b352-e2bdab2a0b82 |
+-----+--------------+------+-----+--------------------------------------+
```

## Items

## Items Index

## Raids

## Market Transactions
