+++
date = "2016-12-14T12:36:56Z"
title = "Meow Mongo"
[menu.main]
  parent = "Tutorials"
  identifier = "meowmongo"
  weight = 20
+++

# (Meow)Mongo ORM

MeowMongo is a MongoKitten based ORM using code generation.

It's USPs are a type-safe query language, type-safe index builder and a easy set up.

## Installation

[Install Sourcery](https://github.com/krzysztofzablocki/Sourcery#installing) to get access to the main USPs of this ORM.

And include this in your Package.swift

```
  dependencies: [
    .Package(url: "https://github.com/OpenKitten/MeowMongo.git", majorVersion: 1)
  ]
```

## Setting up a basic model

After including the MeowMongo dependency you can now create a model using a class or a struct.

This example uses a class since I regard Users as a reference to the database entity.

```swift
final class User : Model {
  var id = ObjectId()
}
```

As you see, we didn't have to write any (de)-serialization code.

## Expanding the model

MeowMongo works with native Swift types, which means that we can use the types we're used to.

```swift
final class User : Model {
  var id = ObjectId()
  var username: String
  var password: String
  var email: String
  var favouriteNumber: Int? = nil
  var favouriteFoods = [String]()

  init(username: String, password: String) {
    self.username = username
    self.password = password
  }
}
```

If you want to make use of nested/recursive structures, you can conform your structure to `Embeddable`.

This also supports enums.

```swift
final class User : Model {
  var profile: Profile
  /// ..., the rest of the User code like `id` and the other functions/variables
}

struct Profile : Embeddable {
  var firstName: String
  var lastName: String
  var age: Int
  var gender: Gender
}

enum Gender : String, Embeddable {
  case male, female
}
```

## Generating the rest with Sourcery

Assuming your terminal's PWD is the project root where `Package.swift` resides:

```sh
sourcery ./Sources/ .build/checkouts/MeowMongo*/Templates ./Sources/Generated.swift
```

This will scan your sources and generate a new file called `Generated.swift` in your project.

The first time you add this file you will need to regenerate the Xcode project:

```sh
swift package generate-xcodeproj
```

### Frequently updated models

If you frequently update your models, add `--watch` to the sourcery command to update whenever a change is detected.

```sh
sourcery ./Sources/ .build/checkouts/MeowMongo*/Templates ./Sources/Generated.swift --watch
```

## Using the cool new query language

First, let's try the most important part, type-safe queries:

```swift
let allAdultUsers = try User.find { user in
  return user.profile.age >= 18
}

let joannisUser = try User.findOne { user in
  return user.username == "Joannis"
}

let femaleUsers = try User.findOne { user in
  return user.profile.gender == .female
}

let gmailUsers = try User.find { user in
  return user.hasSuffix("gmail.com")
}
```

## Storing/removing users

```swift
try user.save()
try user.delete()
```
