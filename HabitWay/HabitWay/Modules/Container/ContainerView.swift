//
//  ContainerView.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 21.11.2023.
//

import SwiftUI

struct ContainerView: View {
    
    @State private var isLaunchScreenViewPresented = true
    @StateObject var viewModel = ContainerViewModel()

    let dataController = DataController.shared
    
    var body: some View {
        if !isLaunchScreenViewPresented {
            NavigationStack(path: $viewModel.navigationPath) {
                HomeView(viewModel: viewModel.homeViewModel)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            }
        } else {
                LaunchScreen(isPresented: $isLaunchScreenViewPresented)
        }
    }
}
