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
import SnapKit

/// A basic View Controller to display a feed of movies
class FeedVC: BaseViewController, FavoriteViewDelegate {
    
    // MARK: - Properties -
    var feedPresenter: FeedPresenter? {
        return presenter as? FeedPresenter
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
    
    /// An activity indicator to show when the view is loading
    let activityIndicator: UIActivityIndicatorView = {
        let style: UIActivityIndicatorView.Style
        if #available(iOS 13.0, *) {
            style = .whiteLarge
        } else {
            // Fallback on earlier versions
            style = .gray
        }
        let view = UIActivityIndicatorView(style: style)
        view.hidesWhenStopped = true
        return view
    }()
    
    // MARK: - Init -
    override init(presenter: Presenter) {
        guard type(of: self) != FeedVC.self else {
            os_log("❌ - FeedVC instanciated directly", log: Logger.appLog(), type: .fault)
            fatalError(
                "Creating `FeedVC` instances directly is not supported. This class is meant to be subclassed."
            )
        }
        super.init(presenter: presenter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods -
    override func setupUI() {
        super.setupUI()

        view.backgroundColor = .white

        feedCollectionView.dataSource = self
        feedCollectionView.delegate = self
    }
    
    override func startLoading() {
        activityIndicator.startAnimating()
        feedCollectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
    }
    
    override func finishLoading() {
        activityIndicator.stopAnimating()
        feedCollectionView.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        feedPresenter?.updateData()
    }
    
    func setFavorite(_ isFavorite: Bool, tag: Int?) {
        guard let item = tag, let cell = feedCollectionView.cellForItem(at: IndexPath(item: item, section: 0)) as? ItemCollectionViewCell else {
            os_log("❌ - Unknown cell type %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
            return
        }
        cell.isFavorite = isFavorite
    }
    
    // MARK: Button methods
    @objc func favoriteTapped(_ sender: UIButton) {
        feedPresenter?.favoriteStateChanged(tag: sender.tag)
    }
}

// MARK: - Feed View Delegate -
extension FeedVC: FeedViewDelegate {
    
    func reloadFeed() {
        DispatchQueue.main.async { [weak self] in
            self?.feedCollectionView.reloadData()
        }
    }
    
    func resetFeedPosition() {
        self.feedCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
              at: .top,
        animated: true)
    }
}

// MARK: - CollectionView Data Source -
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
        cell.hideError()
        cell.favoriteButton.tag = indexPath.item
        cell.favoriteButton.addTarget(self, action: #selector(favoriteTapped(_:)), for: .touchUpInside)
        cell.titleLabel.text = itemData.title
        cell.filmImageView.kf.indicatorType = .activity
        if let imageURL = itemData.imageUrl {
            cell.filmImageView.kf.setImage(with: imageURL) { [weak cell] (result) in
                switch result {
                case .failure(let error):
                    cell?.displayError(.info("Image could not be downloaded"))
                    os_log("❌ - Image not downloaded %@", log: Logger.appLog(), type: .error, error.localizedDescription)
                default:
                    break
                }
            }
        } else {
            cell.filmImageView.kf.setImage(with: itemData.imageUrl)
            cell.displayError(.missing("No backdrop available 😭"))
        }
        cell.isFavorite = itemData.isFavorite
        
        return cell
    }
}

// MARK: - CollectionView Delegate -
extension FeedVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        feedPresenter?.selectItem(item: indexPath.item)
    }
}
