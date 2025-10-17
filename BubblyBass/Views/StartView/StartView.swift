//
//  StartView.swift
//  BubblyBass
//
//  Created by Роман Главацкий on 13.10.2025.
//

import SwiftUI

struct StartView: View {
    
    @AppStorage("coins") private var coins: Int = 0
    
    var body: some View {
        NavigationStack {
            ZStack{
                Image(.seaBack)
                    .resizable()
                    .ignoresSafeArea()
                VStack{
                    //MARK: - Top menu
                    HStack{
                        NavigationLink {
                            FishView()
                        } label: {
                            Image(.fishButLabel)
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                        Spacer()
                        CoinCountView(height: 65, coinCount: coins)
                        Spacer()
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Image(.settingButLabel)
                                .resizable()
                                .frame(width: 60, height: 60)
                        }

                        
                    }
                    Spacer()
                    
                    ZStack(alignment: .bottom) {
                        Image(.startFisherman)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        NavigationLink {
                            GamesView()
                        } label: {
                            BlueButtonView()
                        }
                    }
                    

                }.padding()
            }
        }
    }
}

#Preview {
    StartView()
}
