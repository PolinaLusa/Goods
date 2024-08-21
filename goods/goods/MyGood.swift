//
//  MyGood.swift
//  goods
//
//  Created by Полина Лущевская on 18.03.24.
//

import Foundation

struct MyGood: Identifiable {
    let id = UUID()
    let name:String
    let description: String
    let photoName: String
    var photoImg: Data?
    var price: String
    var isMyFavourite: Bool
}
