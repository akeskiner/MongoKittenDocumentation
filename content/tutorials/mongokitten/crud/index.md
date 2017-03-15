+++
date = "2016-12-14T12:36:56Z"
title = "Collection CRUD Operations"
[menu.main]
  parent = "MongoKitten"
  identifier = "CRUD"
  weight = 50
  pre = "<i class='fa'></i>"
+++

# CRUD

In [the setup guide]({{< relref "tutorials/mongokitten/connect/index.md" >}}) we've covered how you can open a Database and from there a Collection. Collections are the storage place in MongoDB like tables for SQL databases.

From a collection object we can start interacting with our data. From here we'll cover all parts of CRUD.
(Create, Read, Update, Delete). And we'll assume you have a Collection available as the variable `collection`.
