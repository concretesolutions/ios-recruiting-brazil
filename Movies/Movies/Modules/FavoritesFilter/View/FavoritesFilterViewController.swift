//
//  FavoritesFilterViewController.swift
//  Movies
//
//  Created by Renan Germano on 25/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class FavoritesFilterViewController: UIViewController, FavoritesFilterView {
    
    // MARK: - Properties
    
    var presenter: FavoritesFilterPresentation!
    private var categoriesSection: UIView!
    private var categories: ButtonsSet!
    private var yearsSection: UIView!
    private var years: ButtonsSet!

    // MARK: - Life cicle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Aux functions
    
    private func createSection(withTitle title: String) -> UIView {
        
        return UIView(frame: .zero)
    }
    
    private func setUpCategoriesSection() {
        
    }
    
    private func setUpYearsSection() {
        
    }
    
    // MARK: - FilterView protocol functions
    
    func set(genres: [(genre: Genre, isSelected: Bool)]) {
        
    }
    
    func set(years: [(year: Int, isSelected: Bool)]) {
        
    }

}
