//
//  MovieDetailOverviewViewController.swift
//  DataMovie
//
//  Created by Andre Souza on 03/09/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class MovieDetailOverviewViewController: UIViewController {
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    //Genre
    @IBOutlet weak var genreViewStackView: UIStackView!
    @IBOutlet weak var genreViewLabel: UILabel!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    //Plot
    @IBOutlet weak var plotStackView: UIStackView!
    @IBOutlet weak var plotTitleLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    //Cast
    @IBOutlet weak var castStackView: UIStackView!
    @IBOutlet weak var castTtitleLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var castExpandButton: UIButton!
    @IBOutlet weak var castCollectionviewHeight: NSLayoutConstraint!
    
    //Status
    @IBOutlet weak var statusStackView: UIStackView!
    @IBOutlet weak var statusTitleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    //Release
    @IBOutlet weak var releaseStackView: UIStackView!
    @IBOutlet weak var releaseTitleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    
    //Original Title
    @IBOutlet weak var originalTitleStackView: UIStackView!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var originalTitle: UILabel!
    
    //Original Language
    @IBOutlet weak var originalLanguageStackView: UIStackView!
    @IBOutlet weak var originalLanguageTitleLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    
    //Budget
    @IBOutlet weak var budgetStackView: UIStackView!
    @IBOutlet weak var budgetTitleLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    
    //Revenue
    @IBOutlet weak var revenueStackView: UIStackView!
    @IBOutlet weak var revenueTitleLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    
    //Homepage
    @IBOutlet weak var homePageStackView: UIStackView!
    @IBOutlet weak var homePageTitleLabel: UILabel!
    @IBOutlet weak var homePageButton: UIButton!
    
    private lazy var castCollectionViewCollapsedHeight: CGFloat = 90
    private lazy var castCollectionViewExpandedHeight: CGFloat = 290
    private lazy var castCollectionMinimumCountToExpand: Int = 12
    
    var presenter: MovieDetailPresenterInterface?
    
    class func newInstance() -> MovieDetailOverviewViewController {
        let storyboard = UIStoryboard(type: .movieDetail)
        let overViewVC = storyboard.instantiateViewController(ofType: MovieDetailOverviewViewController.self)
        return overViewVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    @IBAction func touchHomePageButton(_ sender: Any) {
        presenter?.touchHomepage()
    }
    
    @IBAction func touchExpandCastCollectionview(_ sender: Any) {
        animateExpandCastCollection()
    }
   
}

extension MovieDetailOverviewViewController {
    
    private func initialSetup() {
        view.backgroundColor = .clear
        showInformation()
    }
    
    private func setupCollectionView() {
        setupGenreCollectionView()
        setupCastCollectionView()
    }
    
    private func setupGenreCollectionView() {
        genreCollectionView.register(MovieGenreCollectionViewCell.self)
        if let flowLayout = genreCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
        genreCollectionView.reloadData()
    }
    
    private func setupCastCollectionView() {
        castCollectionView.register(PersonCollectionViewCell.self)
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.reloadData()
    }
    
}

//MARK: - Animations -

extension MovieDetailOverviewViewController {
    
    private func animateExpandCastCollection() {
        let isExpanding = (castCollectionviewHeight.constant == castCollectionViewCollapsedHeight)
        UIView.animate(withDuration: 0.4,  delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [.curveEaseInOut], animations: {
            let expandTitle = isExpanding ? "Close" : "Expand"
            self.castExpandButton.setTitle(expandTitle, for: .normal)
            self.castExpandButton.imageView?.transform = isExpanding ? CGAffineTransform(rotationAngle: .pi) : CGAffineTransform.identity
            self.castCollectionviewHeight.constant = isExpanding ? self.castCollectionViewExpandedHeight : self.castCollectionViewCollapsedHeight
            self.view.layoutIfNeeded()
        })
    }
    
}

//MARK: - UICollectionViewDelegate -

extension MovieDetailOverviewViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.contentView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.contentView.transform = CGAffineTransform.identity
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == castCollectionView {
            navigationController?.delegate = nil
            let cell = castCollectionView.cellForItem(at: indexPath) as! PersonCollectionViewCell
            presenter?.didSelectCast(at: indexPath, cacheImage: cell.pictureImageView.image)
        }
    }
    
}

// MARK: - UICollectionViewDataSource -

extension MovieDetailOverviewViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == genreCollectionView {
            return presenter?.numberOfGenre() ?? 0
        } else {
            return presenter?.numberOfCast() ?? 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == genreCollectionView {
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as MovieGenreCollectionViewCell
            cell.genre = presenter?.genre(at: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as PersonCollectionViewCell
            cell.person = presenter?.person(at: indexPath)
            presenter?.loadPersonPicture(cell.pictureImageView, at: indexPath)
            return cell
        }
    }
    
}

// MARK: - MovieDetailSubViewInterface -

extension MovieDetailOverviewViewController: MovieDetailOverviewInterface {
    
    var viewController: UIViewController {
        return self
    }
    
    func showInformation() {
        plotLabel.text = presenter?.movieEntity.overview ?? "--"
        
        if (presenter?.numberOfGenre() ?? 0) == 0 {
            genreViewStackView.isHidden = true
        }
        
        let castCount = presenter?.numberOfCast() ?? 0
        if castCount == 0 {
            castStackView.isHidden = true
        } else {
            castExpandButton.isHidden = (castCount < castCollectionMinimumCountToExpand)
        }
        
        statusLabel.text = presenter?.movieEntity.status ?? "--"
        releaseLabel.text = presenter?.movieEntity.releaseDate ?? "--"
        originalTitle.text = presenter?.movieEntity.originalTitle ?? "--"
        originalLanguageLabel.text = presenter?.movieEntity.originalLanguage ?? "--"
        budgetLabel.text = presenter?.movieEntity.budget ?? "--"
        revenueLabel.text = presenter?.movieEntity.revenue ?? "--"
        
        if let homepage = presenter?.movieEntity.homepage {
            let titleAttr: [NSAttributedString.Key : Any] = [.font: UIFont(type: .regular, size: 15),
                                                            .foregroundColor: UIColor.white,
                                                            .underlineStyle: 1]
            let buttonTitleAttr = NSMutableAttributedString(string: homepage, attributes: titleAttr)
            homePageButton.setAttributedTitle(buttonTitleAttr, for: .normal)
        } else {
            homePageStackView.isHidden = true
        }
        
        setupCollectionView()
    }

}
