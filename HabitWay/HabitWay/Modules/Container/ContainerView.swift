//
//  ContainerView.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 21.11.2023.
//

import SwiftUI

struct ContainerView: View {
    
    @StateObject var viewModel = ContainerViewModel()

    let dataController = DataController.shared
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            HomeView(viewModel: viewModel.homeViewModel)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
