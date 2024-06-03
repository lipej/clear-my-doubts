//
//  WebSocket.swift
//  ClearMyDoubts
//
//  Created by Felipe José on 28/05/24.
//

import Foundation
import SocketIO

typealias Callback = ([Any], SocketAckEmitter) -> ()

class WebSocketNetwork {
    public static let `default` = WebSocketNetwork()
    private(set) var client: SocketIOClient!
    private let manager: SocketManager
    private let token: String
        
    init() {
        self.token = "Bearer \(UserDefaults.standard.string(forKey: "server_token")!)"
        self.manager = SocketManager(socketURL: URL(string: UserDefaults.standard.string(forKey: "server_url") ?? "http://localhost:3000")!, config: [.log(false), .compress, .extraHeaders(["Authorization": self.token])])
        self.client = self.manager.defaultSocket
    }
    
    func setHandler(event: String? = nil, clientEvent: SocketClientEvent? = nil, callback: @escaping Callback) {
        if (event != nil) {
            self.client.on(event!) { data, ack in
                callback(data, ack)
            }
        }
        
        if (clientEvent != nil) {
            self.client.on(clientEvent: clientEvent!) { data, ack in
                callback(data, ack)
            }
        }
    }
    
    func connect() {
        self.client.connect()
    }
    
    func disconnect() {
        self.client.disconnect()
    }
    
    func emit(event: String, items: [String: String]){
        self.client.emit(event, items)
    }
    
}
