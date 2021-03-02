# Raiders Market Server and Website

## Game

The game repo is https://github.com/J-MOV/RaidersMarket

Check out the website for an explanation of the game, screenshots and downloads https://rm.ygstr.com/

## About

This server handles user authentication, inventory, market and raids.
It's written in JavaScript for NodeJS. It uses MySQL to store the data.

### Note

The official game server is hosted at dungeon.ygstr.com, which is written in [OnlineConnection.cs](https://github.com/J-MOV/RaidersMarket/blob/bf02d0d0b1218004d7abb02da45944a4a31593c9/Assets/Scripts/OnlineConnection.cs#L73).
If you want to start your own server for testing, you need to edit OnlineConnection.cs and enter your own url (Most likely ws://localhost:1113)

## Setting up your own version of the server

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

When a user connects to the game server the client sends a token, stored in PlayerPrefs. If they don't have a token, they get sent a token and a new account is generated. Then if their account does not have a username, they are prompted to enter one.

```
+-----+--------------+------+-----+--------------------------------------+
| id  | username     | gold | lvl | token                                |
+-----+--------------+------+-----+--------------------------------------+
| 912 | Viktor       |  126 |   3 | 777ed08e-3069-4ef2-bb71-945aabf22f5b |
| 913 | Mehmet       |    5 |   2 | 23026907-141e-4202-8d17-59e3ad381151 |
| 920 | Olle         | 2100 |  16 | 8413a946-9398-428e-b332-e2bdab2a0b82 |
+-----+--------------+------+-----+--------------------------------------+
```

## Items

Every item spawned in the game is stored in the Items table. Once an item is created it cannot be destroyed and will stay in this table forever. Even when it is listed on the market and sold to another user, it's still the same entry. Every item has a unique pattern, from 0-1, randomly generated when it is spawned. Only a few items use this random pattern and change their color.

```
+------+------+--------------------+-------+----------+-------+----------+---------------------+---------+
| id   | item | pattern            | owner | for_sale | price | equipped | created             | creator |
+------+------+--------------------+-------+----------+-------+----------+---------------------+---------+
| 2870 |   16 | 0.8270828298971629 |   911 |        1 |   467 |        0 | 2021-02-26 13:32:58 |     911 |
| 2871 |   31 | 0.8974964486039725 |   912 |        0 |     0 |        1 | 2021-02-26 13:32:58 |     911 |
| 2872 |    3 |  0.291468415525173 |   912 |        0 |     0 |        0 | 2021-02-26 13:34:31 |     912 |
+------+------+--------------------+-------+----------+-------+----------+---------------------+---------+
```

## Items Index

This is all the indexed items in the game. They are dumped in sql_schemas/items_index.sql. Here the name, description, type and 3D model is listed. Every item spawned in the game inherits one of these and they determine the item "type". In the game code, indexed items are often referred to "origin". If pattern is true, the material color will change depending on the spawned item pattern, making every spawned item of this type unique.
The type makes sure you can only equip one of every type, and that they are spawned in the correct location.

### Item spawning

The rarities (0-4) and drop rates are:

-   Common 59.8%
-   Rare 25%
-   Epic 10%
-   Legendary 5%
-   Mythical 0.2%

When an item is generated (with every raid wave defeated) a rarity is first chosen, with respect to the drop rates above. Then all the items of this rarity are put in a pool, with an entry for every "loot" they have (1-10). This makes items with a lower loot value more rare, than others of the same rarity. The loot value is not presented to the players.

```
+----+-------------------+-------------------------------+---------+-----------------+--------+------+---------+----+------+
| id | name              | description                   | type    | model           | rarity | loot | pattern | hp | dmg  |
+----+-------------------+-------------------------------+---------+-----------------+--------+------+---------+----+------+
|  0 | Metal boots       | No Description                | feet    | Boots_1         |      1 |   10 |       0 | 20 |    0 |
|  1 | Royal Shirt       | No Description                | torso   | LionShirt       |      3 |    5 |       0 |  3 |    0 |
|  2 | Brown tail        | No Description                | hair    | Hair_1          |      0 |   10 |       0 |  2 |    0 |
|  3 | Metal Armor Torso | No Description                | torso   | Armor_1         |      1 |   10 |       0 | 50 |    0 |
|  4 | Horn Helmet       | No Description                | head    | HornHelmet      |      1 |   10 |       0 | 35 |    0 |
| 12 | Claymore          | A sword you can trust!        | weapon  | Claymore_1      |      2 |   10 |       0 |  0 |   15 |
| 13 | Face mask         | Keep safe!                    | face    | Facemask        |      0 |    1 |       0 | 10 |    0 |
| 14 | Brown beard       | No Description                | face    | Beard_1         |      0 |   10 |       0 |  3 |    0 |
| 15 | Starter Shield    | A shield for the Novice       | defense | Startershield   |      0 |   10 |       0 | 15 |    0 |
| 16 | Black Beard       | Pirate beard                  | face    | Beard_2         |      0 |    5 |       0 |  5 |    0 |
| 17 | Large Beard       | The Largest beard in the game | face    | LargeBlackBeard |      3 |   10 |       0 | 10 |    0 |
| 18 | Royal Shield      | Pure Royalty.                 | defense | Royalshield     |      3 |    3 |       0 | 40 |    0 |
| 19 | Plague Mask       | Stay extra safe!              | face    | PlagueMask      |      4 |   10 |       0 | 50 |    0 |
| 20 | Spear             | This is sparta!               | weapon  | Spear           |      0 |   10 |       0 |  0 |   10 |
| 21 | Plague Boots      | Boots for Doc.                | feet    | PlagueBoots     |      0 |    5 |       0 |  5 |    0 |
| 22 | Plague Case       | Supplies for Doc.             | defense | PlagueCase      |      1 |    5 |       0 | 30 |    0 |
| 23 | Plague Hat        | Hat for Doc.                  | head    | PlagueHat       |      2 |    5 |       0 | 10 |    0 |
| 24 | Plague Robe       | Warmth for Doc.               | torso   | PlagueRobe      |      3 |    5 |       0 | 10 |    0 |
| 25 | Plague Staff      | Support for Doc.              | weapon  | PlagueStaff     |      3 |    3 |       0 |  0 |   45 |
| 26 | Leather Boots     | Very warm boots.              | feet    | LeatherBoots    |      0 |    5 |       0 |  7 |    0 |
| 27 | Cross Robe        | Fashionable!                  | torso   | CrossCloth      |      2 |    5 |       0 | 10 |    0 |
| 28 | Metal Helmet      | Great stats!                  | head    | MetalHelmet     |      0 |   10 |       0 | 30 |    0 |
| 29 | Checkered Shield  | No Description                | defense | Checkeredshield |      2 |    2 |       1 | 30 |    0 |
| 30 | Cloth Mask        | Stay safest!                  | face    | ClothMask       |      4 |    6 |       1 | 65 |    0 |
| 31 | Novice Helmet     | A beginner helmet             | head    | NoviceHelmet    |      0 |   10 |       0 | 25 |    0 |
| 32 | Halberd           | No Description                | weapon  | Halberd         |      3 |    1 |       0 |  0 |   45 |
| 33 | Tower Shield      | No Description                | defense | TowerShield     |      2 |    3 |       1 | 50 |    0 |
| 34 | Scythe            | No Description                | weapon  | Scythe          |      2 |    6 |       0 |  0 |   30 |
+----+-------------------+-------------------------------+---------+-----------------+--------+------+---------+----+------+
```

## Raids

Every raid played is stored in this table. This is both to collect statistics data and prevent cheating. By analysing this data, we can determine if a user is cheating or not. With this data we can see How many raids a user plays on average, how long time it takes to complete a raid (for every level) and completion rate of raids

```
+-----+------+------+---------------------+---------------------+--------------+-------------+-----------+
| id  | user | lvl  | started             | ended               | earned_loot  | earned_gold | completed |
+-----+------+------+---------------------+---------------------+--------------+-------------+-----------+
| 368 |  911 |    1 | 2021-02-26 13:32:46 | 2021-02-26 13:32:58 | [16, 31]     |           9 |         1 |
| 369 |  912 |    1 | 2021-02-26 13:34:18 | 2021-02-26 13:34:31 | [3, 2]       |         107 |         0 |
| 370 |  912 |    2 | 2021-02-26 13:34:54 | NULL                | [15, 18, 14] |          24 |         0 |
+-----+------+------+---------------------+---------------------+--------------+-------------+-----------+
```

## Market Transactions

Every time an item is bought on the market, it is entered in this table.
This allows for the Item history features that shows all the market transactions of that item and market info such as: Last sold for, Lowest sold for. It can also help to prevent cheating. In the future we could graph the prices of items and analyze the price to rarity, price to item stats and price to hidden rarity ([See loot](#item-spawnning))

```
+----+--------+-------+------+-------+---------------------+
| id | seller | buyer | item | price | date                |
+----+--------+-------+------+-------+---------------------+
| 69 |    911 |   912 | 2871 |     5 | 2021-02-26 13:36:00 |
| 70 |    920 |   911 | 3083 |   130 | 2021-02-26 18:55:23 |
| 71 |    911 |   920 | 3083 |   253 | 2021-02-26 18:55:36 |
+----+--------+-------+------+-------+---------------------+
```
