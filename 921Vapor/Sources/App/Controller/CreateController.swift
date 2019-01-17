//
//  CreateController.swift
//  921PackageDescription
//
//  Created by Betty on 21/09/2018.
//

import Foundation
import Vapor
import FluentPostgreSQL
import Leaf
import CryptoSwift

struct CreateController: RouteCollection {
    
    func boot(router: Router) throws {
        let createRoutes = router
        
        createRoutes.post(Create.self, at: "createPerson", use: createHandler)
        router.get("createPerson", use: showRegisterForm)
        
        
        //是進入頁面讓使用者填資料
        router.get("login", use: showLoginForm)
        
        //呼叫方法去比對資料
        let loginRoutes = router.grouped("createPerson", "login")
        loginRoutes.post(Create.self, use: loginHandler)

        
    }
    
    func createHandler(_ req: Request,
                       newCreate: Create) throws -> Future<Create> {
        return Create.query(on: req).all().flatMap(to: Create.self) { allCreate in
            for create in allCreate {
                if newCreate.email == create.email {
                    throw Abort(.badRequest, reason: "a user with this email already exists", identifier: nil)
                }
            }
            let hashedPassword = newCreate.password.md5()
            let persistedUser = Create(name:newCreate.name, email: newCreate.email, password: hashedPassword)
            return persistedUser.save(on: req)
        }
    }
    
    func showRegisterForm(_ req: Request) throws -> Future<View> {
        
        return try req.view().render("create")
    }

    func loginHandler(_ req: Request, userInput: Create) throws -> Future<View> {
        print("Login handler")
        let name = userInput.name
        let email = userInput.email
        let password = userInput.password
        var isSuccess:Bool = false
        return Create.query(on : req).all().flatMap(to: View.self) { allCreate in
            for create in allCreate {
                if email == create.email {
                    if password.md5() == create.password {
                        print("Success Login")
                        isSuccess = true
                    }
                    else {
                        print("Login Fail")
                    }
                }
                
                
            }
            if isSuccess {
                
                return try req.view().render("loginSuccess")
            } else {
                
                return try req.view().render("loginFail")
            }
        }
    }
    
    func showLoginForm(_ req: Request) throws -> Future<View> {
        
        return try req.view().render("loginPage")
    }

    
}
