//
//  HowToPlayView.swift
//  Wabbish
//
//  Created by David Mahbubi on 22/08/23.
//

import SwiftUI

struct HowToPlayView: View {
    var body: some View {
        ZStack {
            Color(red: 0.27, green: 0.66, blue: 0.59)
            RoundedRectangle(cornerRadius: 15)
                .frame(width: .infinity, height: .infinity)
                .foregroundStyle(Color(red: 0.95, green: 0.98, blue: 0.71))
                .padding(.vertical, 80)
                .padding(.horizontal, 30)
            VStack {
                Spacer()
                    .frame(height: 200)
                Text("Oopsss")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(Color(red: 0.27, green: 0.66, blue: 0.59))
                    .padding(.bottom, 5)
                Text("This feature is under development")
                    .foregroundStyle(Color(red: 0.27, green: 0.66, blue: 0.59))
                GifImage(name: "SadPipop")
                    .frame(width: 300)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HowToPlayView()
}
