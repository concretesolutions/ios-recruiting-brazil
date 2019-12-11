//
//  FilterController.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class FilterController: UIViewController {
    // MARK: - Attributes
    let filterType: FilterType
    lazy var screen = FilterScreen(delegate: self)
    
    // MARK: - Initializers
    required init(filterType: FilterType) {
        self.filterType = filterType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View controller life cycle
    override func loadView() {
        super.loadView()
        self.view = self.screen
        switch self.filterType {
        case .date:
            self.title = "Date"
        case .genre:
            self.title = "Genres"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .always
    }
}

extension FilterController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "2008"
        return cell
    }
}

extension FilterController: UITableViewDelegate {
    
}
