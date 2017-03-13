+++
date = "2016-12-14T12:36:56Z"
title = "Update"
[menu.main]
  parent = "CRUD"
  identifier = "Update"
  weight = 20
  pre = "<i class='fa'></i>"
+++

# Updating

Updates are usually formed using ([a filter Query]({{< relref "tutorials/mongokitten/QueryBuilder.md" >}}) object) and an update document.

[Queries are covered here.]({{< relref "tutorials/mongokitten/QueryBuilder.md" >}})

Update finds already existing Documents in the collection that match the query/filter and updates them to the `to` Document and will overwrite the existing Document with the new Document.

Assuming the following Document resides in the database:

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

Executing the following query:

```swift
let document = [
  "key0": "bob",
  "key1": false
]

try collection.update(matching: "_id" == try ObjectId("abcdefabcdefabcdefabcdef"), to: document)
```

Will result in the following database Document:

```swift
let document = [
  "_id": try ObjectId("abcdefabcdefabcdefabcdef"),
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

try collection.update(matching: "_id" == try ObjectId("abcdefabcdefabcdefabcdef"), to: document)
```

Will result in the following Document.

```swift
let document: Document = [
  "_id": try ObjectId("abcdefabcdefabcdefabcdef"),
  "key0": "bob",
  "key1": false,
  "key2": 3,
  "key3": [
    "key4": "value0"
  ]
]
```

If you're working with a Document that may or may not already exist in the database, like an ORM's Model, you can upsert the Document. This will try to update the document matching your filter with the new Document but will insert the Document if nothing matches the filter.

```swift
var document: Document = [
  "_id": try ObjectId("abcdefabcdefabcdefabcdef"),
  "key0": "bob",
  "key1": false,
  "key2": 3,
  "key3": [
    "key4": "value0"
  ]
]

// Insert the document
try collection.insert(document)

// Remove the document
try collection.remove(matching: "_id" == try ObjectId("abcdefabcdefabcdefabcdef"))

document["key2"] = 5

// The document doesn't exist anymore, so it will be upserted
collection.update(matching: "_id" == try ObjectId("abcdefabcdefabcdefabcdef"), to: document, upserting: true)

document["key1"] = true

// The document already exist, so it will be updated
collection.update(matching: "_id" == try ObjectId("abcdefabcdefabcdefabcdef"), to: document, upserting: true)
```

By default, only one (the first) matching Document will be updated. If you want to update all documents you'll need to specify `multiple:` to be `true`.

```swift
let document = [
  "$set": [
    "key0": "bob",
    "key1": false
  ]
]

// Updates all documents with the $set query
try collection.update(to: document, multiple: true)
```

[For more information on updating documents in MongoKitten, click here.](http://mongokitten.openkitten.org/Classes/Collection.html#/s:FC11MongoKitten10Collection6updateFzT8matchingVS_5Query2toV4BSON8Document9upsertingSb8multipleSb12writeConcernGSqOS_12WriteConcern_15stoppingOnErrorGSqSb__Si)
