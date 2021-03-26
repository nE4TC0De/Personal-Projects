//
//  CheckoutViewController.swift
//  Shop
//
//  Created by Ryan Park on 12/2/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Thank you for your purchase."
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
        
    var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 52))
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go Back", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(button)
        configureLabel()
        configureButton()
    }
    
    @objc func pressedButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureLabel() {
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 180).isActive = true
    }
    
    func configureButton() {
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 140).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -140).isActive = true
        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 60).isActive = true
    }
}

