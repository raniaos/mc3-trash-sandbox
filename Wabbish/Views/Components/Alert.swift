//
//  Alert.swift
//  ARtestt
//
//  Created by David Mahbubi on 14/08/23.
//

import SwiftUI

enum AlertVariant {
    case danger
    case success
}

struct Alert: View {
    
    let variant: AlertVariant
    let message: String
    
    var body: some View {
        ZStack {
            ZStack {
                Image(variant == .success ? "AlertSuccess" : "AlertDanger")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 330)
                Text(message)
                    .font(.system(size: 30, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(Color(red: 0.95, green: 0.98, blue: 0.71))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 300)
            }
        }
    }
}

#Preview {
    Alert(variant: .danger, message: "Wromg bin!")
}
