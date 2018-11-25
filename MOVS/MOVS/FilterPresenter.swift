//
//  FilterPresenter.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 25/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilterPresenter: NSObject {
    // MARK: - Properties
    // MARK: - Outlets
    // MARK: Public
    var router:FilterRouter
    var interactor:FilterInteractor
    var view:FilterView
    
    // MARK: - Initializers
    init(router:FilterRouter, interactor:FilterInteractor, view:FilterView) {
        self.router = router
        self.interactor = interactor
        self.view = view
        super.init()
        self.view.presenter = self
        
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func viewDidLoad() {
        self.view.outletTableView.dataSource = self
    }
    
    func viewWillAppear(){
        self.view.outletTableView.reloadData()
    }
}

extension FilterPresenter: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell: FilterTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(withDescription: "Ano", andValue: self.interactor.year)
            return cell
        }else if indexPath.row == 1{
            let cell: FilterTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(withDescription: "Gênero", andValue: self.interactor.genre?.name)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
