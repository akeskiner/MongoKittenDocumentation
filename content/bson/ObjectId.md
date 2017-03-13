+++
title = "ObjectId"
date = "2016-12-26T12:13:13+01:00"
[menu.main]
  parent = "BSON"
  identifier = "ObjectId"
  weight = 83
  pre = "<i class='fa'></i>"
+++

# ObjectId

ObjectId is the primary form of identification in MongoDB. ObjectId is a 12 bytes long identifier consisting of non- pseudo- and fully random components.

ObjectId contains metadata about the creation date in UNIX epoch time, the machine identifer and process ID that created it as well as a random number that's incremented.

ObjectId is often represented as a 24-character hexadecimal string which is useful in places like an URL

I.E. `https://example.com/users/1234567890abcdef12345678/profile`

MongoKitten ObjectId values are easily generated using an empty initializer: `ObjectId()`.

Alternatively they're initializable using a hexadecimal String representation like `"1234567890abcdef12345678"`.

```swift
let hexString = "1234567890abcdef12345678"
let objectId = try ObjectId(hexString)
```

In some cases you might want to know the ObjectIds creation date. You can fetch a `Foundation.Date` from the ObjectId using `let objectIdCreationDate = myObjectId.epoch`

Last but not least, ObjectIds are hashable, so they're usable for a key in a Dictionary, but not a Document.

```swift
let dictionary: [ObjectId: Document] = [
  ObjectId(): ...,
  ObjectId(): ...
]
```

In the case of MongoKitten/MongoDB this may be useful when you're creating a cache for information from the database. Instead of re-fetching this data from the database you can identify the data using the ObjectId identifier easily.
