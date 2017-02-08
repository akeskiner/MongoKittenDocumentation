+++
date = "2016-12-14T12:36:56Z"
title = "Count"
[menu.main]
  parent = "CRUD"
  identifier = "Count"
  weight = 50
  pre = "<i class='fa'></i>"
+++

# Counting

`count` can be used on a collection to count all Documents matching the provided requirements. If no requirements are provided, all documents will be counted.

`count` will return the amount of matches.

```swift
try collection.count() // returns 5
```

Count also accepts the parameter `matching` which requires [a Query]({{< relref "tutorials/QueryBuilder.md" >}}) to be provided.

```swift
try collection.count(matching: "first_name" == "Joannis") // returns 1 if only one user is named Joannis
```

[For more information about counting documents, click here](http://mongokitten.openkitten.org/Classes/Collection.html#/s:FC11MongoKitten10Collection5countFzT8matchingGSqVS_5Query_9limitedToGSqVs5Int32_8skippingGSqS2__11readConcernGSqOS_11ReadConcern_9collationGSqVS_9Collation__Si)
