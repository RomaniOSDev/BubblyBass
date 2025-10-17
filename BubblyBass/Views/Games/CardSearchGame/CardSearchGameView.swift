//
//  CardSearchGameView.swift
//  BubblyBass
//
//  Created by Роман Главацкий on 14.10.2025.
//

import SwiftUI

struct CardSearchGameView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
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
                    BlueButtonView(title: "УРОВНИ", height: 60)
                    Spacer()
                    
                    Image(.settingButLabel)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .opacity(0)
                }
                
                //MARK: - Выбор уровня 1..12 с блокировкой
                let key = "maxUnlockedLevel"
                let maxUnlocked = max(UserDefaults.standard.integer(forKey: key), 1)
                
                Spacer()
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
                    ForEach(1...12, id: \.self) { lvl in
                        if lvl <= maxUnlocked {
                            NavigationLink {
                                SimpleLevelView(level: lvl)
                            } label: {
                                ZStack {
                                    Image(.backforlevel)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    Text("\(lvl)")
                                        .foregroundStyle(.white)
                                        .font(.title.bold())
                                }
                               
                            }
                        } else {
                            ZStack {
                                Image(.backforlevel)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                                    Image(systemName: "lock.fill")
                                        .foregroundStyle(.white)
                                    
                            }
                           
                        }
                    }
                }
                .padding(.top, 16)
                
                Spacer(minLength: 0)
            }.padding()
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    CardSearchGameView()
}
