+++
date = "2016-12-14T12:36:56Z"
title = "GridFS"
[menu.main]
  parent = "MongoKitten"
  identifier = "GridFS"
  weight = 80
  pre = "<i class='fa'></i>"
+++

# GridFS

GridFS is a standard for using MongoDB as file storage through the MongoDB binary type. MongoDB allows you to store documents up to 16MB in size, which is useful for storing PDFs, profile pictures and other binary data. But if you want to store bigger data than 16MB you'll need to store it over multiple documents. GridFS fulfills that task.

### Setup

GridFS is a bucket consisting of two collections. This means that two collections have the same prefix separating their own bucket name with a dot (`.`).

GridFS uses the `fs` prefix by default and then appends the bucket names `files` and `chunks` to create a `fs.files` collection and `fs.chunks` collection. Files stores the metadata, chunks stores the binary information for the files.

`let fs = db.makeGridFS()` will get you the GridFS instance.

## Using GridFS

MongoKitten's GridFS supports three methods of mutation.

Create/store, Read/find and Remove/delete.

### Storing files

```swift
let data: [UInt8] = []
let fileID = try fs.store(data: myData, named: "data.txt")
```

### Removing files

Files can only be removed by their identifier because you wouldn't want to remove all files accidentally. For that we have `try fs.drop()` which drops the collections.

```swift
try fs.remove(byId: fileID)
```

### Finding files

This functions similarly to Collection. But instead of returning a cursor containing Documents it returns a `GridFS.File` cursor.

```swift
let allFiles = try fs.find()
```

You can find single files using findOne similarly to Collection.

```swift
let file: GridFS.File? = try fs.findOne(byID: fileID)
```

### Reading files

Once you've obtained an instance of `GridFS.File` you've only fetched the metadata. Meaning the filename, mime type, MD5 checksum and any other metadata that this file contains.

You can use this file instance to fetch either all or specific sets of bytes. In the case of a smaller download, or a download that'll need to be served in it's entirely.

To fetch all bytes you'll need to iterate over the chunks and send those chunks over the socket stream chunk-by-chunk.

```swift
for chunk in file {
  socket.send(chunk.data)
}
```

You can interrupt this process at any time efficiently without fetching extra data from MongoDB.

MongoKitten will not throw an error when an error occurs when iterating over the file chunks using this method and will instead return no (additional) chunks. This may not always cause harm. In some situations it will result in an aborted or corrupted download which may or may not be a problem. In an image it'll result in a partially loaded image, in a video it'll result in the inability to load some parts of the movie and some file formats like PDF may be unable to open and need to be re-downloaded.

If you want to set up a failsafe for these scenarios you'll need to use the `try file.chunked()` method.

```swift
for chunk in try file.chunked() {
  socket.send(chunk.data)
}
```

By default most frameworks will be unable to serve the file properly which results in the same situation as above. But if you catch the error manually you may be able to fetch the remaining data by re-trying to fetch the remaining chunks. This can be useful when the used replica set or sharded cluster has had a failure because it's been disabled for maintainance or another reason, or simply to log the problem.

### Resumed downloads

Some larger files and web-browsers may use a functionality that allows resuming downloads. Videos use them for buffering, by downloading the relevant parts of the videos when required allowing you to start watching the first bit whilst the rest is still buffering. Other big files may use this web-feature for resuming big downloads after a connection problem has occurred. Or you may have another use case scenario.

MongoKitten allows you to fetch specific subsets of information from GridFS.

You can request all bytes after byte 1 million (1MB) for example:

```swift
try file.read(from: 1_000_000)`
```

You can request a limited subset of bytes:

```swift
try file.read(from: 1_000_000, to: 2_500_000)
```

This would fetch 1.5MB of data starting after 1MB.
