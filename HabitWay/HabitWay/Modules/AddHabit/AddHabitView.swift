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
    
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()
    
    @Binding var isPresentedAddHabitView: Bool
    @Binding var color: Color
    
    @State private var isAddHabitSelector: Bool = false
    @State private var nameTextField = ""
    @State private var descriptionTextField = ""
    
    @FocusState private var focusedField: String?
    
    @State private var icon = "star.fill"
    @State private var isPresented = false
    
    @State var tabSelectedValue: TabModel?
    @Environment(\.colorScheme) private var scheme
    
    @State private var tabProgress: CGFloat = 0
    
    @State var selectedColorIndex: Int?
    @State var selectedIcon: String?
    
    @State private var isKeyboardVisible = false
    
    @FocusState private var keyboardFocused: Bool
    
    
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
        .red.opacity(0.8),
        .red.opacity(0.6),
        .red.opacity(0.4),
        .red.opacity(0.3),
        .red.opacity(0.2),
        .green,
        .green.opacity(0.8),
        .green.opacity(0.6),
        .green.opacity(0.4),
        .green.opacity(0.3),
        .green.opacity(0.2),
        .blue,
        .blue.opacity(0.8),
        .blue.opacity(0.6),
        .blue.opacity(0.4),
        .blue.opacity(0.3),
        .blue.opacity(0.2),
        .orange,
        .orange.opacity(0.8),
        .orange.opacity(0.6),
        .orange.opacity(0.4),
        .orange.opacity(0.3),
        .orange.opacity(0.2),
        .purple,
        .purple.opacity(0.8),
        .purple.opacity(0.6),
        .purple.opacity(0.4),
        .purple.opacity(0.3),
        .purple.opacity(0.2),
        .yellow,
        .yellow.opacity(0.8),
        .yellow.opacity(0.6),
        .yellow.opacity(0.4),
        .yellow.opacity(0.3),
        .yellow.opacity(0.2),
        .pink,
        .pink.opacity(0.8),
        .pink.opacity(0.6),
        .pink.opacity(0.4),
        .pink.opacity(0.3),
        .pink.opacity(0.2),
        .gray,
        .gray.opacity(0.8),
        .gray.opacity(0.6),
        .gray.opacity(0.4),
        .gray.opacity(0.3),
        .gray.opacity(0.2)
    ]
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            
            
            //                VStack {
            //                    HStack {
            //                        Spacer()
            //
            //                        Button("", systemImage: "checkmark") {
            //                            isPresentedAddHabitView = false
            //
            //                            viewModel.addHabit(model: .init(
            //                                id: UUID(),
            //                                title: nameTextField,
            //                                subtitle: descriptionTextField,
            //                                date: [""],
            //                                hexColor: color.toHex() ?? "$0000FF",
            //                                icon: icon
            //                            ))
            //                        }
            //                        .tint(.brandColor)
            //                        .disabled(isValidation)
            //                    }
            //
            //                    VStack(spacing: 20) {
            //                        InputView(
            //                            text: $nameTextField,
            //                            title: "Name (Required)",
            //                            placeholder: "Reading books"
            //                        )
            //                        .onAppear {
            //                            focusedField = "nameTextField"
            //                        }
            //
            //                        InputView(
            //                            text: $descriptionTextField,
            //                            title: "Description",
            //                            placeholder: "Description"
            //                        )
            //
            //                        SquareColorPickerView(colorValue: $color)
            //
            //                        HStack {
            //                            Text("Select Icon")
            //                                .foregroundStyle(.gray)
            //                                .font(.headline)
            //
            //                            Spacer()
            //
            //                            Button("", systemImage: icon) {
            //                                isPresented.toggle()
            //                            }
            //                            .tint(.gray)
            //                            .sheet(isPresented: $isPresented, content: {
            //                                SymbolsPicker(selection: $icon, title: "Pick a symbol", autoDismiss: true)
            //                            })
            //                        }
            //
            //                        Divider()
            //
            //
            //                        Rectangle()
            //                            .frame(width: 100, height: 100)
            //
            //                        Spacer()
            //
            //                        TextField("Text", text: $nameTextField)
            //                            .frame(alignment: .center)
            //
            //
            //                    }
            //                }
            
            
            
            
            
            
            
            
            VStack(spacing: 15) {
                
                ZStack {
                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(selectedColorIndex != nil ? colors[selectedColorIndex!] : .gray.opacity(0.1))
                            .frame(width: 100, height: 100)
                            .cornerRadius(20)
                            .overlay(
                                Image(systemName: "square.and.arrow.up.fill")
                                    .resizable()
                                    .foregroundStyle(selectedColorIndex != nil ? .white : .gray.opacity(0.5))
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .font(.headline)
                                
                            )
                            .padding(.top, 30)
                        
                        VStack(spacing: 0) {
                            TextField("New Habit", text: $nameTextField)
                                .fontWeight(.semibold)
                                .font(.title)
                                .frame(alignment: .center)
                                .multilineTextAlignment(.center)
                                .focused($keyboardFocused)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        keyboardFocused = true
                                    }
                                }
                            
                            Text(nameTextField == "" ? "Tap to add name" : "Tap to rename")
                                .foregroundStyle(.tertiary)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .tint(.gray.opacity(0.4))
                                .opacity(!isKeyboardVisible ? 1 : 0)
                            
                        }
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
                        self.isKeyboardVisible = true
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                        self.isKeyboardVisible = false
                    }
                }
                .onTapGesture {
                    keyboardFocused = true
//                    if nameTextField == "" {
//                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                    }
                }
                .scaleEffect(isKeyboardVisible ? CGSize(width: 1.5, height: 1.5) : CGSize(width: 1, height: 1), anchor: .center)
                .offset(y: isKeyboardVisible ? 50 : 0)
                .animation(.spring(), value: isKeyboardVisible)
                
                
                
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
                                            
//                                            Section() {
//                                                ForEach(SFSymbols.random, id: \.self) { emoji in
//                                                    Rectangle()
//                                                        .frame(width: size.width/6)
//                                                        .background(emoji == selectedIcon ? colors[selectedColorIndex ?? 0] : .gray.opacity(0.1))
//                                                        .overlay {
//                                                            Image(systemName: emoji)
//                                                                .resizable()
//                                                                .foregroundStyle(emoji == selectedIcon ? .white : .gray.opacity(0.5))
//                                                                .aspectRatio(contentMode: .fit)
//                                                                .font(.headline)
//                                                                .padding(12)
//                                                                
//                                                        }
//                                                        .onTapGesture {
//                                                            selectedIcon = emoji
//                                                        }
//                                                        .modifier(SymbolsGridStyle())
//                                                }
//                                            } header: {
//                                                HStack {
//                                                    Text(SFSymbolsType.random.rawValue)
//                                                        .bold()
//                                                    Spacer()
//                                                }
//                                            }
                                            
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
                                            //                                            .frame(height: 50)
                                                .aspectRatio(contentMode: .fill)
                                                .cornerRadius(25)
                                                .onTapGesture {
                                                    selectedColorIndex = index
                                                }
                                                .overlay(
                                                    Circle()
                                                        .stroke(
                                                            index == selectedColorIndex ? colors[index].opacity(0.5) : Color.clear,
                                                            style: StrokeStyle(
                                                                lineWidth: 3,
                                                                lineCap: .round,
                                                                lineJoin: .miter,
                                                                miterLimit: 0,
                                                                dashPhase: 0
                                                            )
                                                        )
                                                        .frame(width: 63, height: 63)
                                                    
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
                    
                    Button("Save") {
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(!isValid ? .gray.opacity(0.2) : Color.brandColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    .background(Color.backgroundColor)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .semibold))
                    .disabled(!isValid)
                }
                .offset(y: isKeyboardVisible ? self.keyboardHeightHelper.keyboardHeight:0)
                .animation(.spring(), value: isKeyboardVisible)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(.gray.opacity(0.1))
               
        }
        .navigationDestination(for: HomeRoute.self) { model in }
        .sheet(isPresented: $isAddHabitSelector, onDismiss: {
            // TODO: HandleDismiss
        }) {
            
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
    AddHabitView(
        viewModel: AddHabitViewModel(),
        isPresentedAddHabitView: .constant(true), color: .constant(.red)
    )
}


