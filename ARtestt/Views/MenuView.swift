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
                    .frame(height: 300)
                Text("SAVE MY HOME")
                    .foregroundColor(Color(red: 0.04, green: 0.2, blue: 0.19))
                    .font(.custom("Lilita One", size: 46))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                Spacer()
                    .frame(height: 60)
                VStack {
                    NavigationLink(destination: GameView(isHoldingObject: false)) {
                        Text("")
                            .frame(maxWidth: .infinity)
                            .frame(height: 30)
                            .foregroundColor(Color(red: 0.27, green: 0.48, blue: 0.5))
                            .fontWeight(.bold)
                            .padding(.vertical, 20)
                            .padding(.horizontal, 50)
                            .background(.white)
                            .overlay(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 30)
                                        .inset(by: 3)
                                        .stroke(Color(red: 0.56, green: 0.69, blue: 0.87), lineWidth: 15)
                                        .background(.white)
                                    Text("START")
                                        .foregroundColor(Color(red: 0.27, green: 0.48, blue: 0.5))
                                        .fontWeight(.bold)
                                
                                }
                            )
                            .cornerRadius(30)
                    }
                    Spacer()
                        .frame(height: 20)
                    NavigationLink(destination: GameView(isHoldingObject: false)) {
                        Text("")
                            .frame(maxWidth: .infinity)
                            .frame(height: 30)
                            .foregroundColor(Color(red: 0.27, green: 0.48, blue: 0.5))
                            .fontWeight(.bold)
                            .padding(.vertical, 20)
                            .padding(.horizontal, 50)
                            .background(.white)
                            .overlay(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 30)
                                        .inset(by: 3)
                                        .stroke(Color(red: 0.56, green: 0.69, blue: 0.87), lineWidth: 15)
                                        .background(.white)
                                    Text("HOW TO PLAY")
                                        .foregroundColor(Color(red: 0.27, green: 0.48, blue: 0.5))
                                        .fontWeight(.bold)
                                
                                }
                            )
                            .cornerRadius(30)
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
