//
//  Array+Identifiable.swift
//  Good Memory
//
//  Created by Gustavo Belo on 21/03/21.
//

import Foundation

extension Array where Element: Identifiable{
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id{
                return index
            }
        }
        return nil
    }
}
