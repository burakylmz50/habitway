//
//  ContentView.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 20.11.2023.
//

import SwiftUI

struct HomeView: View {
    
//    @Environment(PaywallViewModel.self) var paywallViewModel
    
    @State var viewModel: HomeViewModel
    @State var paywallViewModel: PaywallViewModel
    
    @State private var isPresentedAddHabitView: Bool = false
    @State private var isPresentedPaywall: Bool = false
    @State private var color: Color = .clear
    
    @State var isActive: Bool = false
    @State var isLoading: Bool = false
    
    var body: some View {
        List {
            HomeHeaderView()
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 0, leading: 16, bottom: 0, trailing: 0))
            
            if !viewModel.habits.isEmpty {
                ForEach(viewModel.habits, id: \.id) { habit in
                    HomeGrassView(habitModel: habit, action: {
                        viewModel.editHabit(habitModel: habit)
                    })
                    .background(Color.clear)
                    .listRowSeparator(.hidden)
                    .buttonStyle(PlainButtonStyle())
                    .contextMenu {
                        Button {
                            DispatchQueue.main.async {
                                withAnimation {
                                    if viewModel.removeHabit(habit: habit) {
                                        viewModel.getHabits()
                                    }
                                }
                                
                            }
                        } label: {
                            Label("Delete Habit", systemImage: "trash")
                        }
                    }
                }
            } else {
                ContentUnavailableView()
                    .listRowSeparator(.hidden)
            }
        }
        .navigationTitle("Habits")
        .listStyle(.plain)
        .overlay {
             if paywallViewModel.isLoading {
                 ProgressView("Loading")
             }
        }
//        .background(Color.backgroundColor)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button("", systemImage: "star.square.on.square.fill") {
                        viewModel.paywallButton()
                    }
                    .tint(Color.brandColor)
                    .opacity(paywallViewModel.isActive ? 0:1)
                    
                    Button("", systemImage: "plus.circle.fill") {
                        viewModel.addButton()
                    }
                    .tint(Color.brandColor)
                }
            }
        }
        .sheet(item: $viewModel.activeSheet) {
            viewModel.getHabits()
        } content: { sheet in
            switch sheet {
            case .addHabit:
                AddHabitView(
                    color: $color, viewModel: AddHabitViewModel()
                )
                .presentationDetents([.large])
            case .paywall:
                Paywall(viewModel: paywallViewModel, isActive: $isActive, isLoading: $isLoading)
            }
        }
        .onAppear {
            viewModel.setup(paywallViewModel: paywallViewModel)
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

extension HomeView {
    struct ContentUnavailableView: View {
        
        var body: some View {
            SwiftUI.ContentUnavailableView {
                Label("No Habit for", systemImage: "calendar.badge.exclamationmark")
            } description: {
                Text("To add a habit, click the plus button in the top right.")
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(container: ContainerViewModel()), paywallViewModel: .init())
}
