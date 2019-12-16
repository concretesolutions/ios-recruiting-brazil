//
//  FavoritesVC.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 15/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit
import os.log
import Kingfisher
import SnapKit

final class FavoritesVC: FeedVC {
    
    // MARK: - Properties -
    var favoritesPresenter: FavoritesPresenter? {
        return presenter as? FavoritesPresenter
    }
    
    // MARK: View
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Methods -
    override func setupUI() {
        super.setupUI()
        
        title = "Favorites"
    }
    
    override func addSubviews() {
        self.view.addSubview(feedCollectionView)
    }
    
    override func setupConstraints() {
        
        feedCollectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    override func setFavorite(_ isFavorite: Bool, tag: Int?) {
        guard let item = tag, let cell = feedCollectionView.cellForItem(at: IndexPath(item: item, section: 0)) as? ItemCollectionViewCell else {
            os_log("❌ - Unknown cell type %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
            return
        }
        cell.isFavorite = isFavorite
        if !isFavorite {
            let indexPath = IndexPath(item: item, section: 0)
            self.feedCollectionView.performBatchUpdates({ [weak self] in
                self?.feedCollectionView.deleteItems(at: [indexPath])
            }) { [weak self] (_) in
                self?.reloadFeed()
            }
        }
    }
}
