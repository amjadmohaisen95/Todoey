//
//  ViewController.swift
//  Todoey
//
//  Created by Mohammad Mohaisen on 12/4/18.
//  Copyright © 2018 amjad Mohaisen. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

  let iteamArray = ["Go Out","Buy Food","Vist Friend"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
   
    
    //mark : table view datasource method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iteamArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoIteamCell", for: indexPath)
        cell.textLabel?.text = iteamArray[indexPath.row]
        return cell
    }
    
    //mark : table view deleget method
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
       // print(iteamArray[indexPath.row])
          tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
      
    }
}

