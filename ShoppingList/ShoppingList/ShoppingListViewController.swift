//
//  ViewController.swift
//  ShoppingList
//
//  Created by Jonathon Day on 1/16/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    let shoppingDataSource = ShoppingListDataSource()
    
    @IBOutlet var purchasedTableView: UITableView!
    @IBOutlet var toBuyTableView: UITableView!
    
    @IBAction func addItem(_ sender: UIButton) {
        let ac = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "Enter item description..."
            textField.delegate = self
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            if let item = ac.textFields!.first!.text {
                self.shoppingDataSource.add(item)
                self.toBuyTableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(addAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        purchasedTableView.delegate = self
        purchasedTableView.dataSource = shoppingDataSource
        toBuyTableView.delegate = self
        toBuyTableView.dataSource = shoppingDataSource
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView.tag {
        case 1:
            let item = shoppingDataSource.shoppingList[indexPath.row]
            shoppingDataSource.purchaseItem(item)
        case 2:
            let item = shoppingDataSource.purchasedList[indexPath.row]
            shoppingDataSource.reAdd(item)
        default:
            fatalError()
        }
        
        purchasedTableView.reloadData()
        toBuyTableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != nil {
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
}

class ShoppingListDataSource: NSObject, UITableViewDataSource {
    var shoppingList = [String]()
    var purchasedList = [String]()
    
    func add(_ item: String) {
        shoppingList.append(item)
    }
    
    func reAdd(_ item: String) {
        let removeIndex = purchasedList.index(where: { $0 == item } )!
        purchasedList.remove(at: removeIndex)
        shoppingList.append(item)
    }
    
    func purchaseItem(_ item: String) {
        let removeIndex = shoppingList.index(where: { $0 == item } )!
        shoppingList.remove(at: removeIndex)
        purchasedList.append(item)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 1:
            return shoppingList.count
        case 2:
            return purchasedList.count
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier: String
        let list: [String]
        
        switch tableView.tag {
        case 1:
            reuseIdentifier = "shoppingCell"
            list = shoppingList
        case 2:
            reuseIdentifier = "purchasedCell"
            list = purchasedList
        default:
            fatalError()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!
        let item = list[indexPath.row]
        
        cell.textLabel!.text = item
        return cell
    }
}

