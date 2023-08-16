//
//  GameView.swift
//  ARtestt
//
//  Created by David Mahbubi on 11/08/23.
//

import SwiftUI

struct GameView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var isHoldingObject: Bool
    @State var itemLeft: Int = 20
    @State var alertMessage: String?
    @State var popupState: GameEndState?
    @State var isTrashTooFar: Bool = false
    @State var health: Int = 3
    @State var trashTotal: Int = 20
    
    var body: some View {
        ZStack {
            ARViewContainer(
                onHoldingObject: onTrashPicked,
                onReleaseTrash: onReleaseTrash,
                onFalseTrash: onFalseTrash,
                onTrueTrash: onTrueTrash,
                onTrashTooFar: onTrashTooFar,
                itemLeft: $itemLeft
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
                            .frame(width: CGFloat((Float(health) / Float(3)) * Float(70)), height: 50)
                            .zIndex(1)
                    }
                    Spacer()
                    ZStack {
                        HStack {
                            Text("\(trashTotal - itemLeft)/\(trashTotal)")
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
                if popupState != nil {
                    Popup(state: popupState!)
                        .transition(.move(edge: .top))
                        .frame(maxWidth: 350, maxHeight: 300)
                }
                Spacer()
                if alertMessage != nil {
                    Alert(message: alertMessage!)
                        .frame(maxWidth: 300, maxHeight: 100)
                        .transition(.move(edge: .bottom))
                }
            }
            
            VStack(alignment: .trailing) {
                Spacer()
                HStack {
                    Spacer()
                    if isHoldingObject {
                        Image("BananaIcon")
                            .resizable()
                            .transition(.move(edge: .trailing))
                            .scaledToFit()
                            .frame(width: 80)
                    }
                    Spacer()
                        .frame(width: 30)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func onTrashPicked() -> Void {
        withAnimation {
            isHoldingObject = true
            alertMessage = nil
        }
    }
    
    func onReleaseTrash() -> Void {
        itemLeft -= 1
        withAnimation {
            isHoldingObject = false
        }
    }
    
    func onTrueTrash() -> Void {
        if itemLeft == 0 {
            withAnimation {
                alertMessage = nil
                popupState = .finish
            }
        }
    }
    
    func onFalseTrash() -> Void {
        withAnimation {
            alertMessage = "You’ve thrown the trash to the wrong bin"
        }
        health -= 1
        if health == 0 {
            withAnimation {
                popupState = .gameOver
                alertMessage = nil
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.presentationMode.wrappedValue.dismiss()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    alertMessage = nil
                }
            }
        }
    }
    
    func onTrashTooFar() -> Void {
        alertMessage = "The trash is too far"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            alertMessage = nil
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(isHoldingObject: false)
    }
}
