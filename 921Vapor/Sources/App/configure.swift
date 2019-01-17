//
//  configure.swift
//  921
//
//  Created by Betty on 21/09/2018.
//

import Foundation
import Vapor
import FluentPostgreSQL
import Leaf

public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    try services.register(FluentPostgreSQLProvider())
    
    
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
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
    //for create account
    migrations.add(model: Create.self, database: .psql)
    services.register(migrations)
    
    let leafProvider = LeafProvider()
    try services.register(leafProvider)
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self) 
}
