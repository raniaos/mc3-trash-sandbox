//
//  MenuView.swift
//  ARtestt
//
//  Created by David Mahbubi on 11/08/23.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Image("ic_banana")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            Spacer()
                .frame(height: 60)
            VStack {
                NavigationLink(destination: GameView(isHoldingObject: false)) {
                    Text("Play")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 50)
                        .background(.blue)
                        .cornerRadius(13)
                }
                NavigationLink(destination: GameView(isHoldingObject: false)) {
                    Text("How to Play")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 50)
                        .background(.blue)
                        .cornerRadius(13)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
