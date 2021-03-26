//
//  OrderHistoryItemCell.swift
//  Shop
//
//  Created by Ryan Park on 12/3/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import UIKit

class OrderHistoryItemCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleBubble: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceBubble: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityBubble: UIView!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
