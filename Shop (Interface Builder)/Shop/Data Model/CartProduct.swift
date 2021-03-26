//
//  CartProduct.swift
//  Shop
//
//  Created by Ryan Park on 11/2/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import Foundation
import RealmSwift

class CartProduct: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var price: Float = 0.0
    @objc dynamic var image: NSData?
    @objc dynamic var quantity: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
