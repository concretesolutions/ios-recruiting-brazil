//
//  GridViewControllerView.swift
//  app
//
//  Created by rfl3 on 20/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import UIKit

class GridViewControllerView: UIView {

    // Components
    let searchBar = SearchBarView()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GridViewControllerView: CodeView {
    func buildViewHierarchy() {

    }

    func setupConstraints() {

    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
    }

    
}
