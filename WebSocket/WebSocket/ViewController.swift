//
//  ViewController.swift
//  WebSocket
//
//  Created by 박준현 on 2022/01/22.
//

import UIKit
import Starscream

class ViewController: UIViewController {

    @IBOutlet weak var receiveMessageLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebSocketManager.shared.userName = "Park"
        WebSocketManager.shared.delegate = self
        textField.delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WebSocketManager.shared.connect()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        WebSocketManager.shared.disconnect()
    }

}

extension ViewController: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let headers):
              client.write(string: WebSocketManager.shared.userName)
              print("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
              print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let text):
              print("received text: \(text)")
            
            receiveMessageLabel.text = text
            case .binary(let data):
              print("Received data: \(data.count)")
            case .ping(_):
              break
            case .pong(_):
              break
            case .viabilityChanged(_):
              break
            case .reconnectSuggested(_):
              break
            case .cancelled:
              print("websocket is canclled")
            case .error(let error):
              print("websocket is error = \(error!)")
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            WebSocketManager.shared.sendMessage(text, completion: nil)
        }
        return true
    }
}
