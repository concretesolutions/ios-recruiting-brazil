//
//  HomeInterface.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 30/10/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import UIKit

enum HomeInterfaceState {
    case normal
    case error
    case loading
}

class HomeInterface: StatusBarAnimatableViewController {
    
    lazy var manager = HomeManager(self)
    
    private var transition: CardTransition?
    
    //MARK: - Outlets
    @IBOutlet var gridCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gridCollectionViewSetup()
        
        self.manager.fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.gridCollectionView.reloadItems(at: self.gridCollectionView.indexPathsForVisibleItems)
    }
    
    func gridCollectionViewSetup() {
        self.gridCollectionView.delegate = self
        self.gridCollectionView.dataSource = self
        self.gridCollectionView.prefetchDataSource = self
        
        self.gridCollectionView.register(UINib(nibName: MovieCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCell.identifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDescriptionSegue" {
            if let movieDescriptionInterface = segue.destination as? MovieDescriptionInterface {
                if let index = sender as? Int {
                    movieDescriptionInterface.set(movie: self.manager.movieFor(index: index))
                }
            }
        }
    }
}

extension HomeInterface: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get tapped cell location
        let cell = collectionView.cellForItem(at: indexPath) as! MovieCell
        
        // Freeze highlighted state (or else it will bounce back)
        cell.freezeAnimations()
        
        // Get current frame on screen
        let currentCellFrame = cell.layer.presentation()!.frame
        
        // Convert current frame to screen's coordinates
        let cardPresentationFrameOnScreen = cell.superview!.convert(currentCellFrame, to: nil)
        
        // Get card frame without transform in screen's coordinates  (for the dismissing back later to original location)
        let cardFrameWithoutTransform = { () -> CGRect in
            let center = cell.center
            let size = cell.bounds.size
            let r = CGRect(
                x: center.x - size.width / 2,
                y: center.y - size.height / 2,
                width: size.width,
                height: size.height
            )
            return cell.superview!.convert(r, to: nil)
        }()
        
        
        let storyboard = UIStoryboard(name: "MovieDescription", bundle: nil)
        if let movieDescriptionInterface = storyboard.instantiateInitialViewController() as? MovieDescriptionInterface {
            movieDescriptionInterface.set(movie: self.manager.movieFor(index: indexPath.row))
            
            let params = CardTransition.Params(fromCardFrame: cardPresentationFrameOnScreen,
                                               fromCardFrameWithoutTransform: cardFrameWithoutTransform,
                                               fromCell: cell)
            
            transition = CardTransition(params: params)
            movieDescriptionInterface.transitioningDelegate = transition
            
            // If `modalPresentationStyle` is not `.fullScreen`, this should be set to true to make status bar depends on presented vc.
            movieDescriptionInterface.modalPresentationCapturesStatusBarAppearance = true
            movieDescriptionInterface.modalPresentationStyle = .custom
            
            present(movieDescriptionInterface, animated: true, completion: { [unowned cell] in
                // Unfreeze
                cell.unfreezeAnimations()
            })
        }
    }
}

extension HomeInterface: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.manager.numberOfMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
        
        if !isLoadingCell(for: indexPath) {
            let movie = self.manager.movieFor(index: indexPath.row)
            
            cell?.cardContentView.set(movie: movie)
            cell?.indexPath = indexPath
            cell?.delegate = self
        }
        
        
        return cell ?? UICollectionViewCell()
    }
}

extension HomeInterface: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.85 / 2, height: collectionView.frame.width * 0.85 / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.frame.width * 0.049
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.frame.width * 0.049
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let frame = collectionView.frame
        return UIEdgeInsets(top: frame.width * 0.05, left: frame.width * 0.05, bottom: frame.width * 0.05, right: frame.width * 0.05)
    }
}

extension HomeInterface: HomeInterfaceProtocol {
    func set(state: HomeInterfaceState) {
        
    }
    
    func reload(_ indexPath: [IndexPath]) {
        if indexPath.count > 0 {
            self.gridCollectionView.reloadItems(at: visibleIndexPathsToReload(interesecting: indexPath))
        } else {
           self.gridCollectionView.reloadData()
        }
    }
}


extension HomeInterface: MovieCellDelegate {
    func saveTapped(indexPath: IndexPath) {
        self.manager.handleMovie(indexPath: indexPath)
    }
}


extension HomeInterface: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            self.manager.fetchMovies()
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= self.manager.movies.count
    }
    
    func visibleIndexPathsToReload(interesecting indexPaths: [IndexPath] ) -> [IndexPath] {
        let indexPathsForVisibleItems = self.gridCollectionView.indexPathsForVisibleItems
        let indexPathsIntersection = Set(indexPathsForVisibleItems).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
