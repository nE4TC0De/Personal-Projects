//
//  StorefrontViewController.swift
//  Shop
//
//  Created by Ryan Park on 10/26/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import UIKit
import RealmSwift

class StorefrontViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var items: Results<Item>?
    
    var cartItemId = 1
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadData()
        configureTableView()
    }
    
    //MARK: - Tableview Configuration
    func configureTableView() {
        
        // Set row height
        tableView.rowHeight = 100
        
        // Register cells
        tableView.register(ItemCell.self, forCellReuseIdentifier: "ItemReusableCell")
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemReusableCell", for: indexPath) as! ItemCell
        
        cell.delegate = self

        if let item = items?[indexPath.row] {
            cell.titleLabel.text = item.name
            cell.priceLabel.text = "$" + String(format: "%.2f", item.price)
            
            if let convertedImage = item.image {
                cell.itemImageView.image = UIImage(data: convertedImage as Data)
            }
        }
        return cell
    }

    //MARK: - Data Manipulation Methods
    func save(cartItem: CartItem) {
        
        do {
            try realm.write{
                realm.add(cartItem, update: .modified)
            }
        } catch {
            print("Error adding item to cart: \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadData() {
        
        items = realm.objects(Item.self)
        
        tableView.reloadData()
    }
}

//MARK: - ItemCellDelegate - Add Item To Cart
extension StorefrontViewController: ItemCellDelegate {
    func pressedAddButton(_ cell: ItemCell) {
        
        let cellRowIndexPath = cell.indexPath.flatMap { $0.row } as! Int
        
        let cartItem = self.realm.objects(CartItem.self).filter("sku contains '\(items![cellRowIndexPath].sku)'").first
                
        let storefrontItem = self.realm.objects(Item.self).filter("sku contains '\(items![cellRowIndexPath].sku)'").first
                
        let alert = UIAlertController(title: "Add this to your cart?", message: "", preferredStyle: .alert)
                
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCartItem = CartItem()
            
            if cartItem == nil {
                                
                newCartItem.id = self.cartItemId
                newCartItem.sku = storefrontItem!.sku
                newCartItem.name = cell.titleLabel.text!
                cell.priceLabel.text?.remove(at: cell.priceLabel.text!.startIndex)
                newCartItem.price = Float(cell.priceLabel.text!)!
                
                let imageData: NSData = cell.itemImageView.image!.pngData()! as NSData
                newCartItem.image = imageData
                
                newCartItem.quantity = 1

                self.cartItemId += 1
                
                self.save(cartItem: newCartItem)
            } else {
                do {
                    try self.realm.write{
                        cartItem?.quantity += 1
                        cell.priceLabel.text?.remove(at: cell.priceLabel.text!.startIndex)
                        cartItem?.price += Float(cell.priceLabel.text!)!
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error increasing item quantity: \(error)")
                }
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
            return
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - Extensions To Get Index Path of Selected Cell
extension UIResponder {

    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next() })
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return self.next(of: UITableView.self)
    }

    var indexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}
