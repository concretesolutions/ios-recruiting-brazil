//
//  FavoriteMoviesViewController.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 26/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import SnapKit

class FavoriteMoviesViewController: UIViewController {
    
    //FIXME:- unfavoriting movie when filter is applied is not working
    
    var tableView = FavoriteMoviesTableView()
    var tableViewDelegate: FavoriteMoviesTableViewDelegate?
    var tableViewDataSource: FavoriteMoviesTableViewDataSource?
    
    var favoritedMovies:[Movie] = []
    
    fileprivate enum PresentationState{
        case withFilter
        case withoutFilter
    }
    
    fileprivate var presentationState: PresentationState = .withoutFilter{
        didSet{
            changePresentationState(to: presentationState)
        }
    }
    
    lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentationState = .withoutFilter
        setupView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if presentationState == .withoutFilter{
            self.getFavoriteMovies()
        }
    }
    
    func getFavoriteMovies(){
        self.favoritedMovies = []
        let favoriteMoviesRealm = RealmManager.shared.getAll(objectsOf: MovieRealm.self)
        favoriteMoviesRealm.forEach({self.favoritedMovies.append(Movie(realmObject: $0))})
        self.setupTableView(with: self.favoritedMovies)
    }
    
    func setupTableView(with movies: [Movie]){
        tableViewDelegate = FavoriteMoviesTableViewDelegate(favoritedMovies: movies, delegate: self)
        self.tableView.delegate = tableViewDelegate
        tableViewDataSource = FavoriteMoviesTableViewDataSource(favoritedMovies: movies, tableView: self.tableView)
        self.tableView.dataSource = tableViewDataSource
        self.tableView.reloadData()
    }
    
    @objc
    func pushFilterOptions(){
        let filterViewController = FilterOptionsViewController(movies: favoritedMovies, delegate: self)
        filterViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(filterViewController, animated: true)
    }
    
    fileprivate func changePresentationState(to state: PresentationState){
        switch state {
        case .withFilter:
            setupView()
            break
        case .withoutFilter:
            getFavoriteMovies()
            self.setupView()
        }
    }
    
    @objc
    func removeFilter(){
        self.presentationState = .withoutFilter
    }
    
}

extension FavoriteMoviesViewController: CodeView{
    
    func buildViewHierarchy() {
        view.addSubview(button)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        
        tableView.snp.removeConstraints()
        button.snp.removeConstraints()
        
        if self.presentationState == .withoutFilter{
        
            tableView.snp.makeConstraints { (make) in
                make.height.equalToSuperview()
                make.bottom.equalToSuperview()
                make.trailing.equalToSuperview()
                make.leading.equalToSuperview()
            }
            
            button.snp.makeConstraints { (make) in
                make.bottom.equalTo(tableView.snp.top)
                make.trailing.equalToSuperview()
                make.leading.equalToSuperview()
                make.height.equalTo(0)
            }
        }else{
            
            tableView.snp.makeConstraints { (make) in
                make.height.equalToSuperview().multipliedBy(0.8)
                make.bottom.equalToSuperview()
                make.trailing.equalToSuperview()
                make.leading.equalToSuperview()
            }
    
            button.snp.makeConstraints { (make) in
                make.bottom.equalTo(tableView.snp.top)
                make.trailing.equalToSuperview()
                make.leading.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(0.1)
            }
        }
        
    }
    
    func setupAdditionalConfiguration() {
        
        button.setTitle("Remove Filter", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.setTitleColor(Design.Colors.darkYellow, for: .normal)
        button.backgroundColor = Design.Colors.darkBlue
        button.addTarget(self, action: #selector(removeFilter), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: self, action: #selector(pushFilterOptions))
    }
    
}

extension FavoriteMoviesViewController: UnfavoriteMovieDelegate{
    
    func deleteRowAt(indexPath: IndexPath) {
        if let movieToDelete = RealmManager.shared.get(objectOf: MovieRealm.self, with: self.favoritedMovies[indexPath.row].id){
            RealmManager.shared.delete(object: movieToDelete)
            tableViewDataSource?.favoritedMovies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}

extension FavoriteMoviesViewController: FilterDelegate{
    
    func updateMovies(with filteredMovies: [Movie]) {
        self.presentationState = .withFilter
        self.setupTableView(with: filteredMovies)
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
}
