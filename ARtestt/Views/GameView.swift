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
            ARViewContainer(onHoldingObject: onTrashPicked, onReleaseTrash: onReleaseTrash).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                    .frame(height: 15)
                if isHoldingObject {
                    Text("You are holding")
                    Text("Banana")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                } else {
                    Text("Look around to find a trash")
                }
                Spacer()
                Text("Item(s) collected : ")
                Text("1 / 20")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
        }
    }
    
    func onTrashPicked() -> Void {
        
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
