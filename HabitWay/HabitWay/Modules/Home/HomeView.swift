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
            ScrollView(.vertical) {
                VStack {
                    if !$viewModel.habits.isEmpty {
                        ForEach($viewModel.habits, id: \.id) { $habit in
                            HomeGrassView(habitModel: habit, action: {
                                let asdas = print(habit)
                            })
                            Spacer(minLength: 20)
                        }
                    } else {
                        Text("Gösterilecek Öğe Bulunamadı")
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .background(.red)
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
            HabitView(habitModel: habitModel) {
                action?()
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(container: ContainerViewModel()))
}
