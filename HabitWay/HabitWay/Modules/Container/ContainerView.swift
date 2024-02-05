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
    @State var viewModel = ContainerViewModel()
    var paywallViewModel = PaywallViewModel()
    
    private let dataController = DataController.shared
    
    var body: some View {
        if !isLaunchScreenViewPresented {
            NavigationStack(path: $viewModel.navigationPath) {
                HomeView(viewModel: viewModel.homeViewModel!)
                    .environment(paywallViewModel)
            }
        } else {
            LaunchScreen(isPresented: $isLaunchScreenViewPresented)
        }
    }
}
