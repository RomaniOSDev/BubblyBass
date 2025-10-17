//
//  SettingsView.swift
//  BubblyBass
//
//  Created by Роман Главацкий on 17.10.2025.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
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
                    BlueButtonView(title: "SETTINGS", height: 60)
                    Spacer()
                    
                    Image(.settingButLabel)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .opacity(0)
                }
                VStack(spacing: 20){
                    Button {
                        if let url = URL(string: "https://www.termsfeed.com/live/2d9aeb72-99df-4048-9c92-83972277445d") {
                                UIApplication.shared.open(url)
                        }
                    } label: {
                        BlueButtonView(title: "Terms of Use", height: 100)
                    }
                    Button {
                        if let url = URL(string: "https://www.termsfeed.com/live/48583598-1915-4899-89e1-5753d1151d45") {
                                UIApplication.shared.open(url)
                        }
                    } label: {
                        BlueButtonView(title: "Privacy Policy", height: 100)
                    }
                    Button {
                        SKStoreReviewController.requestReview()
                    } label: {
                        BlueButtonView(title: "Rate us", height: 100)
                    }

                }
                .padding()
                .padding(.top, 40)
                Spacer()
            }.padding()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SettingsView()
}
