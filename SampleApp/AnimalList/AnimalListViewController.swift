//
//  LabelListViewControllerTableViewController.swift
//  SampleApp
//
//  Created by  dlc-it on 2019/3/25.
//  Copyright © 2019 shawnli. All rights reserved.
//

import UIKit

let animalApiUrl = URL(string: "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=a3e2b221-75e0-45c1-8f97-75acbd43d613")!

class AnimalListViewController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate {
    var animals: [Animal] = []
    
    var originalAnimals: [Animal] = []
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        ApiRequest.shared.get(animalApiUrl) { url in
            if let data = try? Data(contentsOf: url) {
                let animalsResult = try? JSONDecoder().decode(AnimalsResponse.self, from: data).result
                self.animals = animalsResult!.results
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Search Results Updating protocol
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if searchText == "" {
            self.animals = self.originalAnimals
        } else {
            self.animals = self.originalAnimals.filter {
                $0.name.range(of: searchText, options: .caseInsensitive) != nil
            }
        }
        self.tableView.reloadData()
    }

    // MARK: - Search Controller delegate
    func willPresentSearchController(_ searchController: UISearchController) {
        self.originalAnimals = self.animals
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCellId", for: indexPath)
        cell.textLabel!.text = self.animals[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let AnimalDetailViewController = AnimalDetailViewController.create(label: self.animals[indexPath.row].name)
        performSegue(withIdentifier: "showAnimalDetail", sender: self)
        
        //self.navigationController?.pushViewController(labelDetailViewController, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let animalDetailViewController = segue.destination as! AnimalDetailViewController
        animalDetailViewController.animal = self.animals[self.tableView.indexPathForSelectedRow!.row]
    }
}
