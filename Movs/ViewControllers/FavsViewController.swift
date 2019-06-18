//
//  FavsViewController.swift
//  Movs
//
//  Created by Filipe on 17/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class FavsViewController: UIViewController {

// MARK: - Properties
    @IBOutlet weak var favsTableView: UITableView!
    private let reuseIdentifier = "fcell"

    
// MARK: - System Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        favsTableView.delegate = self
        favsTableView.dataSource = self
    }

}

// MARK: - UITableViewDataSource
extension FavsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "TESTE"
        cell.detailTextLabel?.text = "testinho"
        return cell
    }
}
// MARK: - UITableViewDelegate
extension FavsViewController: UITableViewDelegate {
    
}
