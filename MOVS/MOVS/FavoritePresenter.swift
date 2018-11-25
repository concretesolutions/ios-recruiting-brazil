//
//  FavoritePresenter.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 24/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FavoritePresenter: NSObject{
    // MARK: - Properties
    // MARK: - Outlets
    // MARK: Public
    var router:FavoriteRouter
    var interactor:FavoriteInteractor
    var view:FavoriteView
    
    // MARK: - Initializers
    init(router:FavoriteRouter, interactor:FavoriteInteractor, view:FavoriteView) {
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
        self.interactor.reloadData()
        self.view.outletTableView.reloadData()
    }
    
    func unfavorite(film: Film){
        self.interactor.unfavorite(film: film)
    }
    
    func update(inIndexPath indexPath: IndexPath){
        self.interactor.films.remove(at: self.interactor.films.count-indexPath.row-1)
    }
    
    func filterWith(name: String){
        self.interactor.filterWith(name: name)
    }
    
    func setIsFiltering(_ isFiltering: Bool){
        self.interactor.isFiltering = isFiltering
    }
    
    func goToFilter(){
        self.router.goToFilter()
    }
}

extension FavoritePresenter: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor.films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(withFilm: self.interactor.films[self.interactor.films.count-indexPath.row-1])
        return cell
    }
    
}
