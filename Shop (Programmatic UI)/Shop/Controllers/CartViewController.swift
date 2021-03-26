//
//  CartViewController.swift
//  Shop
//
//  Created by Ryan Park on 11/2/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import UIKit
import RealmSwift

class CartViewController: SwipeTableViewController, UITableViewDelegate, UITableViewDataSource {
    
    let realm = try! Realm()
    
    var cartItems: Results<CartItem>?
    
    let tableView = UITableView()
    
    let ledger = LedgerView()
    
    let checkoutSuccessView = CheckoutViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ledger.delegate = self
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        hideLedger()
        calculateLedger()
    }
    
    //MARK: - Tableview Configuration
    func configureTableView() {
        
        view.addSubview(tableView)
        
        // Set delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set row and section height
        tableView.rowHeight = 100
        tableView.sectionFooterHeight = 250
        
        // Register cells
        tableView.register(CartItemCell.self, forCellReuseIdentifier: "CartReusableCell")
        
        // Set constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    //MARK: - Tableview Datasource Methods
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return ledger
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartReusableCell", for: indexPath) as! CartItemCell
        
        cell.delegate = self
        
        cell.cartItemDelegate = self
        
        if let cartItem = cartItems?[indexPath.row] {
            cell.titleLabel.text = cartItem.name
            cell.priceLabel.text = "$" + String(format: "%.2f", cartItem.price)
            cell.quantityLabel.text = String(cartItem.quantity)
            
            if let convertedImage = cartItem.image {
                cell.itemImageView.image = UIImage(data: convertedImage as Data)
            }
        }
        return cell
    }
    
    //MARK: - Data Manipulation Methods
    func loadData() {
        
        cartItems = realm.objects(CartItem.self)
        
        tableView.reloadData()
    }
    
    //MARK: - Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let cartItemForDeletion = self.cartItems?[indexPath.row] {
            do {
                try self.realm.write{
                    self.realm.delete(cartItemForDeletion)
                    hideLedger()
                    calculateLedger()
                }
            } catch {
                print("Error deleting item: \(error)")
            }
        }
    }
}

//MARK: - CartItemCellDelegate - Update Quantity
extension CartViewController: CartItemCellDelegate {
    func pressedMinusButton(_ cell: CartItemCell) {
        
        let cellRowIndexPath = cell.indexPath.flatMap { $0.row } as! Int
        
        let cartItem = cartItems?[cellRowIndexPath]
                
        let priceBeingDecreased = self.realm.objects(Item.self).filter("sku contains '\(cartItem!.sku)'").first
        
        if cartItem!.quantity > 1 {
            do {
                try self.realm.write{
                    cartItem?.quantity -= 1
                    cartItem?.price -= priceBeingDecreased!.price
                    calculateLedger()
                }
            } catch {
                print("Error decreasing item quantity and price: \(error)")
            }
        } else {
            if let cartItemForDeletion = self.cartItems?[cellRowIndexPath] {
                do {
                    try self.realm.write{
                        self.realm.delete(cartItemForDeletion)
                        hideLedger()
                        calculateLedger()
                    }
                } catch {
                    print("Error deleting item: \(error)")
                }
            }
        }
        
        loadData()
    }
    
    func pressedPlusBUtton(_ cell: CartItemCell) {
        
        let cellRowIndexPath = cell.indexPath.flatMap { $0.row } as! Int
        
        let cartItem = cartItems?[cellRowIndexPath]
        
        let priceBeingIncreased = self.realm.objects(Item.self).filter("sku contains '\(cartItem!.sku)'").first
        
        do {
            try self.realm.write{
                cartItem?.quantity += 1
                cartItem?.price += priceBeingIncreased!.price
                calculateLedger()
            }
        } catch {
            print("Error increasing item quantity and price: \(error)")
        }
        loadData()
    }
    
}

//MARK: - Ledger Methods

extension CartViewController {
    func hideLedger() {
        if cartItems?.count == 0 {
            ledger.isHidden = true
        } else {
            ledger.isHidden = false
        }
    }
    
    func calculateLedger() {
        let sumPriceOfAllItems: Float = realm.objects(CartItem.self).sum(ofProperty: "price")
        let sumQuantityOfAllItems: Int = realm.objects(CartItem.self).sum(ofProperty: "quantity")
        
        ledger.subtotal.text = "Subtotal \(sumQuantityOfAllItems) Item(s)"
        ledger.subtotalPrice.text = "$\(String(format: "%.2f", sumPriceOfAllItems))"
        ledger.shippingAndHandlingPrice.text = "$5.00"
        ledger.taxPrice.text = "$\(String(format: "%.2f", sumPriceOfAllItems * 0.095))"
        ledger.totalPrice.text = "$\(String(format: "%.2f", sumPriceOfAllItems + (sumPriceOfAllItems * 0.095) + 5))"
    }
}

//MARK: - Checkout Button
extension CartViewController: LedgerViewDelegate {
    func pressedCheckoutButton(_ view: LedgerView) {

        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        let datetime = formatter.string(from: date)
        
        let newOrder = HistoryEntry()
        newOrder.name = datetime
        
        do {
            try realm.write{
                realm.add(newOrder)
            }
        } catch {
            print("Error saving order history entry: \(error)")
        }
        
        let historyEntry = self.realm.objects(HistoryEntry.self).last
        let cartItems = self.realm.objects(CartItem.self)
        
        for i in cartItems {
            let newOrderHistoryItem = HistoryItem()
            
            do {
                try realm.write{
                    newOrderHistoryItem.name = i.name
                    newOrderHistoryItem.price = i.price
                    
                    let imageData: NSData = i.image! as NSData
                    newOrderHistoryItem.image = imageData
                    
                    newOrderHistoryItem.quantity = i.quantity
                    historyEntry?.historyItems.append(newOrderHistoryItem)
                }
            } catch {
                print("Error adding item to order history entry: \(error)")
            }
        }
        
        do {
            try self.realm.write{
                self.realm.delete(cartItems)
                hideLedger()
                tableView.reloadData()
            }
        } catch {
            print("Error deleting item: \(error)")
        }
        
        present(checkoutSuccessView, animated: true, completion: nil)
    }
}

