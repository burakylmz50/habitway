//
//  ContentView.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 20.11.2023.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    @State private var isPresentedAddHabitView: Bool = false
    @State private var color: Color = .red
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ScrollView {
                ForEach($viewModel.habits, id: \.id) { $habit in
                    HomeGrassView(habitModel: habit, action: {
                        // let asdas = print(habit)
                    })
                    
                    Spacer(minLength: 20)
                }
            }
            .toolbarTitleDisplayMode(.large)
            .navigationTitle("Habit's")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("", systemImage: "plus.circle.fill") {
                        isPresentedAddHabitView.toggle()
                    }
                }
            }
            .navigationDestination(for: HomeRoute.self) { model in }
            .sheet(isPresented: $isPresentedAddHabitView, onDismiss: {
                viewModel.getHabits()
            }) {
                AddHabitView(
                    viewModel: AddHabitViewModel(),
                    isPresentedAddHabitView: $isPresentedAddHabitView,
                    color: $color
                )
            }
        }
        .onAppear {
            viewModel.getHabits()
        }
    }
}

extension HomeView {
    struct HomeGrassView: View {
        
        var habitModel: HabitModel
        var action: (() -> Void)?
        
        var body: some View {
            HabitView(habitModel: HabitModel(id: .init(), name: "name", description: "description", date: "date", color: .red)) {
                action?()
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(container: ContainerViewModel()))
}
