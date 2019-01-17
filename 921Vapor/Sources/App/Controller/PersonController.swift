//
//  PersonController.swift
//  921
//
//  Created by Betty on 21/09/2018.
//

import Foundation
import Vapor
import FluentPostgreSQL
import Leaf


struct IndexContext: Encodable {
    let title: String
    let people: [Person]?
}
struct PersonController: RouteCollection {
    
    func boot(router: Router) throws {
        let personRoutes = router
        
        personRoutes.post(Person.self, at: "addPerson", use: createHandler)
        personRoutes.get("getPeople",use:getAllHandler)
        personRoutes.get("getPerson", Person.parameter, use: getHandler)
        personRoutes.put("updatePerson", Person.parameter, use: updateHandler)
        personRoutes.delete("deletePerson", Person.parameter, use: deleteHandler)
        personRoutes.get("getPersonInView", Person.parameter, use: getInViewHandler)
        personRoutes.get("getPeopleInView", use:getAllInViewHandler)
    }
    
    func createHandler(_ req: Request,
                       person: Person) throws -> Future<Person> {
        return person.save(on: req)
    }
    
    func getHandler(_ req: Request) throws -> Future<Person> {
        return try req.parameters.next(Person.self)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Person]> {
        return Person.query(on: req).all()
    }
    
    func updateHandler(_ req: Request) throws -> Future<Person> {
        
        return try flatMap(to: Person.self,
                           req.parameters.next(Person.self),
                           req.content.decode(Person.self)) {
                            person, updatedPerson in
                            person.name = updatedPerson.name
                            person.age = updatedPerson.age
                            return person.save(on: req)
        }
    }
    
    func deleteHandler(_ req: Request)
        throws -> Future<HTTPStatus> {
            
            return try req.parameters.next(Person.self)
                .delete(on: req)
                .transform(to: HTTPStatus.noContent)
    }

    func getInViewHandler(_ req: Request) throws -> Future<View> {
        
        return try req.parameters.next(Person.self).flatMap({ person in
            
            return try req.view().render("getperson", person)
        })
    }
    
    func getAllInViewHandler(_ req: Request) throws -> Future<View> {
        
        return Person.query(on: req).all().flatMap({ people in
            
            let context = IndexContext(title: "People", people: people.isEmpty ? nil : people)
            return try req.view().render("getpeople", context)
        })
    }


}
