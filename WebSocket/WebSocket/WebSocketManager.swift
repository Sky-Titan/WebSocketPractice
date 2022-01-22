//
//  WebSocketManager.swift
//  WebSocket
//
//  Created by 박준현 on 2022/01/22.
//

import Foundation
import Starscream

class WebSocketManager {
    static let shared = WebSocketManager()
    
    private init() {}
    
    deinit {
        disconnect()
    }
    
    private let url = URL(string: "ws://localhost:1337/")
    public var userName: String = "user"
    private var socket: WebSocket?
    public weak var delegate: WebSocketDelegate? {
        didSet {
            socket?.delegate = delegate
        }
    }
    
    public func connect() {
        guard let url = url else { return }
        
        if socket != nil {
            disconnect()
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket?.delegate = delegate
        socket?.connect()
    }
    
    public func disconnect() {
        socket?.disconnect()
        socket?.delegate = nil
        socket = nil
    }
    
    public func sendMessage(_ message: String, completion: (() -> Void)? = nil) {
        socket?.write(string: message, completion: completion)
    }
}
