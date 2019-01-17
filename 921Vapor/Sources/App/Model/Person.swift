//
//  Person.swift
//  921
//
//  Created by Betty on 21/09/2018.
//

import Foundation
import Vapor
import FluentPostgreSQL

final class Person: Content {
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
extension Person: Parameter {}
