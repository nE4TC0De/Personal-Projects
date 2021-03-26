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
    
    var itemImageView = UIImageView()
    var titleLabel = UILabel()
    var priceLabel = UILabel()
    var quantityLabel = UILabel()
    var decrementButton = UIButton()
    var incrementButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(itemImageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(quantityLabel)
        contentView.addSubview(decrementButton)
        contentView.addSubview(incrementButton)

        configureProductImageView()
        configureTitleLabel()
        configurePriceLabel()
        configureQuantityLabel()
        configureDecrementButton()
        configureIncrementButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pressedMinusButton() {
        cartItemDelegate?.pressedMinusButton(self)
    }
    
    @objc func pressedPlusButton() {
        cartItemDelegate?.pressedPlusBUtton(self)
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
    
    func configureQuantityLabel() {
        quantityLabel.numberOfLines = 1
        quantityLabel.adjustsFontSizeToFitWidth = true
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        quantityLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 55).isActive = true
        quantityLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func configureDecrementButton() {
        decrementButton.layer.cornerRadius = 10
        decrementButton.clipsToBounds = true
        decrementButton.translatesAutoresizingMaskIntoConstraints = false
        decrementButton.setTitle("-", for: .normal)
        decrementButton.backgroundColor = .systemRed
        decrementButton.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 20).isActive = true
        decrementButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        decrementButton.widthAnchor.constraint(equalTo: itemImageView.heightAnchor).isActive = true
        decrementButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        decrementButton.topAnchor.constraint(equalTo: quantityLabel.topAnchor, constant: -6).isActive = true
        decrementButton.addTarget(self, action: #selector(pressedMinusButton), for: .touchUpInside)
    }
    
    func configureIncrementButton() {
        incrementButton.layer.cornerRadius = 10
        incrementButton.clipsToBounds = true
        incrementButton.translatesAutoresizingMaskIntoConstraints = false
        incrementButton.setTitle("+", for: .normal)
        incrementButton.backgroundColor = .systemBlue
        incrementButton.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 20).isActive = true
        incrementButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        incrementButton.widthAnchor.constraint(equalTo: itemImageView.heightAnchor).isActive = true
        incrementButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        incrementButton.bottomAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 6).isActive = true
        incrementButton.addTarget(self, action: #selector(pressedPlusButton), for: .touchUpInside)
    }
    
}
