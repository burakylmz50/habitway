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
    
    @FocusState private var focusedField: String?
    
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
                                title: nameTextField,
                                subtitle: descriptionTextField,
                                date: [""],
                                color: color,
                                icon: icon
                            ))
                        }
                        .tint(.brandColor)
                        .disabled(isValidation)
                    }
                    
                    VStack(spacing: 20) {
                        InputView(
                            text: $nameTextField,
                            title: "Name (Required)",
                            placeholder: "Reading books"
                        )
                        .onAppear {
                            focusedField = "nameTextField"
                        }
                        
                        InputView(
                            text: $descriptionTextField,
                            title: "Description",
                            placeholder: "Description"
                        )
                        
                        SquareColorPickerView(colorValue: $color)
                        
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

struct SquareColorPickerView: View {
    
    @Binding var colorValue: Color
    
    var body: some View {
        
        colorValue
            .frame(width: 40, height: 40, alignment: .center)
            .cornerRadius(10.0)
            .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(Color.white, style: StrokeStyle(lineWidth: 5)))
            .padding(10)
            .background(AngularGradient(gradient: Gradient(colors: [.red,.yellow,.green,.blue,.purple,.pink]), center:.center).cornerRadius(20.0))
            .overlay(ColorPicker("", selection: $colorValue).labelsHidden().opacity(0.015))
            .shadow(radius: 5.0)
        
    }
}

#Preview {
    AddHabitView(
        viewModel: AddHabitViewModel(),
        isPresentedAddHabitView: .constant(true), color: .constant(.red)
    )
}
