//
//  ViewController.swift
//  Todoey
//
//  Created by Mohammad Mohaisen on 12/4/18.
//  Copyright © 2018 amjad Mohaisen. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        didSet {
            loadItem()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist"))


        
        loadItem()

        
    }
   
    
    //MARK : table view datasource method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoIteamCell", for: indexPath)
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        

        
        
        
        return cell
    }
    
    //MARK : table view deleget method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(iteamArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
      
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - add new iteam
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alart = UIAlertController.init(title: "Add new Todoey", message: "", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            // what will happened when add item is presssed
          
            let newItem = Item(context: self.context)
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            newItem.title = textField.text!
            self.itemArray.append(newItem)
          
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
        
        do {
         try context.save()
        } catch {
            print("Error context item \(error)")
        }
        
        
        self.tableView.reloadData()
        
    }
    

    func loadItem(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {

        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)

        if let additinalPredicat = predicate {
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additinalPredicat])
            request.predicate = compoundPredicate
        } else {
            request.predicate = categoryPredicate
        }
        
        
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categorypredicate,predicate])
//         request.predicate = compoundPredicate
//       // let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
     itemArray = try context.fetch(request)
        } catch {
            print("Error during fetching data, \(error)")
        }
        
    }
    
    
}



extension TodoListViewController : UISearchBarDelegate {
 
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate.init(format: "title CONTAINS[cd] %@", searchBar.text!)
        
       // request.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor.init(key: "title", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        loadItem(with: request, predicate: predicate)
        
  
        
        
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
