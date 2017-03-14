+++
date = "2016-12-14T12:36:56Z"
title = "QueryBuilder"
[menu.main]
  parent = "MongoKitten"
  identifier = "QueryBuilder"
  weight = 11
  pre = "<i class='fa'></i>"
+++

# Query

Query is the object that will find data for you. It's used in all CRUD operations except insert. It's used for finding the Document you want to fetch/modify/delete.

There are two method of creating a Query. You can create a Query manually from a Document or you can use the operators. Operator based queries are means for simple queries only.

This would be an example of an operator based query

```swift
let firstName = "Bob"
let surName = "de Boer"
let query: Query = "name_first" == firstName

try usersCollection.findOne(matching: "name_first" == firstName && "name_last" == surName && "age" < 24)
```

From here on we'll only define the Query, and we'll leave it up to you to put it in a matching parameter of a Count/Read/Update/Delete operation.

## Helpers

QueryBuilder has a few build-in helpers.

### $text searching

If you're looking for a piece of text in a document you can use `.textSearch` like this:

```swift
let query: Query = .textSearch(forString: "cookie")
```

This will match any documents in the collection where the text index has indexed a field in the Document to contain "cookie".

This will require you to create a [text index]({{< relref "tutorials/mongokitten/Indexes.md#text" >}}).

## Raw

If you're in need for more raw MongoDB queries you can create one from a Document.

```swift
let document: Document = [
  "name_first": firstName,
  "name_last": surName,
  "age": [ "$lt": 24]
]

try usersCollection.findOne(matching: Query(document))
```

Or you can use a Document literal for a Query:

```swift
try usersCollection.findOne(matching: [
  "name_first": firstName,
  "name_last": surName,
  "age": [ "$lt": 24]
])
```
