//
//  RecipeSearchController.swift
//  RecipeSearch
//
//  Created by Alex Paul on 12/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class RecipeSearchController: UIViewController {
    //TODO: we need a table view
    //TODO: we need a recipes array
    //TODO: on the recipes array have a didSet{} to update the tableview
    //TODO: in cellForRow show the recipes label
    //TODO: recipeSearchAPI.fetchRecipes() {...} accessing data to populate
    //TODO: recipes array ex: "christmas cookies"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchQuery = ""
    var recipes = [Recipe]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        searchRecipes(searchQuery: "christmas cookies")
    }
    func searchRecipes(searchQuery: String) {
        RecipeSearchAPI.fetchRecipe(for: searchQuery, completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let recipes):
                self?.recipes = recipes
            }
        })
    }
}
    

extension RecipeSearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeCell else {
            fatalError("Could not deqeue recipeCell")
        }
        
        let recipe = recipes[indexPath.row]
        cell.configureCell(for: recipe)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }
}
extension RecipeSearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

extension RecipeSearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            print("missing search text")
            return
        }
        searchRecipes(searchQuery: searchText)
        searchBar.resignFirstResponder()
    }
}
