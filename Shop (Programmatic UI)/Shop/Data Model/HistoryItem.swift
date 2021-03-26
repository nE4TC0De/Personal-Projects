//
//  HistoryItem.swift
//  Shop
//
//  Created by Ryan Park on 12/3/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import Foundation
import RealmSwift

class HistoryItem: Object {
    @objc dynamic var sku: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var price: Float = 0.0
    @objc dynamic var image: NSData?
    @objc dynamic var quantity: Int = 0
    var parentHistoryEntry = LinkingObjects(fromType: HistoryEntry.self, property: "historyItems")
}
