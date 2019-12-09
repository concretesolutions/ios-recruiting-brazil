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
        
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: CGRect.zero)
        view.isUserInteractionEnabled = false
        
        return view
    }()
    
    let genericErrorView = ErrorView(imageName: "error_icon", text: "An error occured. Please try again.")
    let noDataErrorView = ErrorView(imageName: "search_icon", text: "Your search didn't return anything.")
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect = .zero, state: AnyPublisher<MovieListViewState, Never>) {
        self.init(frame: frame)
        
        _ = state
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] state in
                self?.updateViewState(to: state)
            })
    }
    
    func updateViewState(to state: MovieListViewState) {
        // State = .movies
        tableView.isHidden = !(state == .movies)
        // State = .loading
        activityIndicator.isHidden = !(state == .loading)
        // State = .error
        genericErrorView.isHidden = !(state == .error)
        // State = .noDataError
        noDataErrorView.isHidden = !(state == .noDataError)

        if state == .loading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

extension FavoriteListViewControllerScreen: CodeView {
    
    func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(activityIndicator)
        addSubview(genericErrorView)
        addSubview(noDataErrorView)
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
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = UIColor.systemBackground
    }
}
