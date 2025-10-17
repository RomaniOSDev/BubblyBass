//
//  GameOverView.swift
//  BubblyBass
//
//  Created by Роман Главацкий on 14.10.2025.
//

import SwiftUI

struct GameOverView: View {
    var title: String = "Game Over"
    var titleButton: String = "Repeat"
    var coins: Int = 0
    var action: () -> Void = { }
    var body: some View {
        ZStack {
            Image(.backgameover)
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(spacing: 16) {
                Text(title)
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                HStack{
                    Image(.coin)
                        .resizable()
                        .frame(width: 45, height: 45)
                    Text("\(coins)")
                        .foregroundStyle(.white)
                        .font(Font.largeTitle.bold())
                }
                        Button {
                            action()
                        } label: {
                            BlueButtonView(title: titleButton, height: 60)
                        }
            }
            .padding()
        }
    }
}

#Preview {
    GameOverView()
}
