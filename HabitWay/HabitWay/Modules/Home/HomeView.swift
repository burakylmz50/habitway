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
    @State private var isPresentedPaywall: Bool = false
    @State private var color: Color = .clear
    
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
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
                    if !$viewModel.habits.isEmpty {
                        ForEach($viewModel.habits, id: \.id) { $habit in
                            HomeGrassView(habitModel: habit, action: {
                                if viewModel.editHabit(habitModel: habit) {
                                    NotificationCenter.default.post(
                                        name: .init("NOTIFY"),
                                        object: NotificationModel(
                                            title: "Dynamic Island",
                                            content: "This is an example 😍"
                                        )
                                    )
                                }
                            })
                            .contextMenu {
                                Button {
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            if viewModel.removeHabit(habitModel: habit) {
                                                viewModel.getHabits()
                                                
                                                NotificationCenter.default.post(
                                                    name: .init("NOTIFY"),
                                                    object: NotificationModel(
                                                        title: "Dynamic Island",
                                                        content: "This is an example 😍"
                                                    )
                                                )
                                            }
                                        }
                                        
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
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
            .background(Color.backgroundColor)
            .toolbarTitleDisplayMode(.large)
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button("", systemImage: "star.square.on.square.fill") {
                            isPresentedPaywall.toggle()
                        }
                        .tint(Color.brandColor)
                        .opacity(1)
                        .sheet(isPresented: $isPresentedPaywall, onDismiss: {
                           
                        }) {
                            Paywall()
                            .presentationDetents([.large])
                        }
                        
                        Button("", systemImage: "plus.circle.fill") {
                            isPresentedAddHabitView.toggle()
                        }
                        .tint(Color.brandColor)
                        .sheet(isPresented: $isPresentedAddHabitView, onDismiss: {
                            viewModel.getHabits()
                        }) {
                            AddHabitView(
                                viewModel: AddHabitViewModel(),
                                isPresentedAddHabitView: $isPresentedAddHabitView,
                                color: $color
                            )
                            .presentationDetents([.large])
                        }
                    }
                }
            }
            .navigationDestination(for: HomeRoute.self) { model in }
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
