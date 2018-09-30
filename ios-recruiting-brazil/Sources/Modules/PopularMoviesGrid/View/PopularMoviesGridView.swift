//
//  PopularMoviesGridView.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class PopularMoviesGridView: UIViewController {
    
    // MARK: Private Variables
    private let disposeBag = DisposeBag()
    
    // MARK: Lazy variable
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: self.view.frame,
                                          collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        collection.backgroundColor = UIColor.white
        return collection
    }()
    
    private lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .gray)
        activity.center = self.view.center
        activity.hidesWhenStopped = true
        return activity
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewConfiguration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.view.backgroundColor = .red
    }
}

extension PopularMoviesGridView: ViewConfiguration {
    func buildViewHierarchy() {
        self.view.addSubview(self.collection)
        self.view.addSubview(self.activity)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.collection.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collection.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collection.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
