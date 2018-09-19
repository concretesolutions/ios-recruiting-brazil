//
//  FavoriteCollectionManager.swift
//  Movs
//
//  Created by Lucas Ferraço on 19/09/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

protocol FavoriteCollectionManagerProtocol {
	func didFavoritedMovie(withId id: Int)
}

class FavoriteCollectionManager: NSObject {
	
	fileprivate let defaultPadding: CGFloat = 5.0
	
	private var data: [ListFavorites.FormattedMovieInfo] = []
	private var collectionView: UICollectionView!
	private var currentSection = 0
	
	public var delegate: FavoriteCollectionManagerProtocol?
	
	init(of collection: UICollectionView) {
		super.init()
		collection.register(FavoriteCollectionViewCell.nib, forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)
		collectionView = collection
	}
	
	//MARK:- Public Methods
	
	public func display(movies: [ListFavorites.FormattedMovieInfo]) {
		data = movies
		collectionView.reloadData()
	}
}

//MARK:- UICollectionViewDataSource

extension FavoriteCollectionManager: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return data.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as? FavoriteCollectionViewCell			 else {
			return UICollectionViewCell()
		}
		
		let currentMovieInfo = data[indexPath.row]
		movieCell.didFavoritedMovie = { id in
			// Updates the local object to persist when reloading the cell,
			// without having to reload the full collection.
			
			self.delegate?.didFavoritedMovie(withId: id)
		}
		movieCell.configure(with: currentMovieInfo)
		
		return movieCell
	}
}

//MARK:- UICollectionViewDelegateFlowLayout

extension FavoriteCollectionManager: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if UIDevice.current.userInterfaceIdiom == .phone, let layoutBounds = collectionViewLayout.collectionView?.bounds {
			if UIDevice.current.orientation == .portrait {
				return getProportionalSize(forWidth: layoutBounds.width - 40 - 2*defaultPadding)
			} else { // landscape
				return getProportionalSize(forHeight: layoutBounds.height - 2*defaultPadding)
			}
		}
		
		return MovieCollectionViewCell.preferredSize
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	}
}

//MARK:- Auxiliary Methods

extension FavoriteCollectionManager {
	fileprivate func getProportionalSize(forWidth width: CGFloat) -> CGSize {
		let multiplier = width / FavoriteCollectionViewCell.preferredSize.width
		return CGSize(width: width, height: FavoriteCollectionViewCell.preferredSize.height * multiplier)
	}
	
	fileprivate func getProportionalSize(forHeight height: CGFloat) -> CGSize {
		let multiplier = height / FavoriteCollectionViewCell.preferredSize.height
		return CGSize(width: FavoriteCollectionViewCell.preferredSize.width * multiplier, height: height)
	}
}

