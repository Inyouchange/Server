//
//  routes.swift
//  921
//
//  Created by Betty on 21/09/2018.
//

import Foundation
import Vapor
import Leaf

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    let personController = PersonController()
    try router.register(collection: personController)
    
    //when finish controller
    let createController = CreateController()
    try router.register(collection: createController)
    
    router.get("hello") { req -> Future<View> in
        return try req.view().render("hello")
    }
    
    router.get("child") { req -> Future<View> in
        return try req.view().render("child")
    }
    
    router.get("alert") { req -> Future<View> in
        return try req.view().render("alert")
    }

    /*router.get("create") { req -> Future<View> in
        return try req.view().render("create")
    }*/



}
