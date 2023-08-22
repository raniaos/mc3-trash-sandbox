//
//  Popup.swift
//  ARtestt
//
//  Created by David Mahbubi on 14/08/23.
//

import SwiftUI

struct Popup: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var state: GameEndState
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 120)
                Text(state == .finish ? "Yeay, you saved pipop!" : "Pipop is in danger!")
                    .foregroundStyle(Color(red: 0.6, green: 0.29, blue: 0.21))
                    .font(.system(size: 23, design: .rounded))
                    .fontWeight(.bold)
                Spacer()
                    .frame(height: 100)
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    ZStack {
                        Image("PopupButtonBackground")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        Text("Continue")
                            .foregroundStyle(Color(red: 0.95, green: 0.98, blue: 0.71))
                            .font(.system(size: 20, design: .rounded))
                            .fontWeight(.bold)
                    }
                }
            }
            .zIndex(1)
            Image(state == .finish ? "FinishPopupBackground" : "GameOverPopupBackground")
                .resizable()
                .scaledToFit()
                .frame(width: 490)
        }
    }
}

#Preview {
    Popup(state: .gameOver)
}
