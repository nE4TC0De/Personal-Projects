//
//  HistoryEntryViewController.swift
//  Shop
//
//  Created by Ryan Park on 12/3/20.
//  Copyright © 2020 liveandlearn. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryEntryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var historyEntries: Results<HistoryEntry>?
    
    let historyItemView = HistoryItemViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyEntries?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue default cell as reusable cell
        let cell: UITableViewCell = {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
               return UITableViewCell(style: .default, reuseIdentifier: "cell")
               }
               return cell
           }()
        
        if let historyEntry = historyEntries?[indexPath.row] {
            cell.textLabel?.text = historyEntry.name
        }
        return cell
    }
    
    //MARK: - Tableview Size Methods
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return CGFloat(indexPath.row) + 75
     }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passDataAndPresent()
    }
    
    // Method to pass data to the HistoryItemViewController and transition to it.
    func passDataAndPresent() {
        if let indexPath = tableView.indexPathForSelectedRow {
            historyItemView.selectedHistoryEntry = historyEntries?[indexPath.row]
        }
        // Transition via viewController stack.
//        present(historyItemView, animated: true, completion: nil)
        
        // Transition via navController.
        self.navigationController?.pushViewController(historyItemView, animated: true)
    }
    
        
    //MARK: - Data Manipulation Methods
    func loadData() {
        
        historyEntries = realm.objects(HistoryEntry.self).sorted(byKeyPath: "name", ascending: false)
        
        tableView.reloadData()
    }
}
