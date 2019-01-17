import Kitura
import SwiftKueryORM
import SwiftKueryPostgreSQL
import LoggerAPI
import HeliumLogger

let router = Router()

let pool = PostgreSQLConnection.createPool(host: "localhost",
                                           port: 5432,
                                        options: [.databaseName("school"),                                                              .userName("school"),
                                            .password("password")],
                                        poolOptions:                                          ConnectionPoolOptions(initialCapacity: 1,                                                                     maxCapacity: 5,                                                                       timeout: 10000))
Database.default = Database(pool)


// Create Todo table
do {
    
    try Todo.createTableSync()
    
} catch let error {
    
    Log.error("Failed to create table in database: \(error)")
    
}

// Create
func postHandler(todo: Todo, completion: @escaping (Todo?, RequestError?) -> Void ) {
    
    todo.save(completion)
}

router.post("/todo", handler: postHandler)

router.get("/") { request, response, next in
    response.send("Hello, World!")
    next()
}

router.get("/hello") { request, response, next in
    if let name = request.queryParameters["name"] {
        response.send("Hello, \(name)!\n")
    }
    else {
        response.send("Hello, whoever you are!\n")
    }
}

router.get("/chapter/:chapterId") { request, response, next in
    
    let chapterId = request.parameters["chapterId"]!
    response.send("Now showing chapter #\(chapterId)\n")
}

// Read
func loadHandler(query: TodosQuery?, completion: @escaping([Todo]?, RequestError?) -> Void) {
    
    Todo.findAll(matching: query, completion)
}

router.get("/todo", handler: loadHandler)

// Update
func updateHandler(id: Int, todo: Todo, completion: @escaping (Todo?, RequestError?) -> Void) {
    
    todo.update(id: id, completion)
}

router.put("/todo", handler: updateHandler)

// Delete
func deleteOneHandler(id: Int, completion: @escaping (RequestError?) -> Void ) {
    
    Todo.delete(id: id, completion)
}

router.delete("/todo", handler: deleteOneHandler)


Kitura.addHTTPServer(onPort: 8080, with: router)
Kitura.run()
