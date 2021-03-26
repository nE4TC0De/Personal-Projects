//
//  InitialViewController.swift
//  Shop
//
//  Created by Ryan Park on 12/14/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 52))
        button.setTitle("Start Shopping", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        view.addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        button.center = view.center
    }
    
    
    @objc func didTapButton() {
        let tabBarVC = UITabBarController()
        
        let viewControllerOne = StorefrontViewController()
        let viewControllerTwo = CartViewController()
        let viewControllerThree = UINavigationController(rootViewController: HistoryEntryViewController())
        
        viewControllerOne.title = "Shop"
        viewControllerTwo.title = "Cart"
        viewControllerThree.title = "History"
        
        tabBarVC.setViewControllers([viewControllerOne, viewControllerTwo, viewControllerThree], animated: false)
        
        guard let items = tabBarVC.tabBar.items else {
            return
        }
        
        let images = ["bag", "cart", "timer"]
        
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
        
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: false)
    }
}
