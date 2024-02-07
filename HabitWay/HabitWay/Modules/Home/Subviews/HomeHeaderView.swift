//
//  HomeHeaderView.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 6.02.2024.
//

import SwiftUI

struct HomeHeaderView: View {
    var body: some View {
            Text(Date().toString(withFormat: "dd MMMM"))
                .font(.title)
                .foregroundStyle(.gray.opacity(0.4))
                .bold()
    }
}

#Preview {
    HomeHeaderView()
}
