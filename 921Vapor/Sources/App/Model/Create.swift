//
//  Create.swift
//  921PackageDescription
//
//  Created by Betty on 21/09/2018.
//

import Foundation
import Vapor
import FluentPostgreSQL

final class Create: Codable {
    var id:UUID?
    var name: String
    var email: String
    var password: String
    
    init(name: String, email: String, password:String) {
        self.name = name
        self.email = email
        self.password = password
    }
}

extension Create: PostgreSQLUUIDModel {}
extension Create: Migration {}
extension Create: Parameter {}
extension Create: Content {}
