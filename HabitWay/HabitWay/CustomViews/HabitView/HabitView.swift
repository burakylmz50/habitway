//
//  HabitView.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 25.11.2023.
//

import SwiftUI

struct HabitView: View {
    
    var isSelectedCurrentDay: Bool
    
    var habitModel: HabitModel
    var action: (() -> Void)?
    
    init(habitModel: HabitModel, action: (() -> Void)? = nil) {
        self.habitModel = habitModel
        self.action = action
        self.isSelectedCurrentDay = habitModel.date.contains(todayDate)
    }
    
    var todayDate = Date.now.toString(withFormat: "yyyy-MM-dd")
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.habitViewBackground)
        
            VStack(spacing: 0) {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 5, height: 5), style: .circular)
                            .fill(.gray.opacity(0.2))
                            .frame(width: 30, height: 30)
                        
                        Image(systemName: habitModel.icon)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.white)
                            .scaledToFit()
                        
                    } // Left Button
                    .padding([.leading], 5)
                    
                    VStack(alignment: .leading) {
                        Text(habitModel.title.uppercased())
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.white)
                        Text(habitModel.subtitle.capitalized)
                            .font(.caption2)
                            .foregroundStyle(.white)
                    }
                    .padding([.top, .bottom], 5)
                    
                    Spacer()
                    
                    Button(action: {
                        action?()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerSize: CGSize(width: 5, height: 5), style: .circular)
                                .fill(isSelectedCurrentDay ? Color(hex: habitModel.hexColor)! : .gray.opacity(0.2))
                                .frame(width: 30, height: 30)
                            
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.brand)
                        }
                        .padding([.trailing], 5)
                    }) // Right Button
                }
                
                GrassView(
                    habitModel.date.toDictionary(),
                    row: 7,
                    col: 52,
                    cellColor: Color(hex: "\(habitModel.hexColor)") ?? .gray
                )
                .padding([.leading, .trailing, .bottom], 5)
            }
        }
        .frame(height: 145)
    }
}


#Preview {
    HabitView(habitModel: HabitModel(id: .init(), title: "name", subtitle: "description", date: ["2023-08-12"], hexColor: "$0000FF", icon: "plus.circle.fill"))
}
