//
//  YearsViewController.swift
//  movs
//
//  Created by Lorien Moisyn on 20/04/19.
//  Copyright © 2019 Auspex. All rights reserved.
//

import Foundation

class YearsViewController: BaseFilterViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getYears()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        parent?.children.forEach{
            guard let filterVC = $0 as? FilterTypesTableViewController else { return }
            filterVC.years = selected
        }
    }
    
}
