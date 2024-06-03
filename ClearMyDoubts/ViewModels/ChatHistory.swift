//
//  ChatHistory.swift
//  ClearMyDoubts
//
//  Created by Felipe José on 03/06/24.
//

import Foundation

class ChatHistory: ObservableObject {
    var socketNetwork: WebSocketNetwork = WebSocketNetwork()

    @Published var chat = [ChatMessage]()
    
    init() {
        self.chat.append(ChatMessage(personType: ChatPersonType.ROBOT, body: "Welcome to ClearMyDoubts, how can i help u?"))
        
        
        self.socketNetwork.setHandler(event: "chatbot-answer-streaming") { data, ack in
            if let eventResponse = data.first as? [String: Any] {
                if (self.chat[self.chat.count - 1].body == "...") {
                    self.chat[self.chat.count - 1].body = eventResponse["text"] as! String
                } else {
                    self.chat[self.chat.count - 1].body += eventResponse["text"] as! String
                    
                }
            }
        }
        
        self.socketNetwork.setHandler(event: "chatbot-answer-start") {_,_ in
                self.chat.append(ChatMessage(personType: ChatPersonType.IA, body: "..." ))
            }
        
        self.socketNetwork.connect()
    }
    
    func sendMessage(message: String) {
               self.chat.append(ChatMessage(personType: ChatPersonType.HUMAN, body: message))
        
           DispatchQueue.main.async {
               self.socketNetwork.emit(event: "chatbot", items: ["question": message])
           }
       }
}
