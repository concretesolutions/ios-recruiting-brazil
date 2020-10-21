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

    let collectionView: GridCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: screenWidth / 2.3,
                                 height: (340 / (230 * 2.3)) * screenWidth)

        let view = GridCollectionView(frame: .zero, collectionViewLayout: layout)
        view.contentInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)

        return view
    }()

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
        self.addSubview(self.searchBar)
        self.addSubview(self.collectionView)
    }

    func setupConstraints() {
        self.searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(44)
        }

        self.collectionView.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(self.searchBar.snp.bottom)
        }
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
    }

    
}
