//
//  FavoriteListViewControllerScreen.swift
//  movies
//
//  Created by Jacqueline Alves on 02/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit
import Combine

final class FavoriteListViewControllerScreen: UIView {
    
    lazy var tableView: UITableView = {
        let view: UITableView = UITableView(frame: .zero)
        view.register(FavoriteMovieTableViewCell.self, forCellReuseIdentifier: "FavoriteMovieTableViewCell")
        view.backgroundColor = .systemBackground
        view.separatorStyle = .none
        view.refreshControl = self.refreshControl
        
        return view
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        return refreshControl
    }()
    
    lazy var removeFiltersButton: UIButton = {
        let view: UIButton = UIButton(frame: .zero)
        view.backgroundColor = .systemOrange
        view.setTitle("Remove Filter", for: .normal)
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: CGRect.zero)
        view.isUserInteractionEnabled = false
        
        return view
    }()
    
    let genericErrorView = ErrorView(imageName: "error_icon", text: "An error occured. Please try again.")
    let noDataErrorView = ErrorView(imageName: "search_icon", text: "Your search didn't return anything.")
    
    var state: MovieListViewState = .movies {
        willSet {
            // Update view when state is changed
            self.updateViewState(to: newValue)
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Update view according to current state
    /// - Parameter state: Current state
    public func updateViewState(to state: MovieListViewState) {
        // State = .filter
        self.removeFiltersButton.isHidden = !(state == .filter)
        // State = .error
        self.genericErrorView.isHidden = !(state == .error)
        // State = .noDataError
        self.noDataErrorView.isHidden = !(state == .noDataError)
        // State = .loading
        self.activityIndicator.isHidden = !(state == .loading)
        self.tableView.isHidden = (state == .loading)
        
        if state == .loading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
    
    /// Set table view data source and delegate
    /// - Parameter controller: Controller responsable for table view delegate and data source
    public func setupTableView<T: UITableViewDelegate & UITableViewDataSource>(controller: T) {
        self.tableView.delegate = controller
        self.tableView.dataSource = controller
    }
    
    /// Reloads the table view
    public func reloadTableView() {
        self.tableView.reloadData()
    }
}

extension FavoriteListViewControllerScreen: CodeView {
    
    func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(activityIndicator)
        addSubview(genericErrorView)
        addSubview(noDataErrorView)
        addSubview(removeFiltersButton)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().inset(10)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().inset(10)
        }
        
        genericErrorView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().inset(10)
        }
        
        noDataErrorView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().inset(10)
        }
        
        removeFiltersButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = UIColor.systemBackground
    }
}
