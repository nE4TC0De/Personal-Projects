//
//  HistoryItemViewController.swift
//  Shop
//
//  Created by Ryan Park on 12/3/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryItemViewController: UITableViewController {
        
    let realm = try! Realm()
    
    var purchasedItems: Results<HistoryItem>?
    
    var selectedHistoryEntry: HistoryEntry? {
        didSet {
            loadData()
        }
    }
    
    let ledger = LedgerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        calculateLedger()
    }
    
    //MARK: - Tableview Configuration
    func configureTableView() {
        
        // Set row height
        tableView.rowHeight = 100
        
        // Register cells
        tableView.register(HistoryItemCell.self, forCellReuseIdentifier: "HistoryItemReusableCell")
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return ledger
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchasedItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryItemReusableCell", for: indexPath) as! HistoryItemCell
        
        if let historyItem = purchasedItems?[indexPath.row] {
            cell.titleLabel.text = historyItem.name
            cell.priceLabel.text = "$" + String(format: "%.2f", historyItem.price)
            cell.quantityLabel.text = String(historyItem.quantity)
            
            if let convertedImage = historyItem.image {
                cell.itemImageView.image = UIImage(data: convertedImage as Data)
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
        
        purchasedItems = selectedHistoryEntry?.historyItems.sorted(byKeyPath: "name", ascending: true)
        
        tableView.reloadData()
    }
}

//MARK: - Ledger Methods
extension HistoryItemViewController {
    
    func calculateLedger() {
        
        let sumPriceOfAllItems: Float = (selectedHistoryEntry?.historyItems.sum(ofProperty: "price"))!
        let sumQuantityOfAllItems: Int = (selectedHistoryEntry?.historyItems.sum(ofProperty: "quantity"))!
        
        ledger.subtotal.text = "Subtotal \(sumQuantityOfAllItems) Item(s)"
        ledger.subtotalPrice.text = "$\(String(format: "%.2f", sumPriceOfAllItems))"
        ledger.shippingAndHandlingPrice.text = "$5.00"
        ledger.taxPrice.text = "$\(String(format: "%.2f", sumPriceOfAllItems * 0.095))"
        ledger.totalPrice.text = "$\(String(format: "%.2f", sumPriceOfAllItems + (sumPriceOfAllItems * 0.095) + 5))"
        ledger.checkoutButton.isHidden = true
    }
}
