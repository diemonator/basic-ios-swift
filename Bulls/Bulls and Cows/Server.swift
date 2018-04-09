//
//  Server.swift
//  Bulls and Cows
//
//  Created by Emil Karamihov on 30/03/2018.
//  Copyright © 2018 Emil Karamihov. All rights reserved.
//

import UIKit
import SocketIO

class Server: NSObject {
    
    let manager = SocketManager(socketURL: URL(string: "http://localhost:8080")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    var serverPlayer: [String]!
    var serverList: [String:[AnyObject]]!
    
    override init() {
        super.init()
        socket = manager.defaultSocket
    }
    
    func getSocket() -> SocketIOClient {
        return socket
    }
    
    func connect() {
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
}
