//
//  MovieDetailView.swift
//  Movs
//
//  Created by Gabriel Reynoso on 29/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

protocol MovieDetailViewDelegate: AnyObject {
    func didFavoriteMovie(at sender:MovieDetailView)
    func didUnfavoriteMovie(at sender:MovieDetailView)
}

final class MovieDetailView: UIView {
    
    private let tableViewDataSourceDelegate = MovieDetailDataSourceDelegate()
    
    private var tableView:UITableView! {
        didSet {
            self.tableView.allowsSelection = false
            self.tableView.dataSource = self.tableViewDataSourceDelegate
            self.tableView.delegate = self.tableViewDataSourceDelegate
            self.addSubview(self.tableView)
        }
    }
    
    private var movieImageViewHolder:UIImageView?
    
    weak var delegate:MovieDetailViewDelegate?
    
    var movieDetail: MovieDetail! {
        didSet {
            self.presentMovieDetail()
        }
    }
    
    private func presentMovieDetail() {
        var cells = [UITableViewCell]()
        cells.append(self.createHeaderCell(text: self.movieDetail.title,
                                           buttoSelected: self.movieDetail.isFavorite))
        cells.append(self.createLabelCell(with: self.movieDetail.releaseYear))
        cells.append(self.createLabelCell(with: self.movieDetail.genreNames))
        cells.append(self.createLabelCell(with: self.movieDetail.overview, multipleLines: true))
        
        self.tableViewDataSourceDelegate.items = cells
        self.tableView.reloadData()
    }
    
    private func createHeaderCell(text:String, buttoSelected:Bool) -> UITableViewCell {
        
        // setup
        let imageView = UIImageView(image: nil)
        let label = UILabel(frame: .zero)
        let button = FavoriteButton()
        let cell = UITableViewCell()
        
        self.movieImageViewHolder = imageView
        ImageCache.global.getImage(for: self.movieDetail.w185PosterPath) { [weak self] img in
            self?.movieImageViewHolder?.image = img
            self?.movieImageViewHolder?.contentMode = .scaleAspectFit
        }
        
        label.text = text
        
        button.onFavorite = { [unowned self] _ in self.delegate?.didFavoriteMovie(at: self) }
        button.onUnfavorite = { [unowned self] _ in self.delegate?.didUnfavoriteMovie(at: self) }
        button.isSelected = buttoSelected
        
        // layout
        cell.addSubview(imageView)
        cell.addSubview(label)
        cell.addSubview(button)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 20.0).isActive = true
        imageView.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 20.0).isActive = true
        imageView.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -20.0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -10.0).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        label.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 15.0).isActive = true
        label.rightAnchor.constraint(equalTo: button.leftAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: 5.0).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalTo: label.heightAnchor, multiplier: 1.0).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1.0).isActive = true
        button.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        
        return cell
    }
    
    private func createLabelCell(with text:String, multipleLines:Bool = false) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = text
        if multipleLines {
            cell.textLabel?.numberOfLines = 0
            let f = cell.textLabel?.font.withSize(15.0)
            cell.textLabel?.font = f
        }
        return cell
    }
}

extension MovieDetailView: ViewCode {
    
    func design() {
        self.backgroundColor = Colors.white.color
        self.tableView = UITableView()
    }
    
    func autolayout() {
        self.tableView.fillAvailableSpaceInSafeArea()
    }
}
