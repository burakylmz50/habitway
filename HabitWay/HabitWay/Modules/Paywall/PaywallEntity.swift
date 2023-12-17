//
//  PaywallEntity.swift
//  HabitWay
//
//  Created by Çağrı Döşeyen on 11.12.2023.
//

import SwiftUI
struct PaywallEntity: View {
    @State var entity : SubscriptionData
    @Binding var showSubscriptions : Bool
    @ObservedObject var paywallViewModel = PaywallViewModel.shared

    var body: some View {
        Button {
            if showSubscriptions {
                paywallViewModel.selectedSubscription = entity
            }
            withAnimation {
                showSubscriptions.toggle()
            }
        } label: {
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    Text(entity.title)
                           .font(.headline)
                    Text(entity.description)
                           .font(.subheadline)
                   }
                   .padding()
                   Spacer()
                Text(entity.price)
                       .padding()
               }
               .frame(minHeight: 80)
               .background(Color(red: 245/255, green: 245/255, blue: 245/255))
               .cornerRadius(16)
               .padding(.horizontal,10)
        }
    }
}


