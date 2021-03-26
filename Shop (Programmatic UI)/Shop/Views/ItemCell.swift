//
//  ItemCell.swift
//  Shop
//
//  Created by Ryan Park on 10/28/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import UIKit

protocol ItemCellDelegate {
    func pressedAddButton(_ cell: ItemCell)
}

class ItemCell: UITableViewCell {
    
    var delegate: ItemCellDelegate?
    
    var itemImageView = UIImageView()
    var titleLabel = UILabel()
    var priceLabel = UILabel()
    var addButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(itemImageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        contentView.addSubview(addButton) // Button must be added on the contentView since any subviews added to the UITableViewCell is behind the contentView.

        configureProductImageView()
        configureTitleLabel()
        configurePriceLabel()
        configureAddButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pressedAddButton() {
        delegate?.pressedAddButton(self)
    }
    
    func configureProductImageView() {
        itemImageView.layer.cornerRadius = 10
        itemImageView.clipsToBounds = true
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        itemImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        itemImageView.widthAnchor.constraint(equalTo: itemImageView.heightAnchor, multiplier: 4/3).isActive = true
    }
    
    func configureTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func configurePriceLabel() {
        priceLabel.numberOfLines = 1
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func configureAddButton() {
        addButton.layer.cornerRadius = 10
        addButton.clipsToBounds = true
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("Add", for: .normal)
        addButton.backgroundColor = .systemTeal
        addButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addButton.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 20).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        addButton.widthAnchor.constraint(equalTo: itemImageView.heightAnchor).isActive = true
        addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        addButton.addTarget(self, action: #selector(pressedAddButton), for: .touchUpInside)
    }
    
}
