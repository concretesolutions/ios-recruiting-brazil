//
//  FavoriteMoviesView.swift
//  Movs
//
//  Created by Lucca Ferreira on 02/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit
import Combine
import SnapKit

class FavoriteMoviesView: UIView {
    
    // Publishers
    @Published var state: ExceptionView.State = .none
    
    // Cancellables
    private var tableViewStateCancellable: AnyCancellable?

    private let tableView: FavoritesTableView = {
        let tableView = FavoritesTableView()
        return tableView
    }()
    
    required init(forController controller: FavoriteMoviesViewController) {
        super.init(frame: .zero)
        self.setupTableView(withController: controller)
        self.setCombine()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView(withController controller: FavoriteMoviesViewController) {
        self.tableView.delegate = controller
        self.tableView.dataSource = controller
    }
    
    func reloadTableView() {
        if self.tableView.superview != nil {
            self.tableView.performBatchUpdates({
                self.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
            })
        }
    }
    
    private func setCombine() {
        self.tableViewStateCancellable = self.$state
            .assign(to: \.state, on: self.tableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupView()
    }

}

extension FavoriteMoviesView: ViewCode {

    func buildViewHierarchy() {
        self.addSubview(self.tableView)
    }

    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    func setupAdditionalConfiguration() {}

}
