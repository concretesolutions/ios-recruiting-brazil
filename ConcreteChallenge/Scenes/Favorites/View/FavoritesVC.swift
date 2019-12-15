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

final class FavoritesVC: BaseViewController {
    
    // MARK: - Properties -
    var favoritesPresenter: FavoritesPresenter? {
        return presenter as? FavoritesPresenter
    }
    
    // MARK: View
    let feedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20.0
        layout.minimumInteritemSpacing = 20.0
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 15, right: 0)
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.width - 40) * ItemCollectionViewCell.imageAspect)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .white
        view.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        return view
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Methods -
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        title = "Favorites"
        
        feedCollectionView.dataSource = self
        feedCollectionView.delegate = self
    }
    
    override func addSubviews() {
        self.view.addSubview(feedCollectionView)
    }
    
    override func setupConstraints() {
        
        feedCollectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoritesPresenter?.loadFavorites()
    }
    
    // MARK: Button methods
    @objc func favoriteTapped(_ sender: UIButton) {
        favoritesPresenter?.favoriteStateChanged(tag: sender.tag)
    }
}

// MARK: - Feed View Delegate -
extension FavoritesVC: FeedViewDelegate {
    
    func reloadFeed() {
        DispatchQueue.main.async { [weak self] in
            self?.feedCollectionView.reloadData()
        }
    }
    
    func setFavorite(_ isFavorite: Bool, tag: Int?) {
        guard let item = tag, let cell = feedCollectionView.cellForItem(at: IndexPath(item: item, section: 0)) as? ItemCollectionViewCell else {
            // TODO: Log error
            return
        }
        cell.isFavorite = isFavorite
        reloadFeed()
    }
}

// MARK: - CollectionView Data Source -
extension FavoritesVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesPresenter?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell,
            let itemData = favoritesPresenter?.getItemData(item: indexPath.item)
        else {
            os_log("❌ - Unknown cell identifier %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
            fatalError("Unknown identifier")
        }

        cell.favoriteButton.tag = indexPath.item
        cell.favoriteButton.addTarget(self, action: #selector(favoriteTapped(_:)), for: .touchUpInside)
        cell.titleLabel.text = itemData.title
        cell.filmImageView.kf.indicatorType = .activity
        cell.filmImageView.kf.setImage(with: itemData.imageUrl)
        cell.isFavorite = itemData.isFavorite
        
        return cell
    }
}

// MARK: - CollectionView Delegate -
extension FavoritesVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        favoritesPresenter?.selectItem(item: indexPath.item)
    }
}

