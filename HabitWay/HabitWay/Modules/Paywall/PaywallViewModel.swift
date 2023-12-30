//
//  PaywallViewmodel.swift
//  HabitWay
//
//  Created by Çağrı Döşeyen on 17.12.2023.
//

import Foundation

final class PaywallViewModel: ObservableObject {
    
    @Published var selectedSubscription = SubscriptionData(title: "Monthly", description: "For short stays", price: "$4.99")
    
    static let shared = PaywallViewModel()
    
    init() { }
    
    deinit {
        print("\(self)) Deinitialized")
    }
    
    let subscriptionData = [
        SubscriptionData(title: "Monthly", description: "For short stays", price: "$4.99"),
        SubscriptionData(title: "Yearly", description: "Best value for yearly plans", price: "$29.99"),
        SubscriptionData(title: "Lifetime", description: "One-time payment for a lifetime", price: "$99.99")
    ]
}
