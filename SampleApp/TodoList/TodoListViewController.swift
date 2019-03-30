//
//  TodoListViewController.swift
//  SampleApp
//
//  Created by  dlc-it on 2019/3/30.
//  Copyright © 2019 shawnli. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Item", message: "Add a new item", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            guard let textField = alert.textFields?.first,
            let content = textField.text else {
                return
            }
            
            self.todoList.addItem(content: content)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    let todoList = TodoListDataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoList.count()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCellId", for: indexPath)

        cell.textLabel!.text = self.todoList[indexPath.row]!.content

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.todoList.deleteItem(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
}
