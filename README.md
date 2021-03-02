# Server for our Unity mobile game

This is the server for our unity mobile game. It keeps track of all users who are
identified with an authentication token given on the first startup of the game.
The item contains infromation about all kinds of items [Indexed Items](#items-index) that store name, rarity and 3D asset of the item. When an item is created it is inserted into the [Items](#dropped-items) table. This is an actual item, one of a kind that has an owner, unique identifier and a market status.

The server also saves all market transactions so a market history can be displayed for the players and also analyzed by us.

# Explanation of the database structure

## Users

```
+-----+----------+------+-----+--------------------------------------+
| id  | username | gold | lvl | token                                |
+-----+----------+------+-----+--------------------------------------+
| 920 | Olle     | 2100 |  16 | 4013a946-9398-428e-b352-e2bdab8a0b82 |
| 915 | Scrub    |  469 |   9 | e5490d89-d351-462c-9041-faf1180f8172 |
| 918 | Aysel    |  304 |   9 | 883a21a4-8ae4-4bfd-917e-0dab5e1bed4b |
+-----+----------+------+-----+--------------------------------------+
```

## Items

```
+------+------+--------------------+-------+----------+-------+----------+---------------------+---------+
| id   | item | pattern            | owner | for_sale | price | equipped | created             | creator |
+------+------+--------------------+-------+----------+-------+----------+---------------------+---------+
| 2870 |   16 | 0.8270828298971629 |   911 |        1 | 86467 |        0 | 2021-02-26 13:32:58 |     911 |
| 2871 |   31 | 0.8974964486039725 |   912 |        0 |     0 |        1 | 2021-02-26 13:32:58 |     911 |
| 2872 |    3 |  0.291468415525173 |   912 |        0 |     0 |        1 | 2021-02-26 13:34:31 |     912 |
+------+------+--------------------+-------+----------+-------+----------+---------------------+---------+
```
