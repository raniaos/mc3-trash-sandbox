//
//  GameView.swift
//  ARtestt
//
//  Created by David Mahbubi on 11/08/23.
//

import SwiftUI

struct GameView: View {
    
    @State var isHoldingObject: Bool
    @State var itemLeft: Int = 20
    
    var body: some View {
        ZStack {
            ARViewContainer(
                onHoldingObject: onTrashPicked,
                onReleaseTrash: onReleaseTrash,
                onFalseTrash: onFalseTrash
            ).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                    .frame(height: 15)
                HStack {
                    HStack {
                        Image("SaveMeIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70)
                            .zIndex(2)
                        RoundedRectangle(cornerRadius: 20)
                            .padding(.leading, -40)
                            .foregroundStyle(Color(red: 0.56, green: 0.69, blue: 0.87))
                            .frame(width: 70, height: 50)
                            .zIndex(1)
                    }
                    Spacer()
                    ZStack {
                        HStack {
                            Text("1/20")
                                .foregroundStyle(.black)
                                .fontWeight(.bold)
                            Image("AppleIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15)
                        }
                            .zIndex(1)
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color(red: 0.56, green: 0.69, blue: 0.87))
                            .frame(width: 100, height: 50)
                            .zIndex(0)
                    }
                }
                .padding(.horizontal, 10)
                Spacer()
//                Popup(state: .finish)
//                    .frame(maxWidth: 350, maxHeight: 300)
                Spacer()
                Alert(message: "You’ve thrown the trash to the wrong bin")
                    .frame(maxWidth: 300, maxHeight: 100)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func onTrashPicked() -> Void {
        
    }
    
    func onFalseTrash() -> Void {
        
    }
    
    func onReleaseTrash() -> Void {
        itemLeft -= 1
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(isHoldingObject: false)
    }
}
