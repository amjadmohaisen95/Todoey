//
//  ViewController.swift
//  Todoey
//
//  Created by Mohammad Mohaisen on 12/4/18.
//  Copyright © 2018 amjad Mohaisen. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

  var iteamArray = ["Go Out","Buy Food","Vist Friend"]
    let defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "TodoList") as? [String] {
            iteamArray = items
        }
        
    }
   
    
    //MARK : table view datasource method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iteamArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoIteamCell", for: indexPath)
        cell.textLabel?.text = iteamArray[indexPath.row]
        return cell
    }
    
    //MARK : table view deleget method
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
       // print(iteamArray[indexPath.row])
        
          tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
      
    }
    //MARK - add new iteam
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alart = UIAlertController.init(title: "Add new Todoey", message: "", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            // what will happened when add item is presssed
            
            self.iteamArray.append(textField.text!)
            self.tableView.reloadData()
            self.defaults.set(self.iteamArray, forKey: "TodoListArray")
    
        }
        alart.addTextField { (aleartTextField) in
            aleartTextField.placeholder = "Create new item"
            textField = aleartTextField
            
        }
        
        alart.addAction(action)
        
        present(alart, animated: true, completion: nil)
    }
}

