//
//  HistoryItemCell.swift
//  Shop
//
//  Created by Ryan Park on 12/3/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import UIKit

class HistoryItemCell: UITableViewCell {
    
    var itemImageView = UIImageView()
    var titleLabel = UILabel()
    var priceLabel = UILabel()
    var quantityLabel = UILabel()
    var quantitytitleLabel = UILabel()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(itemImageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(quantityLabel)
        addSubview(quantitytitleLabel)

        configureProductImageView()
        configureTitleLabel()
        configurePriceLabel()
        configureQuantityLabel()
        configureQuantityTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func configureQuantityTitleLabel() {
        quantitytitleLabel.numberOfLines = 1
        quantitytitleLabel.adjustsFontSizeToFitWidth = true
        quantitytitleLabel.translatesAutoresizingMaskIntoConstraints = false
        quantitytitleLabel.text = "Qty."
        quantitytitleLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 20).isActive = true
        quantitytitleLabel.widthAnchor.constraint(equalTo: itemImageView.heightAnchor).isActive = true
        quantitytitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        quantitytitleLabel.topAnchor.constraint(equalTo: quantityLabel.topAnchor, constant: 6).isActive = true
        quantitytitleLabel.textAlignment = .center
    }
    
}
