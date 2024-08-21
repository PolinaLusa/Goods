//
//  Item.swift
//  goods
//
//  Created by Полина Лущевская on 21.08.24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
