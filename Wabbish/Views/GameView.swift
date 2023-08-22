//
//  GameView.swift
//  ARtestt
//
//  Created by David Mahbubi on 11/08/23.
//

import SwiftUI
import AVFAudio

struct GameView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var isHoldingObject: Bool = true
    @State var itemLeft: Int = 10
    @State var alertMessage: String?
    @State var popupState: GameEndState?
    @State var isTrashTooFar: Bool = false
    @State var health: Int = 3
    @State var trashTotal: Int = 10
    @State var alertVariant: AlertVariant?
    @State var holdedTrash: HoldedTrash?
    
    @State var healthIteration = 0
     
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
                    ZStack {
                        HStack(alignment: .center) {
                            ForEach(1..<4) { iter in
                                Image(health >= iter ? "HearthFill" : "HearthEmpty")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25)
                            }
                        }
                        .zIndex(1)
                        Image("HearthBackground")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 130)
                            .zIndex(0)
                    }
                    Spacer()
                    ZStack {
                        HStack {
                            Text("\(trashTotal - itemLeft) / \(trashTotal)")
                                .foregroundStyle(Color(red: 0.596, green: 0.322, blue: 0.278))
                                .fontWeight(.bold)
                                .font(.system(size: 20, design: .rounded))
                            Spacer()
                                .frame(width: 26)
                        }
                        .zIndex(1)
                        Image("TrashBackground")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 170)
                            .zIndex(0)
                    }
                }
                .padding(.horizontal, 10)
                if alertMessage != nil {
                    Alert(variant: alertVariant ?? .success, message: alertMessage!)
                        .frame(maxWidth: 300, maxHeight: 100)
                        .transition(.move(edge: .bottom))
                } else {
                    Spacer()
                }
                if popupState != nil {
                    Popup(state: popupState!)
                        .transition(.move(edge: .top))
                        .frame(maxWidth: 350)
                }
                Spacer()
            }
            
            VStack(alignment: .trailing) {
                Spacer()
                HStack {
                    Spacer()
                    if isHoldingObject {
                        ZStack {
                            Image("HolderTrashBackground")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                            Image("\(String(holdedTrash?.name ?? ""))TrashIcon")
                                .resizable()
                                .transition(.move(edge: .trailing))
                                .scaledToFit()
                                .frame(width: 80)
                                .zIndex(9)
                        }
                    }
                    Spacer()
                        .frame(width: 30)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func onTrashPicked(trash: HoldedTrash) -> Void {
        withAnimation {
            isHoldingObject = true
            alertMessage = nil
            alertVariant = nil
        }
        AudioLoader.playAudio(on: .pick_trash)
        holdedTrash = trash
    }
    
    func onReleaseTrash() -> Void {
        itemLeft -= 1
        withAnimation {
            isHoldingObject = false
        }
        AudioLoader.playAudio(on: .throw_trash)
    }
    
    func onTrueTrash() -> Void {
        if itemLeft == 0 {
            withAnimation {
                alertMessage = nil
                alertVariant = nil
                popupState = .finish
            }
        } else {
            alertMessage = "GREAT!"
            alertVariant = .success
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    alertVariant = nil
                    alertMessage = nil
                }
            }
        }
    }
    
    func onFalseTrash() -> Void {
        withAnimation {
            alertVariant = .danger
            alertMessage = "Wrong bin"
        }
        health -= 1
        if health == 0 {
            withAnimation {
                popupState = .gameOver
                alertVariant = nil
                alertMessage = nil
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.presentationMode.wrappedValue.dismiss()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    alertVariant = nil
                    alertMessage = nil
                }
            }
        }
    }
    
    func onTrashTooFar() -> Void {
        alertMessage = "Trash too far"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            alertMessage = nil
        }
        AudioLoader.playAudio(on: .alert)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(isHoldingObject: false, alertMessage: "Wrong bin", alertVariant: .danger, holdedTrash: nil)
    }
}
