//
//  ChatMessage.swift
//  ClearMyDoubts
//
//  Created by Felipe José on 28/05/24.
//

import Foundation

struct ChatMessage: Identifiable {
    var id: String
    var personType: ChatPersonType
    var body: String
    
    init(personType: ChatPersonType, body: String) {
        self.id = UUID().uuidString
        self.personType = personType
        self.body = body
    }
}
