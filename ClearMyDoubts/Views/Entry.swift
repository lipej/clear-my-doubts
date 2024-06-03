//
//  Entry.swift
//  ClearMyDoubts
//
//  Created by Felipe José on 03/06/24.
//

import SwiftUI

struct Entry: View {
    var personType: ChatPersonType
    var text: String
    
    var body: some View {
            HStack {
            if (personType == ChatPersonType.HUMAN) {
                Spacer()
                Text(text)
                    .padding()
                    .foregroundColor(.white)
                    .background(.gray.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.horizontal, .leastNonzeroMagnitude)
                    .padding(.bottom,10)
            } else {
                Text(text)
                    .padding()
                    .foregroundColor(.white)
                    .background(.purple.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.horizontal, .leastNonzeroMagnitude)
                    .padding(.bottom,10)
                Spacer()
            }
        }
            .padding(.horizontal)
    }
}

#Preview {
    Entry(
        personType: ChatPersonType.HUMAN,
        text: "Test")
}
