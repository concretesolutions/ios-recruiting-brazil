//
//  SearchBarView.swift
//  app
//
//  Created by rfl3 on 15/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import UIKit

class SearchBarView: UISearchBar {
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchBarView: CodeView {
    func buildViewHierarchy() {

    }

    func setupConstraints() {

    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = UIColor(named: "orange")
        self.searchTextField.backgroundColor = .white
        self.placeholder = "Search by title"
    }


}
