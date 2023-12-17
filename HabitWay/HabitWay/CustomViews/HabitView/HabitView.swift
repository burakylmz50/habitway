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
    
    @State var isSelectedCurrentDay = false
    
    @State var testCase = [
          "2023-12-06": 10,
          "2023-12-05": 10,
          "2023-12-03": 10,
          "2023-12-01": 10,
          "2023-12-02": 10,
          "2023-12-07": 10,
          "2023-11-27": 10,
          "2023-11-26": 10,
          "2023-11-25": 10,
          "2023-11-24": 10,
          "2023-11-23": 10,
          "2023-11-22": 10
      ]
    
    private var todayDate = Date.now.toString(withFormat: "yyyy-MM-dd")
    
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
                        if !isSelectedCurrentDay {
                            testCase.updateValue(10, forKey: todayDate)
                        } else {
                            testCase.removeValue(forKey: todayDate)
                        }
                        isSelectedCurrentDay.toggle()
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

                GrassView(testCase, row: 7, col: 52, cellColor: Color(hex: "\(habitModel.hexColor)") ?? .gray)
                    .padding([.leading, .trailing, .bottom], 5)
                
            }
        }
        .frame(height: 145)
    }
}


#Preview {
    HabitView(habitModel: HabitModel(id: .init(), title: "name", subtitle: "description", date: ["2023-08-12"], hexColor: "$0000FF", icon: "plus.circle.fill"))
}
