//
//  MovsNavigationSearchController.swift
//  Movs
//
//  Created by Gabriel Reynoso on 23/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class MovsNavigationSearchController: UISearchController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.tintColor = Colors.darkBlue.color
        let searchTextField: UITextField? = self.searchBar.value(forKey: "searchField") as? UITextField
        if searchTextField!.responds(to: #selector(getter: UITextField.attributedPlaceholder)) {
            searchTextField!.attributedPlaceholder = NSAttributedString(
                string: "Search here...",
                attributes: [.foregroundColor: Colors.darkBlue.color]
            )
        }
    }
}
