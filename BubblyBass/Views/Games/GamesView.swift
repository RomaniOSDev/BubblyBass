//
//  GamesView.swift
//  BubblyBass
//
//  Created by Роман Главацкий on 14.10.2025.
//

import SwiftUI

struct GamesView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            Image(.seaBack)
                .resizable()
                .ignoresSafeArea()
            VStack{
                //MARK: - Top menu
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image(.backButLabel)
                            .resizable()
                            .frame(width: 60, height: 60)
                    }
                    Spacer()
                    BlueButtonView(title: "GAMES", height: 60)
                    Spacer()
                    
                        Image(.settingButLabel)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .opacity(0)
                }
                Spacer()
                
                //MARK: - Choose game
                VStack{
                    NavigationLink {
                        CardSearchGameView()
                    } label: {
                        Image(.cardSearchButtLabel)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    NavigationLink {
                        FisingGameView()
                    } label: {
                        Image(.fishingGameLabel)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }.padding(.top, 20)

            }.padding()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    GamesView()
}
