# Cool, currently untitled game.

## Items index

The items index is the list of all items in the game.

![](readme-images/items-index.png)

-   Name is the display name of the item in game.
-   Model is the name of the prefab used in Unity. Rarity
-   Rarity is the rarity level 0-4 ([See rarities](#rarities))
-   Loot is the loot table attribute, when an item is dropped and the rarity is determend all items of the same rarity enter a draft and the loot number is how many chances that item has to win. So the smallar loot number, the rarer the item.

## Dropped items

Dropped items are all stored in one table, this includes all items listed on the market.

-   Item is the ID of this item, references back to the items index.
-   Owner is the ID of the current item owner
-   For_Sale shows if the item is currently listed on the market.
-   Price is the listed price on the market, this is only used if the item is actually listed.
-   Float is the random float number assigned when dropped. This makes every item unique and can change the look of the item slightly.

![](readme-images/database-items-sh.png)

## Rarities

Rarity determens how likley an item is to drop aswell as the color of the item type.
The rarities goes from (0-4) Common (Gray), Rare (Blue), Epic (Pink), Legendary (Yellow), Mythical (Red)

**Note** the loot attribute also changes how rare the items are to drop, but they are not visible to the player.

## Users

![](readme-images/users.png)

-   Username is choosen when the users first starts the game.
-   Gold is the amount of gold the user has.
-   Lvl is the highest cleared raid level of the user
-   Token is the login token that the users recieves when they first start the game and is always used when doing actions online to authenticate the user.

## Market transactions

Every item exchange is recorded in this table.
With this data an item can be tracked through every transfer it has made.

![](readme-images/market-transactions.png)
