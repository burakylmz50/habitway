//
//  InputView.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 22.11.2023.
//

import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    @FocusState private var textfieldFocused: Bool
    
    var title: String
    var placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .modifier(InputTextLayout())
            TextField(placeholder, text: $text)
                .focused($textfieldFocused)
                .onLongPressGesture(minimumDuration: 0.0) {
                    textfieldFocused = true
                }
                .autocorrectionDisabled()
                .modifier(TextFieldLayout())
                .submitLabel(.done)
        }
    }
}

struct TextFieldLayout: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(.gray, style: StrokeStyle(lineWidth: 1.0)))
            .shadow(color: .gray, radius: 10)
    }
}

struct InputTextLayout: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.gray)
            .font(.headline)
    }
}

