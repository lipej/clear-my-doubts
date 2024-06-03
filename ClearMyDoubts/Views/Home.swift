//
//  Home.swift
//  ClearMyDoubts
//
//  Created by Felipe José on 03/06/24.
//

import SwiftUI
import SwiftSpeech

struct Home: View {
    @State private var model = ChatHistory()
    @State var show = false
    
    var body: some View {
        VStack {
            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.horizontal)
            }.padding()
            
            Spacer()
            
            ScrollView {
                ForEach(model.chat, id: \.id) {
                    message in Entry(personType: message.personType, text: message.body)
                }
                .rotationEffect(.degrees(180))
                .animation(.default, value: show)
            }
            .rotationEffect(.degrees(180))
            
            Spacer()
            
            SwiftSpeech
                .RecordButton()
                .swiftSpeechRecordOnHold(locale: Locale(identifier: "en-US"))
                .onRecognizeLatest { result in
                    if (result.isFinal){
                        model.sendMessage(message:         result.bestTranscription.formattedString)
                    }
                } handleError: { err in
                    print(err)
                    
                    model.chat.append(ChatMessage(personType: ChatPersonType.ROBOT, body: "Oops, I couldn't understand you!"))
                }
            
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification), perform: { _ in
            self.model.socketNetwork.disconnect()
            print("app closed")
        })
        .onReceive(model.$chat, perform: { _ in
            show.toggle()
        })
    }
}

#Preview {
    Home()
}
