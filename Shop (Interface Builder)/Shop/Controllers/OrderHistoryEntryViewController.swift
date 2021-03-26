//
//  OrderHistoryEntryViewController.swift
//  Shop
//
//  Created by Ryan Park on 12/3/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import UIKit
import RealmSwift

class OrderHistoryEntryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var orderHistoryEntries: Results<OrderHistoryEntry>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderHistoryEntries?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue default cell as reusable cell
        let cell: UITableViewCell = {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
               return UITableViewCell(style: .default, reuseIdentifier: "cell")
               }
               return cell
           }()
        
        if let orderHistoryEntry = orderHistoryEntries?[indexPath.row] {
            cell.textLabel?.text = orderHistoryEntry.name
        }
        return cell
    }
    
    //MARK: - Tableview Size Methods
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return CGFloat(indexPath.row) + 75
     }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToOrderHistoryProducts", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! OrderHistoryProductViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedOrderHistoryEntry = orderHistoryEntries?[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    func loadData() {
        
        orderHistoryEntries = realm.objects(OrderHistoryEntry.self).sorted(byKeyPath: "name", ascending: false)
        
        tableView.reloadData()
    }
}
