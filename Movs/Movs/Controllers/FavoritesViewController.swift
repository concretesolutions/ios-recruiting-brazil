//
//  FavoritesViewController.swift
//  Movs
//
//  Created by Franclin Cabral on 1/18/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import UIKit
import RxSwift

class FavoritesViewController: UIViewController, BaseController {
    var baseViewModel: BaseViewModelProtocol! {
        didSet {
            viewModel = (baseViewModel as! FavoritesViewModelProtocol)
        }
    }
    var viewModel: FavoritesViewModelProtocol!
    let disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        viewModel.dataSource.asObservable()
            .subscribe(onNext: { [weak self](movies) in                
                if movies.count != 0 {
                    self?.tableView.isHidden = false
                    self?.tableView.reloadData()
                } else {
                    self?.tableView.isHidden = true
                }
                
            })
        .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData()
    }
    
    func configure() {
        
        tableView.register(UINib(nibName: Constants.favoriteCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.favoriteCellIdentifier)
        tableView.allowsMultipleSelection = false
    }
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.favoriteCellIdentifier, for: indexPath)
            as! FavoriteCell
        cell.configure(movie: viewModel.getMovie(indexPath.item))
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            viewModel.removeFavorited(index: indexPath.item)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
        }
    }
}

extension FavoritesViewController: StoryboardItem {
    static func containerStoryboard() -> ApplicationStoryboard {
        return ApplicationStoryboard.main
    }
}
