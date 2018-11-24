//
//  FilmDetailPresenter.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 23/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilmDetailPresenter: NSObject{
    // MARK: - Variables
    // MARK: Private
    
    // MARK: Public
    var router:FilmDetailRouter
    var interactor:FilmDetailInteractor
    var view:FilmDetailView
    
    // MARK: - Initializers
    init(router:FilmDetailRouter, interactor:FilmDetailInteractor, view:FilmDetailView) {
        self.router = router
        self.interactor = interactor
        self.view = view
        super.init()
        self.view.presenter = self
        
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func viewDidLoad(withTableView tableView: UITableView) {
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
    }
    
    func viewDidAppear(withTableView tableView: UITableView){
        tableView.scrollToRow(at: IndexPath(row: 1, section: 0), at: .none, animated: true)
    }
}

extension FilmDetailPresenter: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: CoverTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(withFilm: self.interactor.film)
            return cell
        }else if indexPath.row == 1{
            let cell: FilmInfoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(withFilm: self.interactor.film)
            return cell
        }else if indexPath.row == 2{
            let cell: OverviewTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(withFilm: self.interactor.film)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
