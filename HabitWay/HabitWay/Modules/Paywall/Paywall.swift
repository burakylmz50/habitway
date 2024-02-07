//
//  Paywall.swift
//  HabitWay
//
//  Created by Çağrı Döşeyen on 11.12.2023.
//

import SwiftUI
import RevenueCat

struct Paywall: View {
    
    var viewModel: PaywallViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showAllSubscriptions = false
    @State private var isAnimating = true
    
    @Binding var isActive: Bool
    @Binding var isLoading: Bool

    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                VStack(spacing: showAllSubscriptions ? 4 : 12) {
                    HStack(alignment: .center) {
                        ZStack(alignment: .center) {
                            Image("wheat_wreath_left")
                                .resizable()
                                .frame(width: 40, height: 60)
                            
                            Rectangle()
                                .fill(Color.backgroundColor)
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
                                .fill(Color.backgroundColor)
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
                            .fill(Color.gray.opacity(0.6))
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
                            .fill(Color.gray.opacity(0.6))
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
                            .fill(Color.gray.opacity(0.6))
                            .overlay(
                                Text("Soon")
                                    .font(.system(size: 8, weight: .semibold))
                                
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .frame(width: 30, height: 20)
                    }
                }
                .scaleEffect(showAllSubscriptions ? 0.8 : 1)
                
                Spacer()
                
                if let currentOffering = viewModel.currentOffering {
                    if showAllSubscriptions {
                        VStack(spacing: 7) {
                            ForEach(currentOffering.availablePackages, id: \.self) { package in
                                PaywallEntity(
                                    package: package,
                                    showSubscriptions: $showAllSubscriptions,
                                    paywallViewModel: viewModel
                                )
                            }
                        }
                        .transition(.opacity)
                    } else {
                        if let package = viewModel.selectedPackage {
                            PaywallEntity(
                                package: package,
                                showSubscriptions: $showAllSubscriptions,
                                paywallViewModel: viewModel
                            )
                            .transition(.opacity)
                            .onTapGesture {
                                withAnimation {
                                    showAllSubscriptions.toggle()
                                }
                            }
                        }
                    }
                }
                
                VStack {
                    Button {
                        withAnimation {
                            showAllSubscriptions.toggle()
                        }
                    } label: {
                        Text(showAllSubscriptions ? "Collapse Plans" : "See All Plans")
                            .font(.footnote)
                            .tint(.primary)
                            .transition(.opacity)
                    }
                    .padding(.top, 10)
                    
                    
                    Button {
                        Task {
                            try await viewModel.getPurchase()
                        }
                        dismiss()
                    // TODO: progress view dönder. Bitince dismiss et
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
                    
                    Button(action: {
                        viewModel.getRestorePurchases()
                    }, label: {
                        Text("Restore Purchases")
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.black)
                    })
                    
                    Text("Recurring billing - cancel any time")
                        .font(.system(size: 11))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.black)
                        .opacity(0.6)
                    
                    HStack {
                        Button(action: {
                            let url = URL.init(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")
                            guard let stackOverflowURL = url, UIApplication.shared.canOpenURL(stackOverflowURL) else { return }
                            UIApplication.shared.open(stackOverflowURL)
                        }, label: {
                            Text("Terms of Use (EULA)")
                                .font(.system(size: 8))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.black)
                        })
                        
                        Button(action: {
                            let url = URL.init(string: "https://www.freeprivacypolicy.com/live/10cfb522-a253-4576-b61c-8eb96cd759b4")
                            guard let stackOverflowURL = url, UIApplication.shared.canOpenURL(stackOverflowURL) else { return }
                            UIApplication.shared.open(stackOverflowURL)
                        }, label: {
                            Text("Privacy Policy")
                                .font(.system(size: 8))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.black)
                        })
                    }
                    .padding(.top, 30)
                }
            }
        }
        .background(Color.backgroundColor)
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
        .onChange(of: viewModel.isActive) { oldValue, newValue in
            isActive = newValue
        }
    }
}

#Preview {
    Paywall(viewModel: .init(), isActive: .constant(true), isLoading: .constant(true))
}

extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}
