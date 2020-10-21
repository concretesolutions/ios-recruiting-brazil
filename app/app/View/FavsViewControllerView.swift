//
//  FavsViewControllerView.swift
//  app
//
//  Created by rfl3 on 21/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import UIKit

class FavsViewControllerView: UIView {

    // Components
    let searchBar = SearchBarView()

    let filterButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(systemName: "line.horizontal.3.decrease.circle"), for: .normal)
        view.backgroundColor = UIColor(named: "orange")
        view.tintColor = .white
        return view
    }()

    let backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(named: "orange")
        return view
    }()

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
        self.filterButton.addTarget(self, action: #selector(self.filterPressed(_:)), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func filterPressed(_ sender: UIButton) {

    }

}

extension FavsViewControllerView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.backgroundView)
        self.addSubview(self.collectionView)
        self.addSubview(self.searchBar)
        self.addSubview(self.filterButton)
    }

    func setupConstraints() {
        self.backgroundView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left)
            make.width.equalToSuperview()
            make.height.equalTo(44)
        }

        self.filterButton.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.left.equalTo(7)
            make.centerY.equalTo(self.backgroundView.snp.centerY)
        }

        self.searchBar.snp.makeConstraints { make in
            make.left.equalTo(self.filterButton.snp.right).offset(7)
            make.centerY.equalTo(self.backgroundView.snp.centerY)
            make.right.equalTo(self.backgroundView.snp.right).offset(-7)
            make.height.equalTo(40)
        }

        self.collectionView.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(self.backgroundView.snp.bottom)
        }
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
        self.searchBar.placeholder = "Not working :("
        self.searchBar.isUserInteractionEnabled = false
        self.filterButton.isEnabled = false
    }


}
