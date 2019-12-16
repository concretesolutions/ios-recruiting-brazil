//
//  PopularsVC.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 15/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit
import os.log
import Kingfisher
import SnapKit

/// View controller to display the popular movies feed
final class PopularsVC: FeedVC {
    
    // MARK: - Properties -
    var popularsPresenter: PopularsPresenter? {
        return presenter as? PopularsPresenter
    }
    
    // MARK: Header
    internal let headerViewMaxHeight: CGFloat = 144
    internal let headerViewMinHeight: CGFloat = 86
    internal var headerViewHeightConstraint: Constraint?
    internal lazy var headerViewHeightConstant: CGFloat = self.headerViewMaxHeight
    
    // MARK: View
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

    internal var headerView: PopularsHeaderView = PopularsHeaderView()
    
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
        view.searchTextField.textColor = .black
        view.searchTextField.tintColor = Colors.tmdbGreen
        return view
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Methods -
    override func setupUI() {
        super.setupUI()
        
        scrollView.delegate = self
        searchBar.delegate = self
        
        let headerData = popularsPresenter?.getHeaderData()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - ScrollView Delegate -
extension PopularsVC {
    
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
        
        // Hide the keyboard if it's on the screen
        searchBar.endEditing(true)
    }
}

// MARK: - SearchBar Delegate -
extension PopularsVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        popularsPresenter?.searchMovie(searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            popularsPresenter?.searchMovie(searchText)
        }
    }
}
