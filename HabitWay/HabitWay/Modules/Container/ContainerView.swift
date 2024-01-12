//
//  ContainerView.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 21.11.2023.
//

import SwiftUI
import RevenueCat

struct ContainerView: View {
    
    @State private var isLaunchScreenViewPresented = true
    @StateObject var viewModel = ContainerViewModel()
    @StateObject var paywallViewModel = PaywallViewModel()
    
    private let dataController = DataController.shared
    
    init() {
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_gwaLRxMtIMAyiDFNskVzLzqlhZp")
    }
    
    var body: some View {
        if !isLaunchScreenViewPresented {
            NavigationStack(path: $viewModel.navigationPath) {
                HomeView(viewModel: viewModel.homeViewModel)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .environmentObject(paywallViewModel)
            }
        } else {
            LaunchScreen(isPresented: $isLaunchScreenViewPresented)
        }
    }
}
