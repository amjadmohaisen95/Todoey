//
//  ViewController.swift
//  Todoey
//
//  Created by Mohammad Mohaisen on 12/4/18.
//  Copyright © 2018 amjad Mohaisen. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

  var iteamArray = [Item]()
  let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
        
        let newIteam = Item()
        newIteam.title = "Go Out"
        iteamArray.append(newIteam)
        
        let newIteam2 = Item()
        newIteam2.title = "Buy Food"
        iteamArray.append(newIteam2)
        
        let newIteam3 = Item()
        newIteam3.title = "Vist Friend"
        iteamArray.append(newIteam3)
        
        loadItem()
//     if let items = defaults.array(forKey: "TodoList") as? [Item] {
//        iteamArray = items
//        }
        
    }
   
    
    //MARK : table view datasource method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iteamArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = iteamArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoIteamCell", for: indexPath)
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        

        
        
        
        return cell
    }
    
    //MARK : table view deleget method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(iteamArray[indexPath.row])
        iteamArray[indexPath.row].done = !iteamArray[indexPath.row].done
        saveItems()
        
      
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - add new iteam
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alart = UIAlertController.init(title: "Add new Todoey", message: "", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            // what will happened when add item is presssed
            
            let newItem = Item()
            newItem.title = textField.text!
            self.iteamArray.append(newItem)
          
            self.saveItems()
    
        }
        alart.addTextField { (aleartTextField) in
            aleartTextField.placeholder = "Create new item"
            textField = aleartTextField
            
        }
        
        alart.addAction(action)
        
        present(alart, animated: true, completion: nil)
    }
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(iteamArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item \(error)")
        }
        
        
        self.tableView.reloadData()
        
    }
    
    
    func loadItem() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
        
        let decoder = PropertyListDecoder()
        
        do {
            iteamArray = try decoder.decode([Item].self,from: data)
        } catch {
            print("Error decoding item \(error)")
        }
        }
        
    }
    
    
    
}

