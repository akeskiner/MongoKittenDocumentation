+++
date = "2016-12-14T12:36:56Z"
title = "Models"
[menu.main]
  parent = "meowmongo"
  identifier = "Models"
  weight = 20
+++

# Models

On this page we'll cover how to create your models

## Setting up a basic model

For models you can use either a class or a struct.

This example uses a class since I regard Users as a reference to a singular instance of this information. There can never be two identical users unlike some other types of data like Articles. The only requirement for models of any kind is the uniqueness of the identifier. Luckily, this is handled by the ORM.

To prevent possible bugs from arising we suggest `var id = ObjectId()` for the identifier. This way you know that new models always have a new unique ID whilst old models get their id overwritten by the ORM.

```swift
final class User : Model {
  var id = ObjectId()
}
```

As you see, we didn't have to write any (de)-serialization code. This is taken care of by `sourcery`, as covered in [the overview page.]({{< relref "tutorials/meowmongo/index.md" >}})

## Expanding the model

MeowMongo works with native Swift types, which means that you can use the types you're used to. For a full list of supported data types, see [the supported data types page.]({{< relref "tutorials/meowmongo/Types.md" >}})

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

## Embeddables

Embeddables are classes, structs or enums that exist within a model or another Embeddable.

If you want to make use of nested/recursive structures, you can conform your structure to `Embeddable`. The rest is taken care of when running `sourcery`. Embeddables are queryable through the type-safe query language.

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
