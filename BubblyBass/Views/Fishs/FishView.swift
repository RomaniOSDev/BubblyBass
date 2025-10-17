//
//  FishView.swift
//  BubblyBass
//
//  Created by Роман Главацкий on 15.10.2025.
//

import SwiftUI

struct FishView: View {
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
                    BlueButtonView(title: "FISHES", height: 60)
                    Spacer()
                    
                        Image(.settingButLabel)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .opacity(0)
                }
                ScrollView {
                    ForEach(Fish.allCases, id: \.self) { fish in
                        FishCellView(fish: fish)
                    }
                }
            }.padding()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    FishView()
}
