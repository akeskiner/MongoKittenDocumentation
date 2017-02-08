+++
title = "Administration"
date = "2016-12-14T12:57:41+01:00"
[menu.main]
  parent = "Tutorials"
  identifier = "Administration"
  weight = 55
  pre = "<i class='fa'></i>"
+++

# Administration

## Creating collections

This assumes you've got a Database object available which can be constructed or accessed from a Server.

`try database.createCollection(named: "myCollectionName")`

This also accepts database options which are described [here](https://docs.mongodb.com/v3.2/reference/command/create/#definition). The provided collection name is used for the key "create".

## Dropping/removing databases and collections

`try database.drop()` or `try collection.drop()`

## Modifying collections

This requires flags to be provided as a Document.
All available flags can be found [here.](https://docs.mongodb.com/manual/reference/command/collMod/#flags)

`try collection.modify(flags: flags)`

## Renaming collections

`try collection.rename(to: "newCollectionName")`
