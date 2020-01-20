//
//  FavoritesView.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 15/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import Stevia
import UIKit

class FavoritesView: UIView {
    public let tableView = UITableView()
//    private var emptyView = EmptyView.init()
    
    init() {
        super.init(frame: .zero)
        subViews()
        style()
        autolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    public func changeBackground(to state: EmptyState) {
//        emptyView.changeEmptyView(toState: state)
//        tableView.backgroundView = emptyView
//    }
    
    private func subViews() {
        sv(tableView)
    }
    
    private func style() {
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.identifier)
        tableView.rowHeight = 200.00
        tableView.separatorStyle = .none
        tableView.backgroundColor = .primaryColor
    }
    
    private func autolayout() {
        tableView.fillContainer()
    }
    
}
