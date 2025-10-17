//
//  FishCellView.swift
//  BubblyBass
//
//  Created by Роман Главацкий on 15.10.2025.
//

import SwiftUI

struct FishCellView: View {
    var fish: Fish
    var body: some View {
        ZStack{
                Image(.backToFish)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            
            VStack{
                ZStack {
                    Image(.backonfish)
                        .resizable()
                        .frame(width: 81, height: 81)
                    Image(fish.imageFish)
                        .resizable()
                        .frame(width: 62, height: 50)
                }
                    Text(fish.name)
                    .foregroundStyle(.white)
                    .font(Font.largeTitle.bold())
                Text("The chance of finding this fish is \(fish.chanceToCatch) %")
                    .foregroundStyle(.white)
                    
            }
            .padding()
        }
    }
}

#Preview {
    FishCellView(fish: Fish.fish1)
}
