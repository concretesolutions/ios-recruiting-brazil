//
//  FilterViewController.swift
//  Cineasta
//
//  Created by Tomaz Correa on 05/06/19.
//  Copyright (c) 2019 TCS. All rights reserved.
//

import UIKit

// MARK: - FILTER ACTION -
protocol FilterActionDelegate: NSObjectProtocol {
    func applyFilter(selectedFilters: [Genre])
}

class FilterViewController: UIViewController {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var filterCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    // MARK: - VARIABLES -
    private var presenter: FilterPresenter!
    private lazy var viewData = FilterViewData()
    public lazy var selectedFilters = [Genre]()
    public weak var delegate: FilterActionDelegate?
    
    // MARK: - IBACTIONS -
    @IBAction func closeFilterViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyFilter(_ sender: Any) {
        self.delegate?.applyFilter(selectedFilters: self.selectedFilters)
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - LIFE CYCLE -
extension FilterViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = FilterPresenter(viewDelegate: self)
        self.setupCollectionViewLayout()
        self.presenter.getGenres()
    }
}

// MARK: - PRESENTER -
extension FilterViewController: FilterViewDelegate {
    func showGenres(viewData: FilterViewData) {
        self.viewData = viewData
        self.filterCollectionView.reloadData()
    }
}

// MARK: - COLLECTIONVIEWDATASOURCE -
extension FilterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewData.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellNameID = "FilterCollectionViewCell"
        self.filterCollectionView.register(UINib(nibName: cellNameID, bundle: nil), forCellWithReuseIdentifier: cellNameID)
        let cell = self.filterCollectionView.dequeueReusableCell(withReuseIdentifier: cellNameID, for: indexPath) as! FilterCollectionViewCell
        let genreName = self.viewData.genres[indexPath.row].name
        cell.genreNameLabel.text = genreName
        cell.selectedGenre = self.selectedFilters.contains(where: {$0.name == genreName})
        cell.setupView()
        return cell
    }
}

// MARK: - COLLECTIONVIEWDELEGATE -
extension FilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell else { return }
        guard cell.selectedGenre else { self.addFilter(cell: cell, index: indexPath.row); return }
        self.removeFilter(cell: cell, index: indexPath.row)
    }
}

// MARK: - AUX METHODS -
extension FilterViewController {
    private func setupCollectionViewLayout() {
        self.filterCollectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.filterCollectionViewFlowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
    }
    
    private func addFilter(cell: FilterCollectionViewCell, index: Int) {
        cell.setupGenreSelected()
        let selectedGenre = self.viewData.genres[index]
        self.selectedFilters.append(selectedGenre)
    }
    
    private func removeFilter(cell: FilterCollectionViewCell, index: Int) {
        cell.setupGenreUnselected()
        let selectedGenre = self.viewData.genres[index]
        self.selectedFilters.removeAll(where: {$0.name == selectedGenre.name})
    }
}
