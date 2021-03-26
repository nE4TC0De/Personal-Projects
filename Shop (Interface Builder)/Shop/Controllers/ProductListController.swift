//
//  ProductListViewController.swift
//  Shop
//
//  Created by Ryan Park on 10/26/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import UIKit
import RealmSwift

class ProductListController: UITableViewController {
    
    let realm = try! Realm()
    
    var products: Results<Product>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadData()
        
        tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ProductReusableCell")
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductReusableCell", for: indexPath) as! ItemCell
        
        cell.delegate = self
                
        if let product = products?[indexPath.row] {
            cell.titleLabel?.text = product.name
            cell.priceLabel?.text = String(format: "%.2f", product.price)
            
            if let convertedImage = product.image {
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
    func save(cartItem: CartProduct) {
        
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
        
        products = realm.objects(Product.self)
        
        tableView.reloadData()
    }
    
}

//MARK: - ItemCellDelegate - Add Item To Cart
extension ProductListController: ItemCellDelegate {
    func pressedButton(_ cell: ItemCell) {
        
        let cellRowIndexPath = cell.indexPath.flatMap { $0.row } as! Int
        
        let itemBeingAdded = self.realm.objects(CartProduct.self).filter("id == \(cellRowIndexPath)").first
        
        let productBeingAdded = self.realm.objects(Product.self).filter("id == \(cellRowIndexPath)").first
        
        let alert = UIAlertController(title: "Add this to your cart?", message: "", preferredStyle: .alert)
                
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCartItem = CartProduct()
            
            if itemBeingAdded == nil {
                
                newCartItem.id = productBeingAdded?.id as! Int
                newCartItem.name = cell.titleLabel.text!
                newCartItem.price = Float(cell.priceLabel.text!)!
                
                let imageData: NSData = cell.productImageView.image!.pngData()! as NSData
                newCartItem.image = imageData
                
                newCartItem.quantity = 1

                self.save(cartItem: newCartItem)
            } else {
                do {
                    try self.realm.write{
                        itemBeingAdded?.quantity += 1
                        itemBeingAdded?.price += Float(cell.priceLabel.text!)!
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
