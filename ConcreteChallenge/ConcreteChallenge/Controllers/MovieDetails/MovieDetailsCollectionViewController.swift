//
//  MovieDetailsCollectionViewController.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 25/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit
import ReSwift




class MovieDetailsCollectionViewController: UICollectionViewController {
    fileprivate let reuseIdentifier = "Cell"
    
    fileprivate let headerCellIdentifier = "MovieDetailsHeaderView"
    fileprivate let headerCellNibName = "MovieDetailsHeaderView"
    
    fileprivate let titleCellIdentifier = "MovieDetailsTitleCell"
    fileprivate let titleCellNibName = "MovieDetailsTitleCollectionViewCell"
    
    fileprivate let summaryCellIdentifier = "MovieDetailsSummaryCollectionViewCell"
    
    fileprivate let trailerCellIdentifier = "MovieDetailsTrailerCollectionViewCell"
    fileprivate let trailerCellNibName = "MovieDetailsTrailerCollectionViewCell"
    
    fileprivate let paddingHorizontal: CGFloat = 16
    fileprivate let paddingVertical: CGFloat = 8
    
    fileprivate var headerView: MovieDetailsHeaderView?
    
    fileprivate var movieDetails: MovieDetails?
    var movieId: Int?
    
    let bgColor = UIColor(asset: .brand)
    
    fileprivate var sizingHeaderCell: MovieDetailsTitleCollectionViewCell!
    fileprivate var sizingSummaryCell: MovieDetailsSummaryCollectionViewCell!
    fileprivate static let sizingTrailerCell = UINib(nibName: "MovieDetailsTrailerCollectionViewCell", bundle: nil).instantiate(withOwner: nil, options: nil).first! as! MovieDetailsTrailerCollectionViewCell
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionViewLayout()
        setupCollectionView()
        
        if let movieId = self.movieId {
            mainStore.dispatch(
                MovieThunk.fetchDetails(of: movieId)
            )
        }
        setNeedsStatusBarAppearanceUpdate()
    }
    
    fileprivate func setupCollectionView() {
        
//        self.collectionView!.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView!.contentInsetAdjustmentBehavior = .never
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView!.register(MovieDetailsTitleCollectionViewCell.self, forCellWithReuseIdentifier: titleCellIdentifier)
        
        self.collectionView!.register(MovieDetailsSummaryCollectionViewCell.self, forCellWithReuseIdentifier: summaryCellIdentifier)
        
        self.collectionView!.register(UINib(nibName: trailerCellNibName, bundle: nil), forCellWithReuseIdentifier: trailerCellIdentifier)
        
        self.collectionView!.register(
            UINib(nibName: headerCellNibName, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: headerCellIdentifier
        )
        
        self.collectionView!.backgroundColor = UIColor.white
    }
    
    fileprivate func setupCollectionViewLayout() {
        view.backgroundColor = .black
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: paddingVertical, left: paddingHorizontal, bottom: paddingVertical, right: paddingHorizontal)
            layout.minimumLineSpacing = 0
        }
    }

    fileprivate func updateUI() {
        guard let movieDetails = self.movieDetails else { return }
        
        if let headerView = self.headerView {
            headerView.setup(with: movieDetails)
        }
        
        if let posterPath = movieDetails.posterPath {
            let url = URL(string: Constants.env.imageBaseUrl)?
                .appendingPathComponent("w500")
                .appendingPathComponent(posterPath)

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
        collectionView.reloadData()
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.invalidateLayout()
        }
//        titleLabel.text = movieDetails.title
        
    }
    
    func setNavigationColor(_ color: UIColor) {
        navigationController?.navigationBar.barTintColor = color
        navigationController?.view.backgroundColor = color
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        headerView!.bluredView.alpha = 0.9 - (abs(contentOffsetY) * 0.001)
        if (contentOffsetY > 100) {
            restoreNavigationBar()
        } else {
            transparentNavigationBar()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellIdentifier, for: indexPath) as? MovieDetailsHeaderView
        
        if let movieDetails = movieDetails {
            headerView?.setup(with: movieDetails)
        }
        return headerView!
    }
    
    var currentStatusBarStyle: UIStatusBarStyle = .lightContent
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return currentStatusBarStyle
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 340)
    }
    
    
    private func restoreNavigationBar(isTranslucent: Bool = true) {
        currentStatusBarStyle = .darkContent
        setNeedsStatusBarAppearanceUpdate()
        let bgColor = UIColor(asset: .brand)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = isTranslucent
        navigationController?.navigationBar.tintColor = UIColor.darkGray

        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.backgroundColor = bgColor
        }
    }
    
    
    private func transparentNavigationBar() {
        currentStatusBarStyle = .lightContent
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.white
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.backgroundColor = UIColor.clear
            navigationItem.largeTitleDisplayMode = .never
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        transparentNavigationBar()
        
        mainStore.subscribe(self) { $0.select(MovieDetailsViewModel.init) }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Restore the navigation bar to default
        self.restoreNavigationBar(isTranslucent: false)
        
        mainStore.unsubscribe(self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleCellIdentifier, for: indexPath) as? MovieDetailsTitleCollectionViewCell
            
            if let movieDetails = movieDetails {
                cell?.setup(with: movieDetails)
            }
            
            return cell!
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: summaryCellIdentifier, for: indexPath) as? MovieDetailsSummaryCollectionViewCell
            
            if let movieDetails = movieDetails {
                cell?.setup(with: movieDetails)
            }
            
            return cell!
        
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trailerCellIdentifier, for: indexPath) as? MovieDetailsTrailerCollectionViewCell
            
            if let movieDetails = movieDetails {
                cell?.setup(with: movieDetails)
            }
            
            return cell!
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        }
        
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension MovieDetailsCollectionViewController: UICollectionViewDelegateFlowLayout {
 
    private func getHeight(of cell: UICollectionViewCell) -> CGFloat {
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
//            let cellSize = sizingCell.size(with: width)
        let cellSize = sizingHeaderCell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return cellSize.height + 20
    }
    
    private func getNibHeight(of cell: UICollectionViewCell, with movieDetails: MovieDetails, forWidth width: CGFloat) -> CGFloat {
        
        var fittingSize = UIView.layoutFittingCompressedSize
        fittingSize.width = width
        let size = cell.contentView.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)

        guard size.height > 100 else {
            return cell.contentView.frame.height
        }
        
        return size.height
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 2 * paddingHorizontal
        var height: CGFloat = 50
        
        if let movieDetails = self.movieDetails {

            if indexPath.row == 0 {
                if self.sizingHeaderCell == nil {
                    self.sizingHeaderCell = MovieDetailsTitleCollectionViewCell(frame: .zero)
                }
                sizingHeaderCell.setup(with: movieDetails)
                height = getHeight(of: sizingHeaderCell)
            }
            
            if indexPath.row == 2 {
                if self.sizingSummaryCell == nil {
                    self.sizingSummaryCell = MovieDetailsSummaryCollectionViewCell(frame: .zero)
                }
                sizingSummaryCell.setup(with: movieDetails)
                height = getHeight(of: sizingSummaryCell)
            }
                
            if indexPath.row == 1 {
//                MovieDetailsCollectionViewController.sizingTrailerCell.prepareForReuse()
//                MovieDetailsCollectionViewController.sizingTrailerCell.setNeedsLayout()
//                MovieDetailsCollectionViewController.sizingTrailerCell.setup(with: movieDetails)
//                MovieDetailsCollectionViewController.sizingTrailerCell.layoutIfNeeded()
                height = getNibHeight(
                    of: MovieDetailsCollectionViewController.sizingTrailerCell,
                    with: movieDetails,
                    forWidth: width
                ) + 20
            }
        }
        
        return .init(width: width, height: height)
    }
}


extension MovieDetailsCollectionViewController: StoreSubscriber {

    
    func newState(state: MovieDetailsViewModel) {
        
        let shouldUpdate = movieDetails == nil || movieDetails != state.details
        
        if shouldUpdate {
            movieDetails = state.details
            updateUI()
        }
    }
}
