//
//  websockets.swift
//  App
//
//  Created by Betty on 2018/10/19.
//

import Foundation
import Vapor

public func sockets(_ websockets: NIOWebSocketServer) {
    
    // Status
    
    websockets.get("echo-test") { ws, req in
        print("ws connnected")
        ws.onText { ws, text in
            print("ws received: \(text)")
            ws.send("echo - \(text)")
        }
    }
    
    
}
 
