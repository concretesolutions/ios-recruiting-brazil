//
//  PopularMoviesView.swift
//  Movs
//
//  Created by Lucca Ferreira on 02/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit
import Combine

class PopularMoviesView: UIView {
    
    // Publishers
    @Published var state: ExceptionView.State = .none
    
    // Cancellables
    private var collectionViewStateCancellable: AnyCancellable?

    private let collectionView: PopularMoviesCollectionView = {
        let collectionView = PopularMoviesCollectionView(itemsPerRow: 2, withMargin: 16.0)
        return collectionView
    }()
    
    required init(forController controller: PopularMoviesViewController) {
        super.init(frame: .zero)
        self.setupView()
        self.setupCollectionView(withController: controller)
        self.setCombine()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView(withController controller: PopularMoviesViewController) {
        self.collectionView.delegate = controller
        self.collectionView.dataSource = controller
        self.collectionView.prefetchDataSource = controller
    }
    
    func reloadCollectionView() {
        self.collectionView.performBatchUpdates({
            self.collectionView.reloadSections(IndexSet(integer: 0))
        })
    }
    
    private func setCombine() {
        self.collectionViewStateCancellable = self.$state
            .assign(to: \.state, on: self.collectionView)
    }

}

extension PopularMoviesView: ViewCode {

    func buildViewHierarchy() {
        self.addSubview(collectionView)
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    func setupAdditionalConfiguration() {}
    
}
