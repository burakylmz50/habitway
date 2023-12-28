//
//  NotificationView.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 29.12.2023.
//

import SwiftUI

struct NotificationView: View {
    var size: CGSize
    @State var isExpanded: Bool = false
    @State var notification: NotificationModel?
    var body: some View {
        HStack {
            Image(systemName: "checkmark")
                .resizable()
                .foregroundColor(isExpanded ? .green : .clear)
                .frame(
                    width: isExpanded ? 40 : 10,
                    height: isExpanded ? 40 : 10
                )
        }
        
        .frame(width: 130, height: isExpanded ? 130 : 37.33)
        .blur(radius: isExpanded ? 0 : 30)
        .opacity(isExpanded ? 1 : 0)
        .scaleEffect(isExpanded ? 1 : 0.5, anchor: .top)
        .background {
            RoundedRectangle(cornerRadius: isExpanded ? 20 : 63, style: .continuous)
                .fill(.black)
        }
        .clipped()
        .offset(y: 11)
        .onReceive(NotificationCenter.default.publisher(for: .init("NOTIFY"))) { output in
            guard let notification = output.object as? NotificationModel else { return }
            self.notification = notification
            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.7, blendDuration: 0.7)) {
                isExpanded = true

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.7, blendDuration: 0.7)) {
                        isExpanded = false
                        self.notification = nil
                    }
                }
            }
        }
    }
}

struct NotificationModel {
    var title: String
    var content: String
}
