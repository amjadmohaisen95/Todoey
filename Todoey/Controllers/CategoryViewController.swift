//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Mohammad Mohaisen on 12/12/18.
//  Copyright © 2018 amjad Mohaisen. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    
    let realm = try! Realm()
    
    var categoryArray : Results<Category>?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
        
    }
    
    
    
    
    //MARK: TableView DataSource Methods :
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categoryArray?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = category?.name ?? "No Categories Added Yet"
        
        
        return cell
    }
    
    
    
    
    
    //MARK : TableView Manipulating Methods :
    
    func loadCategory() {

        categoryArray = realm.objects(Category.self)
        
        
       tableView.reloadData()
    }
    
    func save(category : Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error context category \(error)")
        }
        
        
        self.tableView.reloadData()
        
    }
    
    //MARK: Add Button Pressed:
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController.init(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
        
            
            self.save(category: newCategory)
    
            
        }
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            textField.placeholder = "add new category"
            
            
        }
        
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    //Mark : TableView Deleget Methods:
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray![indexPath.row]
        }
    }
    
}
