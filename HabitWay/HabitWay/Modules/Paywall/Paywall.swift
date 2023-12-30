//
//  Paywall.swift
//  HabitWay
//
//  Created by Çağrı Döşeyen on 11.12.2023.
//

import SwiftUI

struct Paywall: View {
    
    @State private var showAllSubscriptions = false
    @State private var isAnimating = true
    
    @ObservedObject var paywallViewModel = PaywallViewModel.shared
    
    var body: some View {
        ZStack {
            VStack(spacing: showAllSubscriptions ? 2 : 8){
                Spacer()
                
                HStack(alignment: .center) {
                    ZStack(alignment: .center) {
                        Image("wheat_wreath_left")
                            .resizable()
                            .frame(width: 40, height: 60)
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 40, height: 60)
                            .offset(y: isAnimating ? -60 : 0)
                            .animation(.easeInOut(duration: 0.5))
                            .opacity(showAllSubscriptions ? 0 : 1)
                    }
                    .padding(.trailing, -10)
                    
                    Text("Pro")
                        .font(.system(size: 40))
                        .foregroundColor(Color.black)
                        .onTapGesture {
                            withAnimation {
                                isAnimating.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation {
                                        isAnimating.toggle()
                                    }
                                }
                            }
                        }
                    
                    ZStack(alignment: .center) {
                        Image("wheat_wreath_right")
                            .resizable()
                            .frame(width: 40, height: 60)
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 40, height: 60)
                            .offset(y: isAnimating ? -60 : 0)
                            .animation(.easeInOut(duration: 0.5))
                            .opacity(showAllSubscriptions ? 0 : 1)
                    }
                    .padding(.leading, -10)
                }
                
                Text("Unlimited habits")
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                
                HStack {
                    Text("Advanced insights")
                        .font(.system(size: 20))
                        .foregroundColor(Color.gray)
                    
                    Rectangle()
                        .fill(Color(red: 245/255, green: 245/255, blue: 245/255))
                        .overlay(
                            Text("Soon")
                                .font(.system(size: 8, weight: .semibold))
                            
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        .frame(width: 30, height: 20)
                }
                
                HStack {
                    Text("Custom app icons")
                        .font(.system(size: 20))
                        .foregroundColor(Color.gray)
                        .frame(height: 20)
                    
                    Rectangle()
                        .fill(Color(red: 245/255, green: 245/255, blue: 245/255))
                        .overlay(
                            Text("Soon")
                                .font(.system(size: 8, weight: .semibold))
                            
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        .frame(width: 30, height: 20)
                }
                
                HStack() {
                    Text("Reminder notifications")
                        .font(.system(size: 20))
                        .foregroundColor(Color.gray)
                        .frame(height: 20)
                    
                    Rectangle()
                        .fill(Color(red: 245/255, green: 245/255, blue: 245/255))
                        .overlay(
                            Text("Soon")
                                .font(.system(size: 8, weight: .semibold))
                            
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        .frame(width: 30, height: 20)
                }
                
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    isAnimating.toggle()
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    isAnimating.toggle()
                }
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
