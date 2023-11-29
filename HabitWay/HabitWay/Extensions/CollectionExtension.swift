//
//  CollectionExtension.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 29.11.2023.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
