//
//  ChatHistoryViewModel.swift
//  ClearMyDoubts
//
//  Created by Felipe José on 03/06/24.
//

import Foundation

@Observable
class ChatHistoryViewModel {
    var chatHistory: [ChatMessage] = [
        ChatMessage(personType: ChatPersonType.ROBOT, body: "Welcome to ClearMyDoubts, how can i help u?")
    ]
    var socketNetwork: WebSocketNetwork = WebSocketNetwork()
    
    init() {
        self.socketNetwork.setHandler(event: "chatbot-answer-streaming") { data, ack in
            if let eventResponse = data.first as? [String: Any] {
                if (self.chatHistory[self.chatHistory.count - 1].body == "...") {
                    self.chatHistory[self.chatHistory.count - 1].body = eventResponse["text"] as! String
                } else {
                    self.chatHistory[self.chatHistory.count - 1].body += eventResponse["text"] as! String
                    
                }
            }
        }
        
        self.socketNetwork.setHandler(event:"chatbot-answer-start") {_,_ in
                self.chatHistory.append(ChatMessage(personType: ChatPersonType.IA, body: "..." ))
            }
        
        self.socketNetwork.connect()
    }
    
    func sendMessage(message: String) {
               self.chatHistory.append(ChatMessage(personType: ChatPersonType.HUMAN, body: message))
        
           DispatchQueue.main.async {
               self.socketNetwork.emit(event: "chatbot", items: ["question": message])
           }
       }
}
