//
//  PaywallViewmodel.swift
//  HabitWay
//
//  Created by Çağrı Döşeyen on 17.12.2023.
//

import Foundation
import RevenueCat

@MainActor
final class PaywallViewModel: ObservableObject {
    
    @Published var currentOffering: Offering?
    var selectedPackage: Package?
    
    @Published var isActive: Bool = false
    
    @Published var isPresentedPaywallView: Bool = false
    
    @Published var isLoading = true
    
    init() {
        Task {
            do {
                try await getOfferings()
                try await getCustomerInfo()
                
                setupSelectedPackage()
            } catch {
                print(error)
            }
        }
    }
    
    deinit {
        print("\(self)) Deinitialized")
    }
    
    func getPurchase() async throws {
        isLoading = true
        Task {
            if let selectedPackage = selectedPackage {
                let purchase =  try await Purchases.shared.purchase(package: selectedPackage)
                isLoading = false
                if purchase.customerInfo.entitlements.all["Pro"]?.isActive == true {
                    isActive = true
                    isPresentedPaywallView = true
                } else {
                    isActive = false
                }
            }
        }
    }
    
    func getRestorePurchases() {
        isLoading = true
        Purchases.shared.restorePurchases { [weak self] customerInfo, error in
            guard let self else { return }
            isLoading = false
            if let customerInfo = customerInfo, let product = customerInfo.entitlements.all["Pro"],
               product.isActive {
                // Başarılı bir şekilde active edildi. // Dismiss olması lazım
                isActive = true
            }
            if let error = error {
                isActive = false
            }
        }
    }
    
    private func setupSelectedPackage() {
        self.selectedPackage = currentOffering?.availablePackages.first
    }
    
    private func getOfferings() async throws {
        currentOffering = try await Purchases.shared.offerings().current
    }
    
    private func getCustomerInfo() async throws {
        isLoading = true
        do {
            let customerInfo = try await Purchases.shared.customerInfo()
            self.isLoading = false
            guard let entitlement = customerInfo.entitlements.all["Pro"] else {
                return
            }
            
            self.isActive = entitlement.isActive
        } catch {
            print(error)
        }
    }
}
