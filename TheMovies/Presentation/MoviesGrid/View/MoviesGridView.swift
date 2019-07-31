//
//  MoviesGridView.swift
//  ViperitTest
//
//  Created by Matheus Bispo on 7/25/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa

final class MoviesGridView: UIView {
    //MARK:- Views -
    private(set) var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(MoviesGridCell.self, forCellWithReuseIdentifier: "MoviesGridCell")
        return view
    }()
    
    private(set) var searchBar: UISearchBar = {
        let searchView = UISearchBar()
        searchView.searchBarStyle = UISearchBar.Style.minimal
        return searchView
    }()
    
    private(set) var offsetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private(set) var feedbackView = MoviesGridFeedbackView()
    
    //MARK:- Constructors -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- Override Methods -
    override func didMoveToWindow() {
        super.didMoveToWindow()
        setupConstraints()
    }
    
    //MARK:- Methods -
    fileprivate func setupUIElements() {
        // arrange subviews
        backgroundColor = .white
        
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        
        self.addSubview(collectionView)
        self.addSubview(searchBar)
        self.addSubview(feedbackView)
        self.searchBar.insertSubview(offsetView, at: 0)
    }
    
    fileprivate func setupConstraints() {
        let guide = self.safeAreaLayoutGuide
        searchBar.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.right.equalTo(guide).inset(10)
            ConstraintMaker.top.equalTo(guide).inset(-10)
        }
        
        offsetView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.width.equalTo(searchBar)
            ConstraintMaker.height.equalTo(searchBar).offset(10)
            
        }
        
        collectionView.snp.makeConstraints {
            (ConstraintMaker) in
            
            ConstraintMaker.bottom.left.right.equalTo(guide)
            ConstraintMaker.top.equalTo(searchBar.snp.bottom).inset(10)
        }
        
        feedbackView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.top.bottom.right.equalTo(collectionView)
        }
        
    }
}

extension MoviesGridView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = width/2.3
        return CGSize(width: cellWidth, height: cellWidth / 0.75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
