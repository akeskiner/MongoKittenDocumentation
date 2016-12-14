+++
date = "2016-12-14T12:36:56Z"
title = "QueryBuilder"
[menu.main]
  parent = "Tutorials"
  identifier = "Aggregation"
  weight = 79
  pre = "<i class='fa'></i>"
+++

# QueryBuilder

Query is the object that will find data for you. It's used in all CRUD operations except insert. It's used for finding the Document you want to fetch/modify/delete.

There are two method of creating a Query. You can create a Query manually from a Document or you can use the operators. Operator based queries are means for simple queries only.

This would be an example of an operator based query

```swift
let firstName = "Bob"
let surName = "de Boer"
let query: Query = "name_first" == firstName

try usersCollection.findOne(matching: "name_first" == firstName && "name_last" == surName && "age" < 24)
```

If you're in need for more advanced MongoDB queries you can create one from a Document.

```swift
let document: Document = [
  "name_first": firstName,
  "name_last": surName,
  "age": [ "$lt": 24]
]

try usersCollection.findOne(matching: Query(document))
```