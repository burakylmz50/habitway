//
//  ContentView.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 20.11.2023.
//

import SwiftUI

struct HomeView: View {
        
    @Environment(PaywallViewModel.self) var paywallViewModel
    
    @State var viewModel: HomeViewModel
    
    @State private var isPresentedAddHabitView: Bool = false
    @State private var isPresentedPaywall: Bool = false
    @State private var color: Color = .clear
    
    @State var isActive: Bool = false
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                HStack {
                    Text(Date().toString(withFormat: "dd MMMM"))
                        .font(.title)
                        .foregroundStyle(.gray.opacity(0.4))
                        .bold()
                    
                    Spacer()
                }
                .padding(.leading)
                VStack {
                    if !viewModel.habits.isEmpty {
                        ForEach(viewModel.habits, id: \.id) { habit in
                            HomeGrassView(habitModel: habit, action: {
                                 if viewModel.editHabit(habitModel: habit) {
                                     viewModel.getHabits()
                                 }
                            })
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
                            
                            Spacer(minLength: 20)
                        }
                        .id(UUID())
                    } else {
                        ContentUnavailableView()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .overlay {
                //                if paywallViewModel.isLoading {
                //                    ProgressView("Loading")
                //                }
            }
            .background(Color.backgroundColor)
            .toolbarTitleDisplayMode(.large)
            .navigationTitle("Habits")
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
                    Paywall(isActive: $isActive, isLoading: $isLoading)
                }
            }
        }
        .onAppear {
            viewModel.setup(paywallViewModel: paywallViewModel)
            viewModel.getHabits()
        }
        .disabled(paywallViewModel.isLoading)
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
    HomeView(viewModel: HomeViewModel(container: ContainerViewModel()))
}
