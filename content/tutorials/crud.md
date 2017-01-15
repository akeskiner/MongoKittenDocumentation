+++
date = "2016-12-14T12:36:56Z"
title = "CRUD Operations"
[menu.main]
  parent = "Tutorials"
  identifier = "CRUD Operations"
  weight = 40
  pre = "<i class='fa'></i>"
+++

# CRUD

In [the setup guide]({{< relref "tutorials/connect.md" >}}) we've covered how you can open a Database and from there a Collection. Collections are the storage place in MongoDB like tables for SQL databases.

From a collection object we can start interacting with our data. From here we'll cover all parts of CRUD.
(Create, Read, Update, Delete). And we'll assume you have a Collection available as the variable `collection`.

## Creation

You can create an entry in MongoDB by `insert`ing a Document into a Collection.

`let identifier = try collection.insert(document)`

The returned identifier is the `_id` field in the Document. If no `_id` exists in the provided Document parameter an ObjectId will be generated. The `_id` field can be of almost any value.

ObjectId keeps track of the creation date and is unique. Int32 and Int64 can be used incrementally like is usual in SQL. Strings can also be used. When you're inserting a Document which primarily contains a unique String (like a database migration's description) this description can be the `_id` of the Document.

No two Documents can exist in the same collection with the same `_id`.

You can also insert an array of Documents which will all be inserted. MongoKitten will return an array of identifiers for each inserted Document.

`let identifiers = try collection.insert([document0, document1, document2])`

## Reading/finding

`find` can be ran without arguments to fetch every Document in the collection.

`try collection.find()` will return a [Cursor]({{< relref "tutorials/Cursor.md" >}}) containing all Documents. Cursors are an important part of the MongoKitten flow but we'll cover them in short here.

`try collection.findOne()` will return a single `Document?`. Which is nil if no Document could be found.

The `Array` initializer can be used on the Cursor to create an `Array<Document>` containing all results.
This is recommended when you definitely need all results. Looping over a Cursor is recommended when you don't necessarily need all results and might stop in the middle of the process. `Array` isn't any better than Cursor other than providing the ability to count the results without an extra query. However, it does use more RAM.

```swift
let documentArray = Array(try collection.find())
```

You can specify 6 parameters which we'll all cover underneath which, of course, can be combined.

### matching

`find` accepts a Query that Documents are matched against. You can create a Query from a Document or using operators.

```swift
let document = [
  "username": "bob"
]
let query = Query(document)

try collection.find(matching: query)
```

```swift
let query: Query = "username" == "bob"

try collection.find(matching: query)
```

### sortedBy

This accepts a `Sort` object which can be created with a Dictionary literal.

```swift
let sort: Sort = [
  "integer": .ascending,
  "date": .descending
]

try collection.find(sortedBy: sort)
```

### projecting

Accepts a projection that projects the fields that should be returned. The `_id` key will be included unless specifically disabled.

Suppose the following Document resides in the database:

```swift
let document: Document = [
  "_id": ObjectId("abcdefabcdefabcdefabcdef"),
  "key0": "henk",
  "key1": true,
  "key2": 3,
  "key3": [
    "key4": "value0"
  ]
]
```

The following projection will return the keys `_id`, `key1` and `key2`.

```swift
let projection: Projection = ["key1", "key2"]
```

The following projections will return `key2` and `key3`.

```swift
let projection0: Projection = [
  "_id": false,
  "key2": true,
  "key3": true
]

let projection1: Projection = [
  "_id": .excluded,
  "key2": .included,
  "key3": .included
]
```

Applying this projection to limit the returned fields is simple:

```swift
try collection.find(projecting: projection)
try collection.find(projecting: ["_id": false, "key0": true])
```

### skipping

Accepts an Int32 that skips the first X results where X is the provided number. If 5 documents match the find query and the skip is set so 4, the last Document is returned. If the skip is set to 2, the last 3 documents will be returned. If the skip is set to 5, no Documents will be returned.

```swift
try collection.find(skipping: 3)
```

### limitedTo

Accepts an Int32 that limits the returned results to be less or equal to the limit. If 5 documents match the find query and the limit is set to 7, 5 Documents will be returned. If the limit is set to 3, the first 3 Documents will be returned.

```swift
try collection.find(limitedTo: 3)
```

### withBatchSize

The batch size is important with respect to efficiency and performance. Cursors return `batchSize` of Documents with every fetch. And a fetch is done whenever more Documents are required. When looping over a cursor containing 100 Documents with a batchSize of 10, 10 queries will be done to fetch all results. The default value is 10 Documents per query because a Document can be up to 16 MB and MongoDB usually only communicates 48 MB per message.

If you're fetching a lot of small Documents a higher batchSize is useful. If you're fetching a lot of big Documents, a smaller batchSize is necessary. And if you're fetching and processing all Documents like `Array(collection.find(...))` or a `for document in collection.find(...)` that doesn't break out of the loop it's generally better to fetch more Documents per query to reduce the amount of communication and delay.

Most MongoDB servers don't accept values over 1000.

## Updating

Update comes in two forms. Bulk and single updates.

### Single updates

Single updates are formed using a single filter ([Query]({{< relref "tutorials/QueryBuilder.md" >}}) object) and a single update document.

[Queries are covered here.]({{< relref "tutorials/QueryBuilder.md" >}})

Update finds already existing Documents in the collection that match the query/filter and updates them to the `to` Document and will overwrite the existing Document with the new Document.

Assuming the following Document resides in the database:

```swift
let document: Document = [
  "_id": ObjectId("abcdefabcdefabcdefabcdef"),
  "key0": "henk",
  "key1": true,
  "key2": 3,
  "key3": [
    "key4": "value0"
  ]
]
```

Executing the following query:

```swift
let document = [
  "key0": "bob",
  "key1": false
]

try collection.update(matching: "_id" == ObjectId("abcdefabcdefabcdefabcdef"), to: document)
```

Will result in the following database Document:

```swift
let document = [
  "_id": ObjectId("abcdefabcdefabcdefabcdef"),
  "key0": "bob",
  "key1": false
]
```

However the following query:

```swift
let document = [
  "$set": [
    "key0": "bob",
    "key1": false
  ]
]

try collection.update(matching: "_id" == ObjectId("abcdefabcdefabcdefabcdef"), to: document)
```

Will result in the following Document.

```swift
let document: Document = [
  "_id": ObjectId("abcdefabcdefabcdefabcdef"),
  "key0": "bob",
  "key1": false,
  "key2": 3,
  "key3": [
    "key4": "value0"
  ]
]
```

### upserting

If `true`, the `to` Document will be inserted if no matching Documents were found to update.

### multiple

If `true`, this operation will update *all* Documents matching the filter to the `to` Document. If `$set` is used to overwrite only the `$set` key-value pairs, all Documents matching will have the keys overridden. Otherwise the new `to` Document will be used for all matching Documents and all non-matching keys will be removed.

### Multiple updates

TODO for signature

`public func update(_ updates: [(filter: Query, to: Document, upserting: Bool, multiple: Bool)], stoppingOnError ordered: Bool? = nil) throws -> Int {`

## Counting

`count` can be used on a collection to count all Documents matching the provided requirements. If no requirements are provided, all documents will be counted.

`count` will return the amount of updated matches.

```swift
try collection.count() // returns 5
```

### matching

Count accepts the parameter `matching` which requires a Query to be provided.

```swift
try collection.count(matching: "first_name" == "Joannis") // returns 1 if only one user is named Joannis
```

### limitedTo

Limits the results that will be counted.

```swift
try collection.count(limitedTo: 4) // returns 4, even if 5 users reside in the database
```

### skipping

Skips X matching documents before counting.

```swift
try collection.count(skipping: 3) // returns 2, even if 5 users reside in the database
try collection.count(limitedTo: 2, skipping: 4) // Will return 1 in this scenario. 4 will be skipped and only 1 remains to be counted.
```

## Removing

`remove` removes all Documents matching the query but can be limited in the amount of removals. It will return the amount of objects that have been removed.

```swift
try collection.remove() // returns 5
```

The above example will remove all Documents.

### matching

Acts like all other matchers and expects a Query object. Only Documents matching the Query will be removed.

```swift
try collection.remove(matching: "first_name" == "Joannis") // Returns 1, only one user named "Joannis" exists
```

### limitedTo

Will not return more than X Documents from the collection, even if more Documents match. Will return the first created Documents first.

```swift
try collection.remove(limitedTo: 3) // returns 3, even if 5 or more Documents exist
```
