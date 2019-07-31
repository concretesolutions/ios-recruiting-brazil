//
//  FavoriteMoviesView.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/29/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit

final class FavoriteMoviesView: UIView {
    //MARK:- Views -
    
    private(set) var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(FavoriteMoviesTableCell.self, forCellReuseIdentifier: "FavoriteMoviesTableCell")
        view.separatorStyle = .none
        view.backgroundColor = UIColor(red: 228, green: 228, blue: 226, alpha: 1)
        return view
    }()
    
    private(set) var searchBar: UISearchBar = {
        let searchView = UISearchBar()
        searchView.searchBarStyle = UISearchBar.Style.minimal
        return searchView
    }()
    
    private(set) var dismissFilterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.layer.cornerRadius = 10
        
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Dismiss Filter", for: .normal)
        return button
    }()
    
    private(set) var offsetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private(set) var feedbackView = FavoriteMoviesFeedbackView()
    
    //MARK:- Constructors -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- Override Methods -
    override func didMoveToWindow() {
        super.didMoveToWindow()
        setupConstraints()
    }
    
    //MARK:- Methods -
    
    fileprivate func setupUIElements() {
        backgroundColor = .white
        
        tableView.delegate = self
        
        self.addSubview(dismissFilterButton)
        self.addSubview(tableView)
        self.addSubview(searchBar)
        self.addSubview(feedbackView)
        
        self.searchBar.insertSubview(offsetView, at: 0)
    }
    
    fileprivate func setupConstraints() {
        let guide = self.safeAreaLayoutGuide
        
        searchBar.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.right.equalTo(guide).inset(10)
            ConstraintMaker.top.equalTo(guide).inset(-10)
        }
        
        dismissFilterButton.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(searchBar.snp.bottom).offset(2)
            ConstraintMaker.left.right.equalTo(searchBar).inset(10)
            ConstraintMaker.height.equalTo(searchBar).multipliedBy(0.8)
        }
        
        offsetView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.width.equalTo(searchBar)
            ConstraintMaker.height.equalTo(searchBar).offset(10)
        }
        
        tableView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.bottom.left.right.equalTo(guide).inset(10)
            ConstraintMaker.top.equalTo(dismissFilterButton.snp.bottom).offset(5)
        }
        
        feedbackView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.left.right.bottom.equalTo(tableView)
        }
    }
}

extension FavoriteMoviesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.bounds.height
        let cellHeight = height/5
        return cellHeight
    }
}

