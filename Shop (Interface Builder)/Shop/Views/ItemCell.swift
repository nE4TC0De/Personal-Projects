//
//  ItemCell.swift
//  Shop
//
//  Created by Ryan Park on 10/28/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import UIKit

protocol ItemCellDelegate {
    func pressedButton(_ cell: ItemCell)
}

class ItemCell: UITableViewCell {
    
    var delegate: ItemCellDelegate?
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleBubble: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceBubble: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buttonBubble: UIView!
    @IBAction func addButton(_ sender: UIButton) {
        delegate?.pressedButton(self)
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
