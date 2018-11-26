//
//  MoviesViewController.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 17/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

class MoviesViewController: UICollectionViewController {

    enum Status {
        case normal
        case empty
        case didNotFoundAnyMovie
        case error
    }
    
    // MARK: - Outlets
    @IBOutlet var outletLoadingView: UIView!
    
    // MARK: - Properties
    // MARK: Private
    private var status:Status = .normal {
        didSet{
            switch self.status {
            case .normal:
                self.collectionView.backgroundView = nil
            case .empty:
                self.collectionView.backgroundView = self.view(with: #imageLiteral(resourceName: "check_icon"), and: "Filme aparecendo")
            case .didNotFoundAnyMovie:
                self.collectionView.backgroundView = self.view(with: #imageLiteral(resourceName: "favorite_gray_icon"), and: "Nenhum filme encontrado")
            case .error:
                self.collectionView.backgroundView = self.view(with: #imageLiteral(resourceName: "favorite_full_icon"), and: "😱")
            }
        }
    }
    
    // MARK: Public
    var presenter: MoviesPresenter!
    
    var isLoading: Bool = false {
        didSet {
            self.set(isLoading: self.isLoading)
        }
    }
    
    // MARK: - UICollectionViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLayout()
        self.setupRefreshControl()
        
        self.presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter.viewWillAppear()
    }
    
    // MARK: - Functions
    // MARK: Private
    private func setupRefreshControl(){
        let refresh = UIRefreshControl()
        refresh.addTarget(self.presenter, action: #selector(MoviesPresenter.reload), for: .valueChanged)
        refresh.tintColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        self.collectionView?.refreshControl = refresh
    }
    
    private func setupLayout() {
        self.title = "Popular"
    }
    
    private func view(with image:UIImage, and message:String) -> UIView {
        let theView = UIView(frame: self.view.frame)
        theView.translatesAutoresizingMaskIntoConstraints = false
        theView.backgroundColor = .white
        theView.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        theView.heightAnchor.constraint(equalToConstant: self.view.bounds.height).isActive = true
        
        let theUIImageView = UIImageView(frame: CGRect.zero)
        theUIImageView.image = image
        
        let theLabel = UILabel(frame: CGRect.zero)
        theLabel.text = message
        theLabel.textAlignment = .center
        
        let theStackView = UIStackView(arrangedSubviews: [theUIImageView,theLabel])
        theStackView.translatesAutoresizingMaskIntoConstraints = false
        theStackView.axis = .vertical
        theStackView.distribution = .equalSpacing
        theStackView.alignment = .fill
        theStackView.spacing = 8
        
        //
        theView.addSubview(theStackView)
        
        // - Constraints
        
        //UIImageView
        theUIImageView.heightAnchor.constraint(equalTo: theView.heightAnchor, multiplier: 0.3).isActive = true
        theUIImageView.widthAnchor.constraint(equalTo: theUIImageView.heightAnchor, multiplier: 1.0).isActive = true
        
        //UILabel
        theStackView.centerYAnchor.constraint(equalTo: theView.centerYAnchor).isActive = true
        theStackView.centerXAnchor.constraint(equalTo: theView.centerXAnchor).isActive = true
        
        //
        return theView
    }
    
    // MARK: Public
    func set(isLoading:Bool) {
        if isLoading {
            self.collectionView?.backgroundView = self.outletLoadingView
        }else{
            self.collectionView?.backgroundView = nil
        }
    }
    
    func set(status:Status) {
        self.status = status
    }
    
    
    // MARK: - UICollectionDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItemsInSection = self.presenter.collectionView(collectionView, numberOfItemsInSection: section)
        
        return numberOfItemsInSection
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.presenter.collectionView(collectionView, cellForItemAt: indexPath)
        
        return cell
    }
    
    // MARK: - UICollectionDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.collectionView(collectionView, didSelectItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.presenter.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let movieCell = cell as? MovieCollectionViewCell else {
            Logger.log(in: self, message: "Could not cast cell:\(cell) to MovieCollectionViewCell")
            return
        }
        
        movieCell.cleanData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = self.presenter.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewFlowLayout
extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = self.view.bounds
        
        return CGSize(width: bounds.width*0.425, height: bounds.height*0.35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        let bounds = self.view.bounds.width
        
        return bounds*0.025
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let bounds = self.view.bounds.width
        let spacing = bounds*0.05
        
        return UIEdgeInsets(top: spacing,
                            left: spacing,
                            bottom: spacing,
                            right: spacing)
    }
    
}
