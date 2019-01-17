//
//  FilterValueViewController.swift
//  Movs
//
//  Created by vinicius emanuel on 17/01/19.
//  Copyright © 2019 vinicius emanuel. All rights reserved.
//

import UIKit

class FilterValueViewController: UIViewController {
    @IBOutlet weak var valueTable: UITableView!
    
    private let cellID = "valueCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.valueTable.delegate = self
        self.valueTable.dataSource = self
    }
}

extension FilterValueViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID) as! FilterValueTableViewCell
        return cell
    }
}
