//
//  MovieDetailsCollectionViewController.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 25/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit
import ReSwift

class MovieDetailsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    fileprivate let reuseIdentifier = "Cell"
    
    fileprivate let headerCellIdentifier = "MovieDetailsHeaderView"
    fileprivate let headerCellNibName = "MovieDetailsHeaderView"
    
    fileprivate let titleCellIdentifier = "MovieDetailsTitleCell"
    fileprivate let titleCellNibName = "MovieDetailsTitleCollectionViewCell"
    
    fileprivate let summaryCellIdentifier = "MovieDetailsSummaryCollectionViewCell"
    
    fileprivate let trailerCellIdentifier = "MovieDetailsTrailerCollectionViewCell"
    fileprivate let trailerCellNibName = "MovieDetailsTrailerCollectionViewCell"
    
    fileprivate var headerView: MovieDetailsHeaderView?
    
    fileprivate var sections: [MovieDetailsSection] = []
    fileprivate var headerSection: MovieDetailsHeaderSection?
    fileprivate var posterUrl: URL?
    fileprivate var favorited: Bool = false
    
    var movieId: Int?
    
    let bgColor = UIColor(asset: .brand)
    
    var favoriteButon: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupCollectionViewLayout()
        setupCollectionView()
        
        if let movieId = self.movieId {
            mainStore.dispatch(
                MovieThunk.fetchDetails(of: movieId)
            )
        }
    }
    
    fileprivate func setupNavigationBar() {
        self.favoriteButon = UIBarButtonItem(
            image: Constants.theme.heart,
            style: .plain,
            target: nil,
            action: nil
        )
        self.favoriteButon.isEnabled = false
        self.navigationItem.rightBarButtonItems = [self.favoriteButon]
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = UIColor.darkGray
        navigationController?.navigationBar.isTranslucent = true
    }
    
    fileprivate func setupCollectionView() {
        
        self.collectionView!.contentInsetAdjustmentBehavior = .never
        
        // Section Cells
        self.collectionView!.register(MovieDetailsTitleCollectionViewCell.self, forCellWithReuseIdentifier: titleCellIdentifier)
        self.collectionView!.register(MovieDetailsSummaryCollectionViewCell.self, forCellWithReuseIdentifier: summaryCellIdentifier)
        self.collectionView!.register(MovieDetailsTrailerCollectionViewCell.self, forCellWithReuseIdentifier: trailerCellIdentifier)
        
        
        self.collectionView!.register(
            UINib(nibName: headerCellNibName, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: headerCellIdentifier
        )
        
        self.collectionView!.backgroundColor = UIColor.white
    }
    
    fileprivate func setupCollectionViewLayout() {
        view.backgroundColor = .black
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.sectionInset = .init(
                top: Constants.theme.paddingVertical,
                left: Constants.theme.paddingHorizontal,
                bottom: Constants.theme.paddingVertical,
                right: Constants.theme.paddingHorizontal
            )
            flowLayout.minimumLineSpacing = 0
            flowLayout.estimatedItemSize = CGSize(
                width: view.frame.width - 2 * Constants.theme.paddingHorizontal,
                height: 100
            )
        }
    }

    fileprivate func updateUI() {
        guard !sections.isEmpty else { return }
        
        if let headerView = self.headerView, let headerSection = self.headerSection {
            headerView.setup(with: headerSection)
        }
        
        if let url = posterUrl {

            let bgImage = UIImageView(frame: view.bounds)
            view.addSubview(bgImage)
            view.sendSubviewToBack(bgImage)
            view.clipsToBounds = true
            self.collectionView!.backgroundColor = UIColor.clear
            
            bgImage.contentMode = .scaleAspectFill
            bgImage.fillSuperview()
            _ = bgImage.blurred(style: .extraLight)
            bgImage.sd_setImage(
                with: url,
                placeholderImage: UIImage(named: "placeholder.png")
            )
        }
        
        if favorited {
            self.favoriteButon.image = Constants.theme.heartFull
        } else {
            self.favoriteButon.image = Constants.theme.heart
        }
        
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.invalidateLayout()
        }
        
        collectionView.reloadData()
        
//        titleLabel.text = movieDetails.title
        
    }
    
    func setNavigationColor(_ color: UIColor) {
        navigationController?.navigationBar.barTintColor = color
        navigationController?.view.backgroundColor = color
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        headerView!.bluredView.alpha = 0.9 - (abs(contentOffsetY) * 0.001)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellIdentifier, for: indexPath) as? MovieDetailsHeaderView
        if let headerSection = self.headerSection {
            headerView?.setup(with: headerSection)
        }
        
        return headerView!
    }
    
    var currentStatusBarStyle: UIStatusBarStyle = .lightContent
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return currentStatusBarStyle
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 340)
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self) { $0.select(MovieDetailsViewModel.init) }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainStore.unsubscribe(self)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = sections[indexPath.row]
        
        switch section.type {
        case .title:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleCellIdentifier, for: indexPath) as? MovieDetailsTitleCollectionViewCell
            
            cell?.setup(with: section as! MovieDetailTitleSection)
            
            return cell!
        case .summary:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: summaryCellIdentifier, for: indexPath) as? MovieDetailsSummaryCollectionViewCell
            
            cell?.setup(with: section as! MovieDetailsSummarySection)
            
            return cell!
        
        case .trailer:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trailerCellIdentifier, for: indexPath) as? MovieDetailsTrailerCollectionViewCell
            
            cell?.setup(with: section as! MovieDetailsTrailerSection)
            
            return cell!
        default:
            fatalError("Error trying to render unknown section type in collectionview")
        }
        
    }

}

extension MovieDetailsCollectionViewController: StoreSubscriber {

    
    func newState(state: MovieDetailsViewModel) {
        sections = state.sections
        headerSection = state.header
        favorited = state.favorited
        posterUrl = state.posterUrl
        
        favoriteButon.target = state.details
        favoriteButon.action = #selector(state.details?.toggleFavorite)
        favoriteButon.isEnabled = true
        
        updateUI()
    }
}
