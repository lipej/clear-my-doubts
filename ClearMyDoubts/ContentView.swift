//
//  ContentView.swift
//  ClearMyDoubts
//
//  Created by Felipe José on 28/05/24.
//

import SwiftUI
import SwiftSpeech

struct ContentView: View {
    var body: some View {
        Home().onAppear {
            SwiftSpeech.requestSpeechRecognitionAuthorization()
        }
    }
}
    
    



#Preview {
    ContentView()
}
