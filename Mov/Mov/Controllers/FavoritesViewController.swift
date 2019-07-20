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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as! FavoriteTableViewCell
        cell.title.text = "Thor"
        cell.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.00)
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        
       /* let maskLayer = CAShapeLayer()
        let bounds = cell.bounds
        maskLayer.path = UIBezierPath(roundedRect: CGRect(x: 2, y: 2, width: bounds.width-4, height: bounds.height-4), cornerRadius: 0).cgPath
        cell.layer.mask = maskLayer*/
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    
    
    
}






