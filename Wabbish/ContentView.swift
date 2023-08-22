//
//  ContentView.swift
//  ARtestt
//
//  Created by Rania Ori Sumargo on 01/08/23.
//

import SwiftUI

struct ContentView : View {
    
    @State var entityId: String
    
    var body: some View {
        NavigationStack {
            MenuView()
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(entityId: "")
    }
}
#endif
