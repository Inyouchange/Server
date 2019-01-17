import Vapor
import FluentPostgreSQL
import Leaf
import App

//放到person.swift
/*final class Person: Content {
    var id:UUID?
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

extension Person: PostgreSQLUUIDModel {}
extension Person: Migration {}
extension Person: Parameter {}*/

//放到configure.swift裡
/*public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    try services.register(FluentPostgreSQLProvider())
    
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)
    
    var databases = DatabasesConfig()
    let databaseConfig = PostgreSQLDatabaseConfig(
        hostname: "localhost",
        username: "hello",
        database: "hello",
        password: "password")
    let database = PostgreSQLDatabase(config: databaseConfig)
    databases.add(database: database, as: .psql)
    services.register(databases)
    
    var migrations = MigrationConfig()
    migrations.add(model: Person.self, database: .psql)
    services.register(migrations)
    
    let leafProvider = LeafProvider()
    try services.register(leafProvider)
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
}*/

//already put it in app
/*
var config = Config.default()
var env = try Environment.detect()
var services = Services.default()
try configure(&config, &env, &services)
let app = try Application(config: config, environment: env, services: services)*/
//already change it at routes
//let router = try app.make(Router.self)


//let app = try Application()
//let router = try app.make(Router.self)

/*router.get("hello"){ req in
    return"Hello World."
}*/

//put in personcontroller
/*
router.post(Person.self, at: "addPerson") { req, data -> Future<Person> in
    
    return data.save(on: req)
}

router.get("getPeople") { req -> Future<[Person]> in
    
    return Person.query(on: req).all()
}
router.get("getPerson", Person.parameter) { req -> Future<Person> in
    
    return try req.parameters.next(Person.self)
}

router.put("updatePerson", Person.parameter) { req -> Future<Person> in
    
    return try flatMap(to: Person.self,
                       req.parameters.next(Person.self),
                       req.content.decode(Person.self)) { person, updatedPerson in
                        
                        person.name = updatedPerson.name
                        person.age = updatedPerson.age
                        return person.save(on: req)
    }
}


router.delete("deletePerson", Person.parameter) { req -> Future<HTTPStatus> in
    
    return try req.parameters.next(Person.self)
        .delete(on: req)
        .transform(to: HTTPStatus.noContent)
}*/

/*router.get("hello") { req -> Future<View> in
    return try req.view().render("hello")
}*/

try app(.detect()).run()




