//
//  OrderHistoryProduct.swift
//  Shop
//
//  Created by Ryan Park on 12/3/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import Foundation
import RealmSwift

class OrderHistoryEntry: Object {
    @objc dynamic var name: String = ""
    let orderHistoryProducts = List<OrderHistoryProduct>()
}
