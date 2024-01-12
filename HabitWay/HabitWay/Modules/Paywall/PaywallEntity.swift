//
//  PaywallEntity.swift
//  HabitWay
//
//  Created by Çağrı Döşeyen on 11.12.2023.
//

import SwiftUI
import RevenueCat

struct PaywallEntity: View {
    var package: Package
    
    @Binding var showSubscriptions : Bool
    @ObservedObject var paywallViewModel: PaywallViewModel
    
    var body: some View {
        Button {
            if showSubscriptions {
                paywallViewModel.selectedPackage = package
            }
            withAnimation {
                showSubscriptions.toggle()
            }
        } label: {
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    if let subscriptionPeriod = package.storeProduct.subscriptionPeriod {
                        Text("\(subscriptionPeriod.unit)ly".capitalized)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.black)
                    }

                    Text(package.storeProduct.localizedTitle)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.black)
                        .opacity(0.6)
                }
                .padding()
                Spacer()
                Text(package.localizedPriceString)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black)
                    .padding()
            }
            .frame(minHeight: 80)
            .background(Color(red: 245/255, green: 245/255, blue: 245/255))
            .cornerRadius(16)
            .padding(.horizontal,10)
        }
    }
}
