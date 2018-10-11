//
//  MovieListCellDetailViewController.swift
//  DataMovie
//
//  Created by Andre Souza on 27/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit
import AlamofireImage
import ChameleonFramework

protocol DiscoverMovieDetailProtocol {
    func discoverItem(at indexPath: IndexPath) -> DiscoverItemListView?
    func addMovie(indexPath: IndexPath)
    var movieListCellDetailViewProtocol: MovieListCellDetailViewProtocol? { get set }
}

protocol MovieListCellDetailViewProtocol {
    func updateButtonStatus(_ status: DMButtonStatus)
}

class MovieListCellDetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var addMovieButton: DMButton!
    
    var addProtocol: DiscoverMovieDetailProtocol!
    var indexPath: IndexPath!
    
    class func newInstance(addProtocol: DiscoverMovieDetailProtocol, indexPath: IndexPath) -> MovieListCellDetailViewController {
        let movieListCellDetailVC = MovieListCellDetailViewController(nibName: MovieListCellDetailViewController.identifier, bundle: nil)
        movieListCellDetailVC.addProtocol = addProtocol
        movieListCellDetailVC.addProtocol.movieListCellDetailViewProtocol = movieListCellDetailVC
        movieListCellDetailVC.indexPath = indexPath
        return movieListCellDetailVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        showDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavbarTransparent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchAddMovieButton(_ sender: Any) {
        addMovieButton.showStatus(.loading)
        addProtocol?.addMovie(indexPath: indexPath)
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        let addAction = UIPreviewAction(title: "Add movie", style: .default) { (action, viewController) -> Void in
            self.addProtocol?.addMovie(indexPath: self.indexPath)
        }
        
        let cancelAction = UIPreviewAction(title: "Cancelar", style: .default) { (action, viewController) -> Void in
        }
        
        return [addAction, cancelAction]
    }

}

extension MovieListCellDetailViewController {
    
    private func showDetail() {
        guard let item = addProtocol?.discoverItem(at: indexPath) else { return }
        if let posterPath = item.posterPath,
            !posterPath.isEmpty,
            let url = URL(string: TMDBUrl.image(.w200, posterPath).url) {
            posterImage.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "ic_place_holder"), completion: { response in
                guard let image = response.result.value else {
                    return
                }
                self.customizeColors(with: image)
            })
            backgroundImageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "ic_place_holder"))
        } else {
            posterImage.image = #imageLiteral(resourceName: "ic_place_holder")
        }

        titleLabel.text = item.title
        if let releaseDate = item.releaseDate, !releaseDate.isEmpty {
            dateLabel.text = Date(dateString: releaseDate)?.stringFormat()
        } else {
            dateLabel.isHidden = true
        }

        addMovieButton.showStatus(item.buttonStatus)
        overViewLabel.text = item.overview
    }
    
    private func customizeColors(with image: UIImage) {
        let averageColor = AverageColorFromImage(image)
        let contrastColor = ContrastColorOf(averageColor, returnFlat: true)
        addMovieButton.fillColor = averageColor
        addMovieButton.setTitleColor(contrastColor, for: .normal)
        addMovieButton.tintColor = contrastColor
    }
    
}

extension MovieListCellDetailViewController: MovieListCellDetailViewProtocol {
    
    func updateButtonStatus(_ status: DMButtonStatus) {
        addMovieButton.showStatus(status)
    }
    
}
