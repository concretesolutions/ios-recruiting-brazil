//
//  HomeInterface.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 30/10/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import UIKit

class HomeInterface: UIViewController {
    
    //MARK: - Status Bar Config
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    var isStatusBarHidden: Bool = false
    override var prefersStatusBarHidden: Bool {
        return self.isStatusBarHidden
    }
    
    //MARK: - Outlets
    @IBOutlet var gridCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gridCollectionViewSetup()
    }
    
    func gridCollectionViewSetup() {
        self.gridCollectionView.delegate = self
        self.gridCollectionView.dataSource = self
        
        self.gridCollectionView.register(UINib(nibName: MovieCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCell.identifier)
    }
}

extension HomeInterface: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MovieCell else {
            return
        }
        
        cell.freezeAnimations()
        
        guard let currentCellFrame = cell.layer.presentation()?.frame else {
            return
        }
        
        let cardPresentationFrameOnScreen = cell.superview?.convert(currentCellFrame, to: nil)
        
        let cardFrameWithoutTransform = { () -> CGRect in
            let center = cell.center
            let size = cell.bounds.size
            let rect = CGRect(x: center.x - size.width / 2,
                              y: center.y - size.height / 2,
                              width: size.width,
                              height: size.height)
            
            guard let superview = cell.superview else {
                return .zero
            }
            
            return superview.convert(rect, to: nil)
        }
        
        // Set up card detail view controller
        let vc = storyboard!.instantiateViewController(withIdentifier: "MovieDescription") as! MovieDescriptionInterface
        vc.cardViewModel = cardModel.highlightedImage()
        
        vc.unhighlightedCardViewModel = cardModel // Keep the original one to restore when dismiss
        let params = CardTransition.Params(fromCardFrame: cardPresentationFrameOnScreen,
                                           fromCardFrameWithoutTransform: cardFrameWithoutTransform,
                                           fromCell: cell)
        transition = CardTransition(params: params)
        vc.transitioningDelegate = transition
        
        // If `modalPresentationStyle` is not `.fullScreen`, this should be set to true to make status bar depends on presented vc.
        vc.modalPresentationCapturesStatusBarAppearance = true
        vc.modalPresentationStyle = .custom
        
        present(vc, animated: true, completion: { [unowned cell] in
            // Unfreeze
            cell.unfreezeAnimations()
        })
    }
}

extension HomeInterface: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath)
        
        
        return cell
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
