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
    
    func dismissWithFilter(inFavoriteView favoriteView: FavoriteView){
        favoriteView.presenter.filterWith(year: self.interactor.year, andGenre: self.interactor.genre)
        self.router.dismissWithFilter(inNavigationController: self.view.navigationController)
    }
    
    func goToFilter(toChoose choose: FilterFavoriteType){
        if choose == .genre{
            if let genre = self.interactor.genre {
                self.router.goToFilter(withChooseType: choose, andOptions: genre as Any)
            }else{
                self.router.goToFilter(withChooseType: choose)
            }
        }else{
            if let year = self.interactor.year {
                self.router.goToFilter(withChooseType: choose, andOptions: year as Any)
            }else{
                self.router.goToFilter(withChooseType: choose)
            }
        }
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
