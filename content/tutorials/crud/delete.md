+++
date = "2016-12-14T12:36:56Z"
title = "Delete/Remove"
[menu.main]
  parent = "CRUD"
  identifier = "Delete"
  weight = 30
  pre = "<i class='fa'></i>"
+++

# Removing documents

`remove` removes all Documents (matching the query) but can be limited in the amount of removals. It will return the amount of objects that have been removed.

```swift
try collection.remove() // returns 5
```

The above example will remove all Documents.

You can specify requirements for the documents that will be removed by adding a `matching:` parameter. [In there you must provide a Query.]({{< relref "tutorials/QueryBuilder.md" >}})

```swift
try collection.remove(matching: "first_name" == "Joannis") // Returns 1, only one user named "Joannis" exists
```

If you only want to remove one matching document:

```swift
try collection.remove(limitedTo: 1) // returns 1, only one Document may be removed. Any document will do because there is no matching filter
```

[For more information about removing documents, click here](http://mongokitten.openkitten.org/Classes/Collection.html#/s:FC11MongoKitten10Collection6removeFzT8matchingGSaT6filterVS_5Query5limitVs5Int32__12writeConcernGSqOS_12WriteConcern_15stoppingOnErrorGSqSb__Si)
