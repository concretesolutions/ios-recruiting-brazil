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

final class FeedVC: BaseViewController {
    
    // MARK: - Properties -
    var feedPresenter: FeedPresenter? {
        return presenter as? FeedPresenter
    }
    
    // MARK: Header
    internal let headerViewMaxHeight: CGFloat = 144
    internal let headerViewMinHeight: CGFloat = 86
    internal var headerViewHeightConstraint: Constraint?
    internal lazy var headerViewHeightConstant: CGFloat = self.headerViewMaxHeight
    
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
    
    internal var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = Colors.almostBlack
        return view
    }()

    internal var headerBackgroundView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.backgroundColor = Colors.almostBlack
        return view
    }()

    internal var headerView: FeedHeaderView = FeedHeaderView()
    
    internal lazy var auxiliarView: UIView = {
        let view = UIView()
        view.backgroundColor = self.feedCollectionView.backgroundColor
        return view
    }()
    
    internal lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.layer.cornerRadius = 23
        view.backgroundColor = .white
        view.tintColor = .white
        view.backgroundImage = UIImage()
        view.searchBarStyle = .prominent
        view.searchTextField.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Methods -
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        
        feedCollectionView.dataSource = self
        feedCollectionView.delegate = self
        scrollView.delegate = self
        
        let headerData = feedPresenter?.getHeaderData()
        headerView.callToActionLabel.text = headerData?.title
        headerView.headlineLabel.text = headerData?.greeting
        searchBar.placeholder = headerData?.searchBarPlaceholder
    }
    
    override func addSubviews() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(auxiliarView)
        self.scrollView.addSubview(feedCollectionView)
        self.scrollView.addSubview(headerBackgroundView)
        self.headerBackgroundView.addSubview(headerView)
        self.headerBackgroundView.addSubview(searchBar)
    }
    
    override func setupConstraints() {
        
        scrollView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        
        headerBackgroundView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            self.headerViewHeightConstraint = make.height.equalTo(self.headerViewMaxHeight).constraint
        }
        
        auxiliarView.snp.makeConstraints { (make) in
            make.edges.equalTo(headerBackgroundView)
        }
        
        headerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(searchBar.snp.top).offset(-15)
            make.height.equalTo(48)
        }
        
        searchBar.snp.makeConstraints { (make) in
            make.height.equalTo(46.0)
            make.leading.equalToSuperview().offset(20)
            make.trailing.bottom.equalToSuperview().offset(-20)
        }

        feedCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(headerBackgroundView.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        feedPresenter?.updateData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
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
    
    func setFavorite(_ isFavorite: Bool, tag: Int?) {
        guard let item = tag, let cell = feedCollectionView.cellForItem(at: IndexPath(item: item, section: 0)) as? ItemCollectionViewCell else {
            // TODO: Log error
            return
        }
        cell.isFavorite = isFavorite
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
extension FeedVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        feedPresenter?.selectItem(item: indexPath.item)
    }
}

// MARK: - ScrollView Delegate -
extension FeedVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y
        let oldViewHeight: CGFloat = headerViewHeightConstant
        let newHeaderViewHeight: CGFloat = headerViewHeightConstant - y
        // Progress of movement (to fade the username and image)
        let movementDistance: CGFloat = headerViewMaxHeight - headerViewMinHeight
        let progressPercentage: CGFloat = (newHeaderViewHeight - headerViewMinHeight)/movementDistance

        if newHeaderViewHeight > headerViewMaxHeight {
            headerViewHeightConstant = headerViewMaxHeight
        } else if newHeaderViewHeight < headerViewMinHeight {
            headerViewHeightConstant = headerViewMinHeight
        } else {
            headerViewHeightConstant = newHeaderViewHeight
            scrollView.contentOffset.y = 0 // block scroll view
        }

        // Update only when there is a change
        if headerViewHeightConstant != oldViewHeight {
            headerViewHeightConstraint?.update(offset: headerViewHeightConstant)
            // Fade the top labels
            UIView.performWithoutAnimation { [weak self] in
                self?.headerView.alpha = progressPercentage
            }
            self.view.animateConstraints()
        }
    }
}
