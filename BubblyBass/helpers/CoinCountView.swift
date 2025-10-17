//
//  CoinCountView.swift
//  BubblyBass
//
//  Created by Роман Главацкий on 14.10.2025.
//

import SwiftUI

struct CoinCountView: View {
    var height: CGFloat = 65
    var coinCount: Int = 1500
    var body: some View {
        ZStack {
            Image(.coinLabel)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("\(coinCount)")
                .foregroundStyle(.white)
                .font(.system(size: height/2.6, weight: .heavy, design: .rounded))
                .padding(.leading, height/1.8)
        }.frame(height: height)
    }
}

#Preview {
    CoinCountView()
}
