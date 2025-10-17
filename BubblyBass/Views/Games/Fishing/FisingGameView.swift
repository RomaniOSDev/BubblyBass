//
//  FisingGameView.swift
//  BubblyBass
//
//  Created by Роман Главацкий on 14.10.2025.
//

import SwiftUI

struct FisingGameView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = FisingGameViewModel()
    var body: some View {
        ZStack {
            Image(.seaBack)
                .resizable()
                .ignoresSafeArea()
            VStack(alignment: .leading){
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
                    BlueButtonView(title: "\(viewModel.caughtCount)/\(viewModel.goalCount)", height: 60)
                    Spacer()
                    
                    Image(.fishButLabel)
                        .resizable()
                        .frame(width: 60, height: 60)
                }.padding()
               
                
                ZStack(alignment: .topLeading) {
                     HStack {
                         Image(viewModel.isCasting ? .spiningBig : .spiningSmal)
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(width: 240)
                         Spacer()
                     }
                     .padding(.top, 80)
                    
                    if viewModel.showStatus {
                        HStack {
                            Text(viewModel.statusText)
                                .foregroundStyle(.white)
                                .font(.title3.bold())
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.black.opacity(0.4))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Spacer()
                        }
                        .padding(.top, 24)
                    }
                    GeometryReader { geo in
                        ZStack {
                            // Плавающие рыбы в нижней половине экрана
                            ForEach(viewModel.fishes) { fish in
                                Image(fish.type.imageFish)
                                    .resizable()
                                    .frame(width: 72, height: 48)
                                    .position(x: fish.x, y: fish.y)
                            }
                            
                        }
                        .onAppear {
                            viewModel.start(width: geo.size.width, height: geo.size.height)
                        }
                    }
                    
                }
                
                HStack {
                    Spacer()
                    Button {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                            viewModel.setCasting(true)
                        }
                        viewModel.onFishingAction()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.spring(response: 0.45, dampingFraction: 0.8)) {
                                viewModel.setCasting(false)
                            }
                        }
                    } label: {
                        Image(.fisingBTN)
                            .resizable()
                    }.frame(width: 120, height: 120)
                    Spacer()
                }

                
            }
        }
        .navigationBarBackButtonHidden()
        .overlay(alignment: .center) {
            if viewModel.isFinished {
                ZStack {
                    Color.black.opacity(0.55).ignoresSafeArea()
                    VStack(spacing: 16) {
                        Text("Fishing finished!")
                            .foregroundStyle(.white)
                            .font(.title.bold())
                        Text("Caught: \(viewModel.caughtCount)/\(viewModel.goalCount)")
                            .foregroundStyle(.white)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(Array(viewModel.caughtFish.enumerated()), id: \.offset) { _, fish in
                                    Image(fish.imageFish)
                                        .resizable()
                                        .frame(width: 60, height: 40)
                                }
                            }
                            .padding(.horizontal)
                        }
                        Button {
                            withAnimation(.easeInOut) {
                                viewModel.restartGame()
                            }
                        } label: {
                            BlueButtonView(title: "PLAY AGAIN", height: 60)
                        }
                    }
                    .padding()
                }
                .transition(.opacity)
            }
        }
        .onDisappear { viewModel.stop() }
    }
}

#Preview {
    FisingGameView()
}
