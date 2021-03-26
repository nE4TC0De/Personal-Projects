//
//  CartViewController.swift
//  Shop
//
//  Created by Ryan Park on 11/2/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import UIKit
import RealmSwift

class CartViewController: SwipeTableViewController {
    
    @IBOutlet weak var ledger: UIView!
    @IBOutlet weak var subtotal: UILabel!
    @IBOutlet weak var subtotalPrice: UILabel!
    @IBOutlet weak var shippingAndHandlingPrice: UILabel!
    @IBOutlet weak var taxPrice: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    let realm = try! Realm()
    
    var cartProducts: Results<CartProduct>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UINib(nibName: "CartItemCell", bundle: nil), forCellReuseIdentifier: "CartReusableCell")
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        hideLedger()
        calculateLedger()
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartProducts?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartReusableCell", for: indexPath) as! CartItemCell
        
        cell.delegate = self
        
        cell.cartItemDelegate = self
        
        if let cartProduct = cartProducts?[indexPath.row] {
            cell.titleLabel?.text = cartProduct.name
            cell.priceLabel?.text = String(format: "%.2f", cartProduct.price)
            cell.quantityLabel?.text = String(cartProduct.quantity)
            
            if let convertedImage = cartProduct.image {
                cell.productImageView.image = UIImage(data: convertedImage as Data)
            }
        }
        return cell
    }
    
    //MARK: - Tableview Size Methods
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(indexPath.row) + 100
    }
    
    //MARK: - Data Manipulation Methods
    func loadData() {
        
        cartProducts = realm.objects(CartProduct.self)
        
        tableView.reloadData()
    }
    
    //MARK: - Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let cartItemForDeletion = self.cartProducts?[indexPath.row] {
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
        
        let cartItem = cartProducts?[cellRowIndexPath]
        
        let priceBeingDecreased = self.realm.objects(Product.self).filter("id == \(cartItem!.id)").first
        
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
            if let cartItemForDeletion = self.cartProducts?[cellRowIndexPath] {
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
        
        let cartItem = cartProducts?[cellRowIndexPath]
        
        let priceBeingIncreased = self.realm.objects(Product.self).filter("id == \(cartItem!.id)").first
        
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
        if cartProducts?.count == 0 {
            ledger.isHidden = true
        } else {
            ledger.isHidden = false
        }
    }
    
    func calculateLedger() {
        let sumPriceOfAllItems: Float = realm.objects(CartProduct.self).sum(ofProperty: "price")
        let sumQuantityOfAllItems: Int = realm.objects(CartProduct.self).sum(ofProperty: "quantity")
        
        subtotal.text = "Subtotal \(sumQuantityOfAllItems) Item(s)"
        subtotalPrice.text = "$\(String(format: "%.2f", sumPriceOfAllItems))"
        shippingAndHandlingPrice.text = "$5.00"
        taxPrice.text = "$\(String(format: "%.2f", sumPriceOfAllItems * 0.095))"
        totalPrice.text = "$\(String(format: "%.2f", sumPriceOfAllItems + (sumPriceOfAllItems * 0.095) + 5))"
    }
}

//MARK: - Checkout Button
extension CartViewController {
    @IBAction func checkoutButton(_ sender: UIButton) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        let datetime = formatter.string(from: date)
        
        let newOrder = OrderHistoryEntry()
        newOrder.name = datetime
        
        do {
            try realm.write{
                realm.add(newOrder)
            }
        } catch {
            print("Error saving order history entry: \(error)")
        }
        
        let newOrderHistoryEntry = self.realm.objects(OrderHistoryEntry.self).last
        let cartItemsBeingAdded = self.realm.objects(CartProduct.self)
        
        for i in cartItemsBeingAdded {
            let newOrderHistoryItem = OrderHistoryProduct()
            
            do {
                try realm.write{
                    newOrderHistoryItem.name = i.name
                    newOrderHistoryItem.price = i.price
                    
                    let imageData: NSData = i.image! as NSData
                    newOrderHistoryItem.image = imageData
                    
                    newOrderHistoryItem.quantity = i.quantity
                    newOrderHistoryEntry?.orderHistoryProducts.append(newOrderHistoryItem)
                }
            } catch {
                print("Error adding item to order history entry: \(error)")
            }
        }
        
        do {
            try self.realm.write{
                self.realm.delete(cartProducts!)
                hideLedger()
            }
        } catch {
            print("Error deleting item: \(error)")
        }
    }
}

