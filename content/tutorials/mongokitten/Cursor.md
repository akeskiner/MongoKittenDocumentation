+++
date = "2016-12-14T12:36:56Z"
title = "Cursor"
[menu.main]
  parent = "Tutorials"
  identifier = "Cursor"
  weight = 41
  pre = "<i class='fa'></i>"
+++

# Cursor

Cursors are a selector for a subset of data in MongoDB. It can be queried again to extract a subset and most operations can be executed on it. Count, Read, Update, Remove.

## Usage

```swift
let childrenDocuments: Cursor<Document> = Cursor<Document>(in: database["users"], where: "age" < 18)

struct User {
  ...

  init?(userDocument: Document) throws {
    ...
  }
}

// flatmaps all results
let childrenUserObjects: Cursor<User> = Cursor(in: database["users"], where: "age" < 18) { document in
  return try User.init(userDocument: document)
}

// puts all users that are under 18 in an Array
let users: [User] = Array(childrenUserObjects)

let transformedChildrenUserObjects: Cursor<User> = childrenDocuments.flatMap { document in
  return try User.init(userDocument: document)
}

// Sets "child" to `true` for all children
try transformedChildrenUserObjects.update(to: [
  "$set": [
    "isChild": true
  ]
])

for child in transformedChildrenUserObjects {
  print(Int(child["age"])) // prints their age
}

// removes all selected users
try childrenUserObjects.remove()

// All children have been removed, doesn't return any results

for user in try childrenUserObjects.find() {
  // never runs
}
```
