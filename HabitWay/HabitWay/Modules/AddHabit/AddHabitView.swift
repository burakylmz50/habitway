//
//  AddHabitView.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 21.11.2023.
//

import SwiftUI
import SFSymbolsPicker

struct AddHabitView: View {
    
    @ObservedObject var viewModel: AddHabitViewModel
    
    @Binding var isPresentedAddHabitView: Bool
    @Binding var color: Color
    
    @State private var isAddHabitSelector: Bool = false
    @State private var nameTextField = ""
    @State private var descriptionTextField = ""

    @State private var icon = "star.fill"
    @State private var isPresented = false
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        
                        Button("", systemImage: "checkmark") {
                            isPresentedAddHabitView = false
                            
                            viewModel.addHabit(model: .init(
                                id: UUID(),
                                name: nameTextField,
                                description: descriptionTextField,
                                date: "",
                                color: color, icon: icon
                            ))
                        }
                        .disabled(isValidation)
                    }
                    
                    VStack(spacing: 20) {
                        InputView(
                            text: $nameTextField,
                            title: "Name*",
                            placeholder: "Reading books"
                        )
                        
                        InputView(
                            text: $descriptionTextField,
                            title: "Description",
                            placeholder: "Description"
                        )
                        
                        ColorPicker("Select Color", selection: $color)
                            .foregroundStyle(.gray)
                            .font(.headline)
                        
                        HStack {
                            Text("Select Icon")
                                .foregroundStyle(.gray)
                                .font(.headline)
                            
                            Spacer()
                            
                            Button("", systemImage: icon) {
                                isPresented.toggle()
                            }
                            .tint(.gray)
                            .sheet(isPresented: $isPresented, content: {
                                SymbolsPicker(selection: $icon, title: "Pick a symbol", autoDismiss: true)
                            })
                        }
                    }
                }
            }
            .padding()
            .navigationDestination(for: HomeRoute.self) { model in }
            .sheet(isPresented: $isAddHabitSelector, onDismiss: {
                // TODO: HandleDismiss
            }) {
                
            }
        }
    }
    
    var isValidation: Bool {
        nameTextField.count < 3
    }
}
//
//#Preview {
//    AddHabitView(
//        viewModel: AddHabitViewModel(),
//        isPresentedAddHabitView: .constant(true), color: .constant(.red)
//    )
//}
