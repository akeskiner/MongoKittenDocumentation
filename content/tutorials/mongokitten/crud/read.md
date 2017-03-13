+++
date = "2016-12-14T12:36:56Z"
title = "Read/Find"
[menu.main]
  parent = "CRUD"
  identifier = "Reading"
  weight = 10
  pre = "<i class='fa'></i>"
+++

# Reading/finding

`find` can be ran without arguments to fetch every Document in the collection.

`try collection.find()` will return a [Cursor]({{< relref "tutorials/mongokitten/Cursor.md" >}}) containing all Documents. Cursors are an important part of the MongoKitten flow but we'll cover them in short here.

`try collection.findOne()` will return a single `Document?`. Which is nil if no Document could be found.

The `Array` initializer can be used on the Cursor to create an `Array<Document>` containing all results.
This is recommended when you definitely need all results. Looping over a Cursor is recommended when you don't necessarily need all results and might stop in the middle of the process. `Array` isn't any better than Cursor other than providing the ability to count the results without an extra query. However, it does use more RAM.

```swift
let documentArray = Array(try collection.find())
```

You can specify 6 parameters which we'll all cover underneath which, of course, can be combined.

`find` accepts [a Query]({{< relref "tutorials/mongokitten/QueryBuilder.md" >}}) that Documents are matched against. You can create a Query from a Document or using operators.

```swift
let query: Query = [
  "username": "bob"
]

try collection.find(matching: query)
```

```swift
let query: Query = "username" == "bob"

try collection.find(matching: query)
```

If the order of the results matters, for example, when presenting your user a table of results based on their preference. Alphabetically, numerically or otherwise, you can specify a `Sort` order where you can specify per-field the order in which the fields must be sorted.

```swift
let sort: Sort = [
  "integer": .ascending,
  "date": .descending
]

try collection.find(sortedBy: sort)
```

If you don't need all information from the Document you can more efficiently fetch data by providing a projection. The `_id` key will be included unless specifically disabled.

Suppose the following Document resides in the database:

```swift
let document: Document = [
  "_id": try ObjectId("abcdefabcdefabcdefabcdef"),
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
try collection.find(projecting: projection0)
try collection.find(projecting: projection1)
try collection.find(projecting: ["_id": false, "key0": .included])
```

If you don't want the first X results you can skip those. If 5 documents match the find query and the skip is set so 4, the last Document is returned. If the skip is set to 2, the last 3 documents will be returned. If the skip is set to 5, no Documents will be returned.

```swift
try collection.find(skipping: 3)
```

And if you don't want more than X results you can specify a limit. If 5 documents match the find query and the limit is set to 7, 5 Documents will be returned. If the limit is set to 3, the first 3 Documents will be returned.

```swift
try collection.find(limitedTo: 3)
```

Find queries also accept a batchSize.

The batch size is important with respect to efficiency and performance. Cursors return `batchSize` of Documents with every fetch. And a fetch is done whenever more Documents are required. When looping over a cursor containing 100 Documents with a batchSize of 10, 10 queries will be done to fetch all results. The default value is 100 Documents per query. A Document can be up to 16 MB and MongoDB usually only communicates 48 MB per message.

If you're fetching a lot of small Documents a higher batchSize is useful. If you're fetching a lot of big Documents, a smaller batchSize is necessary. And if you're fetching and processing all Documents like `Array(collection.find(...))` or a `for document in collection.find(...)` that doesn't break out of the loop it's generally better to fetch more Documents per query to reduce the amount of communication and delay.

Most MongoDB servers don't accept values over 1000.
