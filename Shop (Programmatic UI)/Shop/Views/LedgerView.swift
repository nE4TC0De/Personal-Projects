//
//  LedgerView.swift
//  Shop
//
//  Created by Ryan Park on 12/17/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import UIKit

protocol LedgerViewDelegate {
    func pressedCheckoutButton(_ view: LedgerView)
}

class LedgerView: UIView {
    
    var delegate: LedgerViewDelegate?
    
    var subtotal: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var subtotalPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var shippingAndHandling: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shipping & Handling"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var shippingAndHandlingPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var tax: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tax"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var taxPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var total: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var totalPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var checkoutButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Checkout", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(pressedCheckoutButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pressedCheckoutButton() {
        delegate?.pressedCheckoutButton(self)
    }
    
    func setupViews() {
        addSubviews(subtotal, subtotalPrice, shippingAndHandling, shippingAndHandlingPrice, tax, taxPrice, total, totalPrice, checkoutButton)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            subtotal.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subtotal.heightAnchor.constraint(equalToConstant: 80),
        ])
        subtotal.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        subtotal.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)

        NSLayoutConstraint.activate([
            subtotalPrice.leadingAnchor.constraint(equalTo: subtotal.trailingAnchor, constant: 160),
            subtotalPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            subtotalPrice.heightAnchor.constraint(equalToConstant: 80),
        ])
        subtotalPrice.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        subtotalPrice.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)

        NSLayoutConstraint.activate([
            shippingAndHandling.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            shippingAndHandling.heightAnchor.constraint(equalToConstant: 80),
            shippingAndHandling.topAnchor.constraint(equalTo: subtotal.topAnchor, constant: 30),
        ])
        shippingAndHandling.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        shippingAndHandling.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)

        NSLayoutConstraint.activate([
            shippingAndHandlingPrice.leadingAnchor.constraint(equalTo: subtotal.trailingAnchor, constant: 160),
            shippingAndHandlingPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            shippingAndHandlingPrice.heightAnchor.constraint(equalToConstant: 80),
            shippingAndHandlingPrice.topAnchor.constraint(equalTo: subtotalPrice.topAnchor, constant: 30),
        ])
        shippingAndHandlingPrice.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        shippingAndHandlingPrice.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)

        NSLayoutConstraint.activate([
            tax.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tax.heightAnchor.constraint(equalToConstant: 80),
            tax.topAnchor.constraint(equalTo: shippingAndHandling.topAnchor, constant: 30),
        ])
        tax.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        tax.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)

        NSLayoutConstraint.activate([
            taxPrice.leadingAnchor.constraint(equalTo: subtotal.trailingAnchor, constant: 160),
            taxPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            taxPrice.heightAnchor.constraint(equalToConstant: 80),
            taxPrice.topAnchor.constraint(equalTo: shippingAndHandlingPrice.topAnchor, constant: 30),
        ])
        taxPrice.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        taxPrice.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)

        NSLayoutConstraint.activate([
            total.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            total.heightAnchor.constraint(equalToConstant: 80),
            total.topAnchor.constraint(equalTo: tax.topAnchor, constant: 34),
        ])
        total.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        total.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)

        NSLayoutConstraint.activate([
            totalPrice.leadingAnchor.constraint(equalTo: subtotal.trailingAnchor, constant: 160),
            totalPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            totalPrice.heightAnchor.constraint(equalToConstant: 80),
            totalPrice.topAnchor.constraint(equalTo: taxPrice.topAnchor, constant: 34),
        ])
        totalPrice.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        totalPrice.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)

        NSLayoutConstraint.activate([
            checkoutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            checkoutButton.heightAnchor.constraint(equalToConstant: 40),
            checkoutButton.widthAnchor.constraint(equalToConstant: 160),
            checkoutButton.topAnchor.constraint(equalTo: total.topAnchor, constant: 80),
        ])
        checkoutButton.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        checkoutButton.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
    }
}

// MARK: - Method For Adding Multiple Views
extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

