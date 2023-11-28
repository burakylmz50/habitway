//
//  ContainerViewModel.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 21.11.2023.
//

import SwiftUI

class ContainerViewModel: ObservableObject {
    
    @Published var navigationPath = NavigationPath()
    
    init() { }
    
    deinit {
        print("\(self)) Deinitialized")
    }
    
    lazy var homeViewModel = {
        HomeViewModel(container: self)
    }()
}
