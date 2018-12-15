//
//  ViewController.swift
//  Todoey
//
//  Created by Mohammad Mohaisen on 12/4/18.
//  Copyright © 2018 amjad Mohaisen. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    let realm = try! Realm()

    var itemArray: Results<Item>?
    

    
    var selectedCategory : Category? {
        didSet {
            loadItem()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

   
        loadItem()

        
    }
   
    
    //MARK : table view datasource method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoIteamCell", for: indexPath)
        if let item = itemArray?[indexPath.row] {
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        }
        else {
            cell.textLabel?.text = "No Items Add"
        }

        
        
        
        return cell
    }
    
    //MARK : table view deleget method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let item = itemArray?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            }  catch {
                    print("Error of handling done proparit, \(error)")
                }
            
        }
      tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - add new iteam
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alart = UIAlertController.init(title: "Add new Todoey", message: "", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            // what will happened when add item is presssed
    
            
            
            if let currentCategory = self.selectedCategory {
                
                do {
                  try self.itemArray?.realm?.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                    newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                }

                } catch {
                    print("Error saving new items \(error)")
                }
            

          self.tableView.reloadData()
         
           

            }
          
           
    
        }
        alart.addTextField { (aleartTextField) in
            aleartTextField.placeholder = "Create new item"
            textField = aleartTextField
            
        }
        
        alart.addAction(action)
        
        present(alart, animated: true, completion: nil)
    }


    func loadItem() {

   itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        
    }
    
    
}



extension TodoListViewController : UISearchBarDelegate {
 
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        itemArray = itemArray?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)

        tableView.reloadData()
        
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count == 0 {
            loadItem()
            DispatchQueue.main.async {
                
                searchBar.resignFirstResponder()
  
            }

            
        }
    }
    
    
}
