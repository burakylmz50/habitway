//
//  LaunchScreen.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 3.12.2023.
//

import SwiftUI

struct LaunchScreen: View {
    
    @Binding var isPresented: Bool
    
    @State private var scale = CGSize(width: 0.8, height: 0.8)
    
    @State private var opacity = 1.0
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            ZStack {
                Image("HabitWayIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .offset(x: 1)
            }
            .scaleEffect(scale)
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5)) {
                scale = CGSize(width: 1, height: 1)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                withAnimation(.easeIn(duration: 0)) {
                    isPresented.toggle()
                }
            })
        }
    }
}

#Preview {
    LaunchScreen(isPresented: .constant(true))
}
