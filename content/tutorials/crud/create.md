+++
date = "2016-12-14T12:36:56Z"
title = "Create/Insert"
[menu.main]
  parent = "CRUD"
  identifier = "Create"
  weight = 0
  pre = "<i class='fa'></i>"
+++

# Creation

You can create an entry in MongoDB by `insert`ing a Document into a Collection.

`let identifier = try collection.insert(document)`

The returned identifier is the `_id` field in the Document. If no `_id` exists in the provided Document parameter an ObjectId will be generated. The `_id` field can be of almost any value.

ObjectId keeps track of the creation date and is unique. Int32 and Int64 can be used incrementally like is usual in SQL. Strings can also be used. When you're inserting a Document which primarily contains a unique String (like a database migration's description) this description can be the `_id` of the Document.

No two Documents can exist in the same collection with the same `_id`.

You can also insert an array of Documents which will all be inserted. MongoKitten will return an array of identifiers for each inserted Document.

`let identifiers = try collection.insert([document0, document1, document2])`
