//
//  HabitView.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 25.11.2023.
//

import SwiftUI

struct HabitView: View {
    
    var habitModel: HabitModel
    var action: (() -> Void)?
    
    init(habitModel: HabitModel, action: (() -> Void)? = nil) {
        self.habitModel = habitModel
        self.action = action
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
        
            VStack(spacing: 0) {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 5, height: 5), style: .circular)
                            .fill(.gray.opacity(0.2))
                            .frame(width: 30, height: 30)
                        
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                    } // Left Button
                    .padding([.leading], 5)
                    
                    VStack(alignment: .leading) {
                        Text(habitModel.title)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Text(habitModel.subtitle)
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    }
                    .padding([.top, .bottom], 5)
                    
                    Spacer()
                    
                    Button(action: {
                        action?()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerSize: CGSize(width: 5, height: 5), style: .circular)
                                .fill(.gray.opacity(0.2))
                                .frame(width: 30, height: 30)
                            
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        .padding([.trailing], 5)
                    }) // Right Button
                }
                
                GrassView(row: 7, col: 52)
                    .padding([.leading, .trailing, .bottom], 5)
                
            }
        }
        .frame(height: 145)
    }
}


#Preview {
    HabitView(habitModel: HabitModel(id: .init(), title: "name", subtitle: "description", date: "date", color: .red, icon: "plus.circle.fill"))
}
