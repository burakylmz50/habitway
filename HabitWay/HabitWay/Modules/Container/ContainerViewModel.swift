//
//  ContainerViewModel.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 21.11.2023.
//

import SwiftUI

@Observable
class ContainerViewModel {
    
    var navigationPath = NavigationPath()
    var homeViewModel: HomeViewModel?
    
    init() {
        homeViewModel = .init(container: self)
    }
    
    deinit {
        print("\(self)) Deinitialized")
    }
}
