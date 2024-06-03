//
//  ChatHistory.swift
//  ClearMyDoubts
//
//  Created by Felipe José on 28/05/24.
//

import Foundation

class ChatHistory: ObservableObject{
    @Published var chatHistory: [ChatMessage]

    init(){
            self.chatHistory = [
                ChatMessage(personType: ChatPersonType.ROBOT, body: "Wellcome to ClearMyDoubts, how can i help u?")]
    }
}
