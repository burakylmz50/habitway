//
//  AddHabitView.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 21.11.2023.
//

import SwiftUI

struct AddHabitView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) private var scheme
    
    @Binding var color: Color
    
    @FocusState private var keyboardFocused: Bool
    
    @State private var nameTextField = ""
    @State private var descriptionTextField = ""
    @State private var icon = "star.fill"
    @State private var tabSelectedValue: TabModel?
    @State private var tabProgress: CGFloat = 0
    @State private var selectedColorIndex: Int?
    @State private var selectedIcon: String?
    @State private var isKeyboardVisible = true
    
    @State var viewModel: AddHabitViewModel
    
    private let symbolsColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let colorsColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var colors: [Color] = [
        .red,
        .green,
        .blue,
        .orange,
        .purple,
        .yellow,
        .mint,
        .teal,
        .cyan,
        .indigo,
        .pink,
        .brown
    ]
    
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 15) {
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                       dismiss()
                    }, label: {
                        Image(systemName: "chevron.down.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding([.top, .trailing])
                            .foregroundStyle(.gray.opacity(0.5))
                    })
                }
                
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(selectedColorIndex != nil ? colors[selectedColorIndex!] : .gray.opacity(0.1))
                            .frame(width: 100, height: 100)
                            .cornerRadius(20)
                            .overlay(
                                Image(systemName: selectedIcon != nil ? selectedIcon! : "selection.pin.in.out")
                                    .resizable()
                                    .foregroundStyle(selectedColorIndex != nil ? .white : .gray.opacity(0.5))
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .font(.headline)
                                
                            )
                            .padding(.top, 30)
                        
                        TextField("New Habit", text: $nameTextField)
                            .fontWeight(.semibold)
                            .font(.title)
                            .frame(alignment: .center)
                            .multilineTextAlignment(.center)
                            .autocorrectionDisabled()
                            .focused($keyboardFocused)
                            .onAppear {
                                keyboardFocused = true
                            }
                        
                        Text(nameTextField == "" ? "Tap to add name" : "Tap to rename")
                            .foregroundStyle(.tertiary)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .tint(.gray.opacity(0.4))
                            .opacity(isKeyboardVisible ? 0 : 1)
                        
                        Button(action: {
                            if nameTextField.count > 2 {
                                keyboardFocused = false
                            }
                        }, label: {
                            Text("Add")
                                .frame(width: 100, height: !isKeyboardVisible ? 0 : 30)
                                .background(nameTextField.count > 2 ? .brand : .gray.opacity(0.2))
                                .foregroundStyle(nameTextField.count > 2 ? .black.opacity(0.8) : .gray.opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .disabled(nameTextField.count < 2)
                                .opacity(!isKeyboardVisible ? 0 : 1)
                        })
                        
                    }
                    .scaleEffect(isKeyboardVisible ? CGSize(width: 1.5, height: 1.5) : CGSize(width: 1, height: 1), anchor: .center)
                    .offset(y: isKeyboardVisible ? 100 : 0)
                    .animation(.spring(), value: isKeyboardVisible)
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
                    self.isKeyboardVisible = true
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    self.isKeyboardVisible = false
                }
                .onTapGesture {
                    keyboardFocused = true
                    if nameTextField == "" && !isKeyboardVisible {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
                
                VStack {
                    
                    CustomTabBar()
                        .padding(.top, 20)
                    
                    GeometryReader {
                        let size  = $0.size
                        
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 0) {
                                GeometryReader {
                                    let size = $0.size
                                    
                                    ScrollView {
                                        LazyVGrid(columns: symbolsColumns, spacing: 10) {
                                            Section() {
                                                ForEach(SFSymbols.fitness, id: \.self) { emoji in
                                                    Rectangle()
                                                        .frame(width: size.width/6)
                                                        .background(emoji == selectedIcon ? colors[selectedColorIndex ?? 0] : .gray.opacity(0.1))
                                                        .overlay {
                                                            Image(systemName: emoji)
                                                                .resizable()
                                                                .foregroundStyle(emoji == selectedIcon ? .white : .gray.opacity(0.5))
                                                                .aspectRatio(contentMode: .fit)
                                                                .font(.headline)
                                                                .padding(12)
                                                            
                                                        }
                                                        .modifier(SymbolsGridStyle())
                                                        .onTapGesture {
                                                            selectedIcon = emoji
                                                            if selectedColorIndex == nil {
                                                                selectedColorIndex = 0
                                                            }
                                                        }
                                                    
                                                    
                                                }
                                            } header: {
                                                HStack {
                                                    Text(SFSymbolsType.fitness.rawValue)
                                                        .bold()
                                                    Spacer()
                                                }
                                            }
                                            
                                            Section() {
                                                ForEach(SFSymbols.weather, id: \.self) { emoji in
                                                    Rectangle()
                                                        .frame(width: size.width/6)
                                                        .background(emoji == selectedIcon ? colors[selectedColorIndex ?? 0] : .gray.opacity(0.1))
                                                        .overlay {
                                                            Image(systemName: emoji)
                                                                .resizable()
                                                                .foregroundStyle(emoji == selectedIcon ? .white : .gray.opacity(0.5))
                                                                .aspectRatio(contentMode: .fit)
                                                                .font(.headline)
                                                                .padding(12)
                                                            
                                                        }
                                                        .onTapGesture {
                                                            selectedIcon = emoji
                                                        }
                                                        .modifier(SymbolsGridStyle())
                                                    
                                                }
                                            } header: {
                                                HStack {
                                                    Text(SFSymbolsType.weather.rawValue)
                                                        .bold()
                                                    Spacer()
                                                }
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                    
                                    
                                }
                                .id(TabModel.symbol)
                                .containerRelativeFrame(.horizontal)
                                
                                ScrollView {
                                    LazyVGrid(columns: colorsColumns, spacing: 10) {
                                        
                                        ForEach(0..<colors.count) { index in
                                            Rectangle()
                                                .fill(colors[index])
                                                .cornerRadius(30)
                                                .aspectRatio(contentMode: .fill)
                                                .onTapGesture {
                                                    selectedColorIndex = index
                                                }
                                                .overlay(
                                                    Circle()
                                                        .stroke(
                                                            index == selectedColorIndex ? colors[index].opacity(0.5) : Color.clear,
                                                            style: StrokeStyle(
                                                                lineWidth: 6,
                                                                lineCap: .round,
                                                                lineJoin: .miter,
                                                                miterLimit: 0,
                                                                dashPhase: 0
                                                            )
                                                        )
                                                        .frame(width: 60, height: 60)
                                                    
                                                )
                                        }
                                    }
                                    .padding()
                                }
                                .id(TabModel.color)
                                .containerRelativeFrame(.horizontal)
                            }
                            .scrollTargetLayout()
                            .offsetX { value in
                                let progress = -value / (size.width * CGFloat(TabModel.allCases.count - 1))
                                
                                tabProgress = max(min(progress, 1), 0)
                            }
                        }
                        .scrollPosition(id: $tabSelectedValue)
                        .scrollIndicators(.hidden)
                        .scrollTargetBehavior(.paging)
                        .scrollClipDisabled()
                    }
                    
                    Button {
                        dismiss()
                        
                        viewModel.addHabit(habit: .init(
                            color: colors[selectedColorIndex ?? 0].toHex() ?? "$0000FF",
                            date: [""],
                            icon: selectedIcon ?? "AppIcon",
                            subtitle: descriptionTextField,
                            title: nameTextField
                        ))
                    } label: {
                        Text("Save")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .foregroundColor(!isValid ? .white : .black.opacity(0.8))
                            .background(!isValid ? .gray.opacity(0.2) : Color.brandColor)
                            .contentShape(Rectangle())
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    .font(.system(size: 20, weight: .semibold))
                    .disabled(!isValid)
                    
                }
                .offset(y: isKeyboardVisible ? 1000:0)
                .animation(.interactiveSpring(duration: 0.5), value: isKeyboardVisible)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(.gray.opacity(0.1))
        }
    }
    
    @ViewBuilder
    func CustomTabBar() -> some View {
        HStack(spacing: 0) {
            ForEach(TabModel.allCases, id: \.rawValue) { tab in
                HStack(spacing: 10) {
                    Text(tab.rawValue)
                        .font(.system(size: 15, weight: .semibold))
                }
                .frame(height: 25)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .contentShape(.capsule)
                .onTapGesture {
                    withAnimation(.snappy) {
                        tabSelectedValue = tab
                    }
                }
            }
        }
        .tabMask(tabProgress)
        
        .background {
            GeometryReader {
                let size = $0.size
                let capsuleWidth = size.width / CGFloat(TabModel.allCases.count)
                
                Capsule()
                    .fill(scheme == .dark ? .black : .white)
                    .frame(width: capsuleWidth)
                    .offset(x: tabProgress * (size.width - capsuleWidth))
            }
        }
        .background(.gray.opacity(0.1), in: .capsule)
        .padding(.horizontal, 15)
    }
    
    var isValid: Bool {
        nameTextField != "" && selectedColorIndex != nil && selectedIcon != nil
    }
}

struct SymbolsGridStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .aspectRatio(1, contentMode: .fill)
            .cornerRadius(10)
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(.gray.opacity(0.1))
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
    AddHabitView(color: .constant(.red), viewModel: .init())
}
