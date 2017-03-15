+++
date = "2016-12-14T12:36:56Z"
title = "Indexes"
[menu.main]
  parent = "MongoKitten"
  identifier = "Indexes"
  weight = 25
  pre = "<i class='fa'></i>"
+++

# Indexes

Indexes allow you to quickly search for specific information. When you're frequently querying the same information it is recommended to create an index for this field. Do *not* index all your fields, this will actually reduce the performance of your application rather than increasing it.

## Text

Text indexes are used by MongoDB to allow you to query a collection for Documents matching the text. Like a search engine.

They are easily created like this:
```swift
try collection.createIndex(withParameters: .text(["keys", "in", "document"]))
```

[Querying text indexes using the query builder is simple.]({{< relref "tutorials/mongokitten/QueryBuilder.md#text-searching" >}})

## Unique

Unique indexes require any documents inserted in the collection to have a unique value for this key.

```swift
try collection.createIndex(withParameters: .unique, .compound(fields: [
    "uniqueKey": 1,
    "otherUniqueKey": 1
]))
```
