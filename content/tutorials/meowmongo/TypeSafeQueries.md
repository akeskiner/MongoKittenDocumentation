+++
date = "2016-12-14T12:36:56Z"
title = "Type-Safe Queries"
[menu.main]
  parent = "meowmongo"
  identifier = "t-s-queries"
  weight = 20
+++

# Querying data

Type-safe queries look similar to Swift's `array.filter`. You query a Model like `User` similar to filtering an array containing all users.

Most functions and operators that result in a boolean are available in this query language. This means `user.age > 18`, `< 24`, `>= 7` and `<= 9` are all accepted operators.

Besides this, `==` and `!=` work for all [supported data types.]({{< relref "tutorials/meowmongo/Types.md" >}})

`enum` cases, like the example underneath can be compared, too:

```swift
class User : Model {
  var id = ObjectId()
  var gender: Gender

  init(gender: Gender) {
    self.gender = gender
  }
}

enum Gender: String, Embeddable {
case male, female, other
}

let femaleUsers = try User.find { user in
  return user.gender == .female
}
```

Below you can find a few examples that work on models [shown in the Models tutorial.]({{< relref "tutorials/meowmongo/Models.md" >}})

```swift
let allAdultUsers = try User.find { user in
  return user.profile.age >= 18
}

let joannisUser = try User.findOne { user in
  return user.username == "Joannis"
}

let femaleUser = try User.findOne { user in
  return user.profile.gender == .female
}

let gmailUsers = try User.find { user in
  return user.hasSuffix("gmail.com")
}
```

## Storing/removing users

Saving and deleting entities is simple, as it should be.

```swift
// Updates the user entity if it exists, creates a new one otherwise.
try user.save()

// Removes the user
try user.delete()

// Re-creates the user, since it doesn't exist anymore
try user.save()
```

## Using more powerful features in MongoDB

All models have a `meowCollection` variable. This points to the collection where this entity resides.

`User.meowCollection.find()` will return an `AnyIterator<Document>`, as expected from `MongoKitten.Collection`.
