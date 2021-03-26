//
//  CartItemCell.swift
//  Shop
//
//  Created by Ryan Park on 11/2/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import UIKit
import SwipeCellKit

protocol CartItemCellDelegate {
    func pressedMinusButton(_ cell: CartItemCell)
    func pressedPlusBUtton(_ cell: CartItemCell)
}

class CartItemCell: SwipeTableViewCell {

    var cartItemDelegate: CartItemCellDelegate?
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleBubble: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceBubble: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buttonBubble: UIView!
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBAction func decrementButton(_ sender: UIButton) {
        cartItemDelegate?.pressedMinusButton(self)
    }
    
    @IBAction func incrementButton(_ sender: UIButton) {
        cartItemDelegate?.pressedPlusBUtton(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
