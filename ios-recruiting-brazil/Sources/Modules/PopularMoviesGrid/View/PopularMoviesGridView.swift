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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .red
    }
}
