+++
date = "2016-12-14T12:36:56Z"
title = "Vapor"
[menu.main]
  parent = "Frameworks"
  identifier = "vapor"
  weight = 20
+++

# Vapor

Vapor is the most popular Swift web framework. Many people use it happily.
It has a highly readable API and is written in the same language you use to interact with it, Swift.

For each library there are different possible integrations that can be created. Some overlap.

## MongoKitten

When you're using one of the above three libraries, one of the types you'll often use is ObjectId. It is a lightweight unique identifier that is easily representable as a String due to it's relatively small binary size.

ObjectIds are often expressed as a 24-character hexadecimal string. No wonder that it's often used in URLs to identify an article, user profile or other database entity.

```swift
import Vapor
import BSON

extension ObjectId : StringInitializable {
  public init?(from string: String) throws {
    try self.init(string)
  }
}
```

This makes ObjectId usable within Vapor's type-safe routes as shown in the example underneath, allowing you to fetch database entities more easily.

```swift
import Vapor
import MongoKitten

let drop = Droplet()
let db = Database("mongodb://localhost")

drop.get("articles", ObjectId.self) { request, articleId in
  guard let article = try db["articles"].findOne("_id" == articleId) else {
    // TODO: Article not found
  }

  // TODO: Present article
}
```

## MeowMongo

Like MongoKitten users, MeowMongo users also store their entities in the database, usually with an ObjectId. This means you could apply roughly the same trick on Models.

Assuming the model specified below:

```swift
struct Article : Model {
  var id = ObjectId()
  var title: String
  var text: String
  var author: Reference<User>
}
```

This model doesn't conform to StringInitializable, yes. But this is easily added in an extension.

```swift
extension Article : StringInitializable {
  public init?(from string: String) throws {
    guard let me = try Article.findOne("_id" == try ObjectId(string)) else {
      return nil
    }

    self = me
  }
}
```

From here on you can fetch the Article in your Vapor routes:

```swift
import Vapor
import Meow

let drop = Droplet()
Meow.init("mongodb://localhost")

drop.get("articles", Article.self) { request, article in
  // TODO: Present article
}
```
