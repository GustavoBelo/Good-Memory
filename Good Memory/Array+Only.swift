//
//  Array+Only.swift
//  Good Memory
//
//  Created by Gustavo Belo on 21/03/21.
//

import Foundation

extension Array {
    var only: Element?{
        count == 1 ? first : nil
    }
}
