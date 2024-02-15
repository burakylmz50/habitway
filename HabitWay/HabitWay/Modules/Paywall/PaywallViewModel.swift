//
//  PaywallViewmodel.swift
//  HabitWay
//
//  Created by Çağrı Döşeyen on 17.12.2023.
//

import Foundation
import RevenueCat

@Observable
final class PaywallViewModel {
    
    var currentOffering: Offering?
    var selectedPackage: Package?
    var isActive: Bool = false
    var isPresentedPaywallView: Bool = false
    var isLoading = true
    
    init() {
        Purchases.configure(withAPIKey: "appl_gwaLRxMtIMAyiDFNskVzLzqlhZp")
        
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
                isPresentedPaywallView = true
                if purchase.customerInfo.entitlements.all["Pro"]?.isActive == true {
                    isActive = true
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
                isActive = true
            }
            if let _ = error {
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
