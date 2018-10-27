//
//  FavoriteMovies.swift
//  Movs
//
//  Created by Gabriel Reynoso on 26/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

protocol FavoriteMoviesDelegate: AnyObject {
    func favoriteMovies(_ sender: FavoriteMovies, unfavoriteMovieAt indexPath: IndexPath)
}

final class FavoriteMovies: UIView {
    
    enum State {
        case empty
        case all
        case filtered
    }
    
    private let tableViewDataSource = FavoriteMoviesDataSource()
    
    private var tableView:FavoriteMoviesTableView! {
        didSet {
            self.tableView.setupView()
            self.tableView.dataSource = self.tableViewDataSource
            self.tableView.delegate = self
            self.addSubview(self.tableView)
        }
    }
    
    private var removeFilterButton:UIButton! {
        didSet {
            self.removeFilterButton.backgroundColor = Colors.darkBlue.color
            self.removeFilterButton.tintColor = Colors.mainYellow.color
        }
    }
    
    private var feedbackView:FeedbackView! {
        didSet {
            self.feedbackView.setupView()
            self.addSubview(self.feedbackView)
        }
    }
    
    var state: State = .empty {
        didSet { self.refreshUIAcoordingToState() }
    }
    
    var movieItems:[FavoriteMoviesCell.Data] = [] {
        didSet { self.tableViewDataSource.items = self.movieItems }
    }
    
    weak var delegate:FavoriteMoviesDelegate?
    
    private func refreshUIAcoordingToState() {
        switch self.state {
        case .empty:
            self.tableView.isHidden = true
            self.feedbackView.isHidden = false
            self.feedbackView.text = "You don't have any favorite movies yet!"
        case .all:
            self.feedbackView.isHidden = true
            self.tableView.isHidden = false
            self.tableView.sectionHeaderHeight = 0.0
            self.tableView.tableHeaderView = nil
        case .filtered:
            self.feedbackView.isHidden = true
            self.tableView.isHidden = false
            self.tableView.sectionHeaderHeight = 50.0
            self.tableView.tableHeaderView = self.removeFilterButton
        }
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}

extension FavoriteMovies: ViewCode {
    
    func design() {
        self.backgroundColor = Colors.white.color
        self.tableView = FavoriteMoviesTableView(frame: .zero)
        self.removeFilterButton = UIButton(frame: .zero)
        self.feedbackView = FeedbackView()
        self.refreshUIAcoordingToState()
    }
    
    func autolayout() {
        self.tableView.fillAvailableSpaceInSafeArea()
        self.feedbackView.fillAvailableSpaceInSafeArea()
    }
}

extension FavoriteMovies: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let unfavorite = UITableViewRowAction(style: .default,
                                              title: "Unfavorite")
        { [unowned self] _, indexPath in
            self.delegate?.favoriteMovies(self, unfavoriteMovieAt: indexPath)
        }
        return [unfavorite]
    }
}
