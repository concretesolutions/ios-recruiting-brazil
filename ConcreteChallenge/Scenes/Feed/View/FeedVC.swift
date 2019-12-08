//
//  FeedVC.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit
import os.log
import Kingfisher

final class FeedVC: BaseViewController {
    
    // MARK: - Properties -
    var feedPresenter: FeedPresenter? {
        return presenter as? FeedPresenter
    }
    
    // MARK: View
    let feedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20.0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.width - 40) * ItemCollectionViewCell.imageAspect)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        return view
    }()
    
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        
        feedCollectionView.dataSource = self
        feedCollectionView.delegate = self
    }
    
    override func addSubviews() {
        view.addSubview(feedCollectionView)
    }
    
    override func setupConstraints() {
        feedCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.snp.topMargin)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }
}

extension FeedVC: FeedViewDelegate {
    
    func reloadFeed() {
        feedCollectionView.reloadData()
    }
}

extension FeedVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedPresenter?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell,
            let itemData = feedPresenter?.getItemData(item: indexPath.item)
        else {
            os_log("❌ - Unknown cell identifier %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
            fatalError("Unknown identifier")
        }
        
        // TODO: Implement favorite
        cell.titleLabel.text = itemData.title
        cell.filmImageView.kf.setImage(with: itemData.imageUrl)
        
        return cell
    }
}

extension FeedVC: UICollectionViewDelegate {
    
}
