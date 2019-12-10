//
//  FavoriteMoviesController.swift
//  DesafioConcrete
//
//  Created by Kacio Henrique Couto Batista on 05/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit
import SnapKit
class FavoriteMoviesController: UIViewController {
    var itemsToLoad: [String] = ["One", "Two", "Three"]
    lazy var tableView:UITableView = {
        let view = UITableView(frame: .zero)
        return view
    }()
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .blue
        self.view = view
        setupView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
extension FavoriteMoviesController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsToLoad.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:FavoriteMovieCellView = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? FavoriteMovieCellView
            else{
                return tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        }
        return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            // remove the item from the data model
            itemsToLoad.remove(at: indexPath.row)

            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)

        }
    }
}
extension FavoriteMoviesController:CodeView{
    func buildViewHierarchy() {
        self.view.addSubview(tableView)
    }
    
    func setupConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        tableView.register(FavoriteMovieCellView.self, forCellReuseIdentifier: "myCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
}
