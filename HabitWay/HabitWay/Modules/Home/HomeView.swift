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
                                let _ = print(habit)
                            })
                            .contextMenu {
                                Button {
                                    print(habit)
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            if viewModel.removeHabit(habitModel: habit) {
                                                // TODO: eleman silinince freeze meydana geliyor.
                                                viewModel.getHabits()
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
            .navigationTitle("Habit's")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("", systemImage: "plus.circle.fill") {
                        isPresentedAddHabitView.toggle()
                    }
                    .tint(Color.brandColor)
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
                .presentationDetents([.large])
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
