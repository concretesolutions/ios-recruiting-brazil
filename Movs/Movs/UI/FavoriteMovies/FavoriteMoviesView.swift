//
//  FavoriteMoviesView.swift
//  Movs
//
//  Created by Gabriel Reynoso on 26/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

protocol FavoriteMoviesViewDelegate: AnyObject {
    func favoriteMovies(_ sender: FavoriteMoviesView, unfavoriteMovieAt indexPath: IndexPath)
}

final class FavoriteMoviesView: UIView {
    
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
    
    private var removeFiltersButton:UIButton! {
        didSet {
            self.removeFiltersButton.backgroundColor = Colors.darkBlue.color
            self.removeFiltersButton.setTitleColor(Colors.mainYellow.color, for: .normal)
            self.removeFiltersButton.setTitle("Remove Filters", for: .normal)
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
    
    var movieItems:[FavoriteMoviesCell.Model] = [] {
        didSet { self.tableViewDataSource.items = self.movieItems }
    }
    
    weak var delegate:FavoriteMoviesViewDelegate?
    
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
//            self.tableView.tableHeaderView = nil
        case .filtered:
            self.feedbackView.isHidden = true
            self.tableView.isHidden = false
            self.tableView.sectionHeaderHeight = 80.0
//            self.tableView.tableHeaderView = self.removeFiltersButton
        }
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}

extension FavoriteMoviesView: ViewCode {
    
    func design() {
        self.backgroundColor = Colors.white.color
        self.tableView = FavoriteMoviesTableView(frame: .zero)
        self.removeFiltersButton = UIButton(frame: .zero)
        self.feedbackView = FeedbackView()
        self.refreshUIAcoordingToState()
    }
    
    func autolayout() {
        self.tableView.fillAvailableSpaceInSafeArea()
        self.feedbackView.fillAvailableSpaceInSafeArea()
    }
}

extension FavoriteMoviesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let unfavorite = UITableViewRowAction(style: .default,
                                              title: "Unfavorite")
        { [unowned self] _, indexPath in
            self.delegate?.favoriteMovies(self, unfavoriteMovieAt: indexPath)
        }
        return [unfavorite]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.state == .filtered {
            return self.removeFiltersButton
        } else {
            return nil
        }
    }
}
