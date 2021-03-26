//
//  Item.swift
//  Shop
//
//  Created by Ryan Park on 10/28/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var sku: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var price: Float = 0.0
    @objc dynamic var image: NSData?
}
