//
//  OrderHistoryProductViewController.swift
//  Shop
//
//  Created by Ryan Park on 12/3/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import UIKit
import RealmSwift

class OrderHistoryProductViewController: UITableViewController {
    
    @IBOutlet weak var ledger: UIView!
    @IBOutlet weak var subtotal: UILabel!
    @IBOutlet weak var subtotalPrice: UILabel!
    @IBOutlet weak var shippingAndHandlingPrice: UILabel!
    @IBOutlet weak var taxPrice: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    let realm = try! Realm()
    
    var purchasedProducts: Results<OrderHistoryProduct>?
    
    var selectedOrderHistoryEntry: OrderHistoryEntry? {
        didSet {
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UINib(nibName: "OrderHistoryItemCell", bundle: nil), forCellReuseIdentifier: "OrderHistoryReusableCell")
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        calculateLedger()
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchasedProducts?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHistoryReusableCell", for: indexPath) as! OrderHistoryItemCell
        
        if let orderHistoryProduct = purchasedProducts?[indexPath.row] {
            cell.titleLabel?.text = orderHistoryProduct.name
            cell.priceLabel?.text = String(format: "%.2f", orderHistoryProduct.price)
            cell.quantityLabel?.text = String(orderHistoryProduct.quantity)
            
            if let convertedImage = orderHistoryProduct.image {
                cell.productImageView.image = UIImage(data: convertedImage as Data)
            }
        }
        return cell
    }
    
    //MARK: - Tableview Size Methods
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(indexPath.row) + 100
    }
    
    //MARK: - Model Manipulation Methods
    
    func loadData() {
        
        purchasedProducts = selectedOrderHistoryEntry?.orderHistoryProducts.sorted(byKeyPath: "name", ascending: true)
        
        tableView.reloadData()
    }
}

//MARK: - Ledger Methods
extension OrderHistoryProductViewController {
    
    func calculateLedger() {
        
        let sumPriceOfAllItems: Float = (selectedOrderHistoryEntry?.orderHistoryProducts.sum(ofProperty: "price"))!
        let sumQuantityOfAllItems: Int = (selectedOrderHistoryEntry?.orderHistoryProducts.sum(ofProperty: "quantity"))!
        
        subtotal.text = "Subtotal \(sumQuantityOfAllItems) Item(s)"
        subtotalPrice.text = "$\(String(format: "%.2f", sumPriceOfAllItems))"
        shippingAndHandlingPrice.text = "$5.00"
        taxPrice.text = "$\(String(format: "%.2f", sumPriceOfAllItems * 0.095))"
        totalPrice.text = "$\(String(format: "%.2f", sumPriceOfAllItems + (sumPriceOfAllItems * 0.095) + 5))"
    }
}
