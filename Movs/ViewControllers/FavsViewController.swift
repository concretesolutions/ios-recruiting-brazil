//
//  FavsViewController.swift
//  Movs
//
//  Created by Filipe on 17/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class FavsViewController: UIViewController {

    @IBOutlet weak var favTabBarItem: UITabBarItem!
    @IBOutlet weak var favsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favsTableView.delegate = self
        favsTableView.dataSource = self
        favTabBarItem.selectedImage = (UIImage(named: "favorite_empty_icon"))
    }

}

// MARK: - UITableViewDataSource
extension FavsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fcell", for: indexPath)
        cell.textLabel?.text = "TESTE"
        cell.detailTextLabel?.text = "testinho"
        return cell
    }
}
// MARK: - UITableViewDelegate
extension FavsViewController: UITableViewDelegate {
    
}
