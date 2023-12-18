//
//  Paywall.swift
//  HabitWay
//
//  Created by Çağrı Döşeyen on 11.12.2023.
//

import SwiftUI

struct Paywall: View {
    @State private var showAllSubscriptions = false
    @ObservedObject var paywallViewModel = PaywallViewModel.shared
    @State private var isAnimating = true

    
    var body: some View {
        ZStack {
            VStack(spacing: showAllSubscriptions ? 2 : 8){
                Spacer()
                HStack(alignment: .center) {
                            ZStack(alignment: .center) {
                                Image("wheat_wreath_left")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .padding(.trailing,-20)

                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 80, height: 80)
                                    .offset(y: isAnimating ? -80 : 0)
                                    .animation(Animation.easeInOut(duration: 0.3).delay(0.3))
                                    .opacity(showAllSubscriptions ? 0 : 1)

                            }

                            Text("Pro")
                                .font(.system(size: 40))
                                .foregroundColor(Color.black)
                                .onTapGesture {
                                    withAnimation {
                                        isAnimating.toggle()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            withAnimation {
                                                isAnimating.toggle()
                                            }
                                        }                                    }
                                }

                            ZStack(alignment: .center) {
                                Image("wheat_wreath_right")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .padding(.leading,-20)

                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 80, height: 80)
                                    .offset(y: isAnimating ? -80 : 0)
                                    .animation(Animation.easeInOut(duration: 0.3).delay(0.3))
                                    .opacity(showAllSubscriptions ? 0 : 1)

                            }
                        }
                Text("Unlimited Cards")
                    .font(.system(size: 24))
                    .foregroundColor(Color.black)
                Text("Auto-transition")
                    .font(.system(size: 24))
                    .foregroundColor(Color.black)
                Text("Multiple languages")
                    .font(.system(size: 24))
                    .foregroundColor(Color.black)
                Text("AI Copilot")
                    .font(.system(size: 24))
                    .foregroundColor(Color.gray)
                Text("Custom lists")
                    .font(.system(size: 24))
                    .foregroundColor(Color.gray)
                Spacer()
                
                if showAllSubscriptions {
                    VStack(spacing: 7) {
                        ForEach(paywallViewModel.subscriptionData, id: \.self) { subscription in
                            PaywallEntity(entity: subscription, showSubscriptions: $showAllSubscriptions, paywallViewModel: paywallViewModel)
                        }
                    }
                    .transition(.opacity)
                } else {
                    let entity = paywallViewModel.selectedSubscription
                    PaywallEntity(entity: entity, showSubscriptions: $showAllSubscriptions, paywallViewModel: paywallViewModel)
                        .onTapGesture {
                            withAnimation {
                                showAllSubscriptions.toggle()
                            }
                        }
                        .transition(.opacity)
                }
                
                Button {
                    
                } label: {
                    HStack {
                        Text("Subscribe")
                            .font(.system(size: 20))
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                    }
                    .frame(minHeight: 80)
                    .padding(10)
                    .padding(.horizontal, 100)
                    .background(
                        RoundedRectangle(cornerRadius: 22)
                            .fill(Color(red: 24/255, green: 24/255, blue: 24/255))
                            .frame(height: 45)
                    )
                }
                .padding(.top, 10)
                
                Text("Restore Purchases")
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black)
                Text("Recurring billing - cancel any time")
                    .font(.system(size: 11))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black)
                    .opacity(0.6)
                    
                
            }
        }
    }
}

struct SubscriptionData: Identifiable ,Hashable {
    var id = UUID()
    var title: String
    var description: String
    var price: String
}



#Preview {
    Paywall()
}
