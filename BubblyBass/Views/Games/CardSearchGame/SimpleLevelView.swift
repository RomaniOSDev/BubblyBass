//
//  SimpleLevelView.swift
//  BubblyBass
//
//  Created by Роман Главацкий on 14.10.2025.
//

import SwiftUI

struct SimpleLevelView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: CardSearchGameViewModel
    
    init(level: Int) {
        _viewModel = StateObject(wrappedValue: CardSearchGameViewModel(level: level))
    }
    
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
                    BlueButtonView(title: "\(viewModel.timeRemaining)s", height: 60)
                    Spacer()
                    Image(.settingButLabel)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .opacity(0)
                }
                
                VStack(spacing: 12) {
                    Spacer()
                    
                    //MARK: - Grid 3x4
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), spacing: 8) {
                        ForEach(viewModel.cards.indices, id: \.self) { index in
                            let card = viewModel.cards[index]
                            Button {
                                viewModel.flipCard(at: index)
                            } label: {
                                ZStack {
                                    if card.isFaceUp || card.isMatched {
                                        Image("card\(card.pairId)")
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    } else {
                                        Image("closeCard")
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                }
                                .frame(height: 90)
                                .opacity(card.isMatched ? 0.35 : 1.0)
                            }
                            .disabled(card.isMatched || card.isDisabled)
                        }
                    }
                    .padding(.vertical, 8)
                    
                    // Controls
                    HStack(spacing: 12) {
                        Button {
                            viewModel.startNewGame()
                        } label: {
                            BlueButtonView(title: "RESET", height: 60)
                        }
                        .disabled(viewModel.state == .notStarted)
                    }
                }
                
                Spacer()
            }.padding()
            
            //MARK: - Win/Lose overlay
            if viewModel.state == .won || viewModel.state == .lost {
                if viewModel.state == .won {
                    GameOverView(title: "VICTORY!", titleButton: "COLLECT", coins: 1500) {
                        let next = min(12, viewModel.level + 1)
                        viewModel.selectLevel(next)
                    }
                }else{
                    GameOverView(title: "OPPS..", titleButton: "REPEAT", coins: 0) {
                        viewModel.startNewGame()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            if viewModel.cards.isEmpty { viewModel.startNewGame() }
        }
    }
}

#Preview {
    SimpleLevelView(level: 9)
}


