//
//  ArrayExtension.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 27.12.2023.
//

import Foundation

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
    
    
    public func toDictionary() -> [String : Int] {
        var dictionary: [String: Int] = [:]
        
        for element in self {
            dictionary[element as! String] = 10
        }
        return dictionary
    }
}
