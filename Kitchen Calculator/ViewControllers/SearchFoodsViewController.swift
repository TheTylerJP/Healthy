//
//  SearchFoodsViewController.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 7/29/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit

class SearchFoodsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var filteredFoods = [Food]()
    
    @IBOutlet weak var foodItemsTableView: UITableView!
    var listOfFoods: ItemList? {
        didSet {

            DispatchQueue.main.async {
                self.foodItemsTableView.reloadData()
            }
        }
    }


    let searchController = UISearchController(searchResultsController: nil)

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            NutritionAPI.searchItems(itemToSearch: searchText, completion: { (itemList, error) in
                if let list = itemList {
                    self.listOfFoods = list
                }
            })
        }
        //Dismiss the search button.
        searchController.isActive = false
    }
    
    
    
    
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        optimizeSearchBar()
        
        // Do any additional setup after loading the view.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let list = listOfFoods else {
            return 0
        }
        if isFiltering() {
            return filteredFoods.count
        }
        return list.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "foodItemCell", for: indexPath) as! FoodCell
        guard let list = listOfFoods else {
            return cell
        }
        let foodItem: Food
        if isFiltering() {
            foodItem = filteredFoods[indexPath.row]
        } else {
            foodItem = list.items[indexPath.row]
        }


        cell.foodImage.image = foodItem.image
        cell.foodLabel.text = foodItem.title

        
        return cell
    }
    
    func isFiltering() -> Bool {

        return searchController.isActive && !searchBarIsEmpty()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toFoodInformation", sender: self.foodItemsTableView.cellForRow(at: indexPath))

    }

    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as? UITableViewCell
        let foodIndex = foodItemsTableView.indexPath(for: cell!)?.row

        let preparedFood = isFiltering() ? filteredFoods[foodIndex!] : listOfFoods?.items[foodIndex!]
        print(preparedFood?.title)

        if segue.identifier == "toFoodInformation" {
            let destination = segue.destination as? FoodItemViewController
            destination?.food = preparedFood

        }






    }


    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        if let searchDescriptionOfFoods = listOfFoods?.items.filter( { $0.description.lowercased().contains(searchText.lowercased())} ) {
            filteredFoods.append(contentsOf: searchDescriptionOfFoods)
        }
        
        
        if let searchTitleOfFoods = listOfFoods?.items.filter({$0.title.lowercased().contains(searchText.lowercased())}) {
            filteredFoods.append(contentsOf: searchTitleOfFoods)
        }
        
        if let SearchHealthNotesOfFoods = listOfFoods?.items.filter({$0.healthnotes.lowercased().contains(searchText.lowercased())}) {
            filteredFoods.append(contentsOf: SearchHealthNotesOfFoods)
        }
        
        foodItemsTableView.reloadData()
        
    }
    


    
    //=============================================================== Utility Functions ===============================================================
    //=============================================================== Utility Functions ===============================================================
    //=============================================================== Utility Functions ===============================================================
    
    func optimizeSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Foods"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        foodItemsTableView.delegate = self
        searchController.searchBar.delegate = self
        foodItemsTableView.dataSource = self
    }
    
}



extension SearchFoodsViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
