//
//  GrassViewCell.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 21.11.2023.
//

import SwiftUI

struct GrassViewCell: View {
    
    let date: String
    let level: Int
    let cellColor: Color
    let onCellTouch: (String, Int) -> Void
    let row: Int
    let col: Int
    
    @EnvironmentObject var viewModel: GrassView.GrassViewModel
    
    @State var rect: CGRect = CGRect()
    
    public var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 3)
                
                .fill(setFillColor(date: date, level: level))
//                .saturation(Double(level) * 0.1)
                .brightness(level == 10 ? 0 : 0.1)
            }
            .aspectRatio(1.0, contentMode: .fit)
            .onChange(of: viewModel.touchLocation) { willtouchLocation, touchedLocation in
                guard let touchedLocation = touchedLocation, rect.contains(touchedLocation) else { return }
                onCellTouch(date, level)
            }
            .onTapGesture(count: 1) {
                print(date)
                onCellTouch(date, level)
            }
    }
    
    private func setFillColor(date: String, level: Int) -> Color {
        if date.toDate(withFormat: "yyyy-MM-dd")! >= Date.now {
            return .clear
        } else {
            return cellColor.opacity(Double(level) * 0.2 + 0.2)
        }
    }
}
