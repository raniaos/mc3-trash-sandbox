//
//  Alert.swift
//  ARtestt
//
//  Created by David Mahbubi on 14/08/23.
//

import SwiftUI

struct Alert: View {
    
    let message: String
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                HStack(alignment: .center) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.yellow)
                        .padding(.trailing, 10)
                    Text(message)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 35)
                Spacer()
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(red: 0.87, green: 0.56, blue: 0.65))
            )
        }
    }
}
//
//#Preview {
//    Alert(message: "You’ve thrown the trash to the wrong bin")
//}
