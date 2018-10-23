//
//  ViewController.swift
//  AppMovie
//
//  Created by Renan Alves on 21/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class InitialScreen: UIViewController{

    var movies = [NSDictionary]()
    let tableView = UITableView(frame: UIScreen.main.bounds)
    let dataSource = MoviesTableViewDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donwloadMovies()
        setupTabBar()
    }
    
    func setupTabBar() {
        self.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.bookmarks, tag: 0)
        self.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.favorites, tag: 1)
    }
    
    private func setupTableView() {
        navigationItem.title = "Movies"
        registerTableViewCell()
        tableView.dataSource = dataSource
        dataSource.datas = movies
        self.view.addSubview(tableView)
    }
    
    func registerTableViewCell() {
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: "MovieTvCell")
    }
    
    private func donwloadMovies() {
        MovieDAO.shared.requestMovies(completion: { (moviesJSON) in
            if let _movies = moviesJSON {
                self.movies = _movies
                self.setupTableView()
            } else {
                print("Nothing movies")
            }
        })
    }
}

