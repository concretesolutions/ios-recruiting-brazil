//
//  FilterViewController.swift
//  Movs
//
//  Created by vinicius emanuel on 17/01/19.
//  Copyright © 2019 vinicius emanuel. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    @IBOutlet weak var filterTable: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    
    private let dateCellID = "filterDateCellID"
    private let genreCellID = "filterGenreCellID"
    private let segueID = "filtersToValues"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.filterTable.delegate = self
        self.filterTable.dataSource = self
    }
    
    @IBAction func applyButtonPressed(_ sender: Any) {
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: self.dateCellID) as! FilterTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: self.genreCellID) as! FilterTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: self.segueID, sender: self)
    }
}
