//
//  Popup.swift
//  ARtestt
//
//  Created by David Mahbubi on 14/08/23.
//

import SwiftUI

struct Popup: View {
    
    var state: GameEndState
    
    var body: some View {
        ZStack {
            VStack {
                Image(state == .finish ? "FinishIcon" : "GameOverIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90)
                Text(state == .finish ? "YEAY YOU DID IT!" : "OH NO:((")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                Spacer()
                    .frame(height: 15)
                Text(state == .finish ? "Thankyou for saving me" : "I might loose my home")
                    .foregroundStyle(.white)
            }
            .zIndex(1)
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color(red: 0.56, green: 0.69, blue: 0.87))
        }
    }
}

#Preview {
    Popup(state: .finish)
}
