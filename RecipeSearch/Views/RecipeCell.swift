//
//  RecipeCell.swift
//  RecipeSearch
//
//  Created by Gregory Keeley on 12/12/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    
    
    
    func configureCell(for recipe: Recipe) {
        recipeLabel.text = recipe.label
        
        recipeImage.getImage(with: recipe.image) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("error: \(error)")
                DispatchQueue.main.async {
                self?.recipeImage.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.recipeImage.image = image
                }
            }
            
        }
    }
}
