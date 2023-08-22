//
//  MenuView.swift
//  ARtestt
//
//  Created by David Mahbubi on 11/08/23.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack {
            Image("MenuBackground")
                .resizable()
                .scaledToFit()
            VStack {
                Spacer()
                    .frame(height: 100)
                VStack {
                    GifImage(name: "HappyPipop")
                        .frame(maxHeight: 280)
                    NavigationLink(destination: GameView(isHoldingObject: false)) {
                        ZStack {
                            Image("ButtonBackground")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 320)
                            Text("Start")
                                .foregroundStyle(Color(red: 0.95, green: 0.98, blue: 0.71))
                                .fontWeight(.bold)
                                .zIndex(2)
                                .font(.system(.largeTitle, design: .rounded))
                        }
                    }
                    NavigationLink(destination: HowToPlayView()) {
                        ZStack {
                            Image("ButtonBackground")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 320)
                            Text("How to Play")
                                .foregroundStyle(Color(red: 0.95, green: 0.98, blue: 0.71))
                                .fontWeight(.bold)
                                .zIndex(2)
                                .font(.system(.largeTitle, design: .rounded))
                        }
                    }
                }
                .padding(.horizontal, 50)
            }
        }
        .ignoresSafeArea()
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
