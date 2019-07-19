//
//  FavoritesViewController.swift
//  Mov
//
//  Created by Victor Leal on 18/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    let screen = FavoritesViewControllerScreen()
    
    override func loadView() {
        self.view = screen
        //self.view.backgroundColor = .blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen.favoritesTableView.delegate = self
        screen.favoritesTableView.dataSource = self
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath)
        cell.textLabel!.text = "A"
        return cell
        
    }
    
    
}






