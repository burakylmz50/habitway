//
//  HabitView.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 25.11.2023.
//

import SwiftUI

struct HabitView: View {
    
    @State var isSelectedCurrentDay: Bool = false
    
    var habitModel: HabitModel
    var action: (() -> Void)?
    
    init(habitModel: HabitModel, action: (() -> Void)? = nil) {
        self.habitModel = habitModel
        self.action = action
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
                            .imageScale(.large)
                            .foregroundStyle(.white)
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
                        isSelectedToday()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerSize: CGSize(width: 5, height: 5), style: .circular)
                                .fill(isSelectedCurrentDay ? Color(hex: habitModel.color)! : .gray.opacity(0.2))
                                .frame(width: 30, height: 30)
                            
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(isSelectedCurrentDay ? .white : .brand)
                        }
                        .padding([.trailing], 5)
                    }) // Right Button
                    .sensoryFeedback(.selection, trigger: isSelectedCurrentDay)
                }
                
                GrassView(
                    habitModel.date.toDictionary(),
                    row: 7,
                    col: 52,
                    cellColor: Color(hex: "\(habitModel.color)") ?? .gray
                )
                .padding([.leading, .trailing, .bottom], 5)
            }
        }
        .frame(height: 145)
        .onAppear {
            isSelectedToday()
        }
    }
    
    private func isSelectedToday() {
        let date = habitModel.date
        self.isSelectedCurrentDay = date.contains(todayDate)
    }
}


#Preview {
    HabitView(habitModel: .init(color: "$0000FF", date: ["2023-08-12"], icon: "plus.circle.fill", subtitle: "description", title: "name"))
}
