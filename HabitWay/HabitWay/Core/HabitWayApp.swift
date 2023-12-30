//
//  HabitWayApp.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 20.11.2023.
//

import SwiftUI

@main
struct HabitWayApp: App {
    var body: some Scene {
        WindowGroup {
            ContainerView()
                .overlay(alignment: .top) {
                    GeometryReader { proxy in
                        let size = proxy.size
                        NotificationView(size: size)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    }
                    .ignoresSafeArea()
                }
        }
    }
}
