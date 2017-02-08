+++
date = "2016-12-14T12:36:56Z"
title = "Cursor"
[menu.main]
  parent = "Tutorials"
  identifier = "Cursor"
  weight = 20
  pre = "<i class='fa'></i>"
+++

# Cursor

All larger result sets in MongoKitten are encapsulated in a Cursor.

Cursors are a pointer to a set of data on the MongoDB instance, not locally in-memory.
When looped over the cursor's contents the Cursor will fetch a batch X Documents from the server and make them available to the user. Whenever more are requested the Cursor will fetch the next batch of Documents. The amount of Documents fetched at a time is configurable in most commands with a `withBatchSize` parameter.

A big amount of Documents could benefit enormously from `withBatchSize` at 1000 but the Document grouped together may not be bigger than 48MB. Luckily, this rarely happens unless you store binary data like images inside the Documents. A batchSize of 1000 would still leave 48KB of data per Document.

## Mapping/Transforming

When you're executing a `find` command on a Collection, it's likely this collection stores data of a certain type. Like all users, all articles etc. For this purpose Cursor has a mechanism to map incoming Documents to other types or even those other types to more specialized types.

Assuming you have stored `Cursor<Document>` received from calling a `find` method on Collection:

```swift
import BSON
import MongoKitten

struct User {
  let username: String
  init?(fromDocument document: Document) {
    guard let username = document["username"] as String? else {
      return nil
    }

    self.username = username
  }
}

let usersCursor = Cursor(basicDocumentCursor) { document in
  return User(fromDocument: document)
}
```
