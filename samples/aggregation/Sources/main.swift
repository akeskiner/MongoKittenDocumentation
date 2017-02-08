import MongoKitten

//let server = try Server(mongoURL: "mongodb://localhost:27017")

//let clientSettings = ClientSettings(host: MongoHost(hostname:"localhost", port: 27017),sslSettings: nil,credentials:nil, maxConnectionsPerServer: 20)
//let server = try Server(clientSettings)
//let database = server["tutorial"]
//
//if server.isConnected {
//    print("Connected successfully to server")
//}
//
//let restaurants = database["restaurants"]
//
//let matchStage = AggregationPipeline.Stage.matching("categories" == "Bakery")
//let groupStage = AggregationPipeline.Stage.grouping("$stars", computed: ["count": .sumOf(1)])
//
//let pipeline: AggregationPipeline = [matchStage, groupStage]
//
//let results = try restaurants.aggregate(pipeline: pipeline)
//
//
//
//let _ = results.map {
//    print($0.dictionaryValue)
//}
//



let clientSettings = ClientSettings(host: MongoHost(hostname:"ds015730.mlab.com", port: 15730),sslSettings: nil,credentials: MongoCredentials(username:"kitten",password:"kitten1234"), maxConnectionsPerServer: 20)
let server = try Server(clientSettings)
let database = server["CloudFoundry_2b5vuc3r_oi9j4527"]

if server.isConnected {
    print("Connected successfully to server")
}


let _ = try database.listCollections().map {
    print($0.name)
}

print(try database.listCollections().collection.count())




