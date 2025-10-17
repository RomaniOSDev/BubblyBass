//
//  BluebUttonView.swift
//  BubblyBass
//
//  Created by Роман Главацкий on 14.10.2025.
//

import SwiftUI

struct BlueButtonView: View {
    var title: String = "START"
    var height: CGFloat = 90
    var body: some View {
        ZStack{
            Image(.backToBlueButtton)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(title)
                .foregroundStyle(.white)
                .font(Font.system(size: height/2, weight: .bold, design: .default))
        }
        .frame(height: height)
    }
}

#Preview {
    BlueButtonView()
}
