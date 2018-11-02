//
//  MovieDetailView.swift
//  Movs
//
//  Created by Gabriel Reynoso on 29/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

protocol MovieDetailViewDelegate: AnyObject {
    func favoriteMovie(at sender:MovieDetailView)
    func unfavoriteMovie(at sender:MovieDetailView)
}

final class MovieDetailView: UIView {
    
    private let tableViewDataSource = MovieDetailDataSource()
    
    private var tableView:UITableView! {
        didSet {
            self.tableView.allowsSelection = false
            self.tableView.isScrollEnabled = false
            self.tableView.dataSource = self.tableViewDataSource
            self.addSubview(self.tableView)
        }
    }
    
    weak var delegate:MovieDetailViewDelegate?
    
    let data: Data
    
    init(data:Data) {
        self.data = data
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.data = aDecoder.decodeObject(forKey: "data") as! Data
        super.init(coder: aDecoder)
    }
    
    private func createHeaderCell(with image:UIImage, text:String, buttoSelected:Bool) -> UITableViewCell {
        
        // setup
        let imageView = UIImageView(image: nil)
        let label = UILabel(frame: .zero)
        let button = FavoriteButton()
        let cell = UITableViewCell()
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        label.text = text
        
        button.onFavorite = { _ in self.delegate?.favoriteMovie(at: self) }
        button.onUnfavorite = { _ in self.delegate?.unfavoriteMovie(at: self) }
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
    
    struct Data {
        let movieImage:UIImage
        let movieTitle:String
        let movieYear:String
        let movieGenre:String
        let movieDescription:String
        var isFavorite:Bool
    }
}

extension MovieDetailView: ViewCode {
    
    func design() {
        self.backgroundColor = Colors.white.color
        // cells
        var cells = [UITableViewCell]()
        cells.append(self.createHeaderCell(with: self.data.movieImage,
                                           text: self.data.movieTitle,
                                           buttoSelected: self.data.isFavorite))
        cells.append(self.createLabelCell(with: self.data.movieYear))
        cells.append(self.createLabelCell(with: self.data.movieGenre))
        cells.append(self.createLabelCell(with: self.data.movieDescription, multipleLines: true))
        
        self.tableViewDataSource.items = cells
        
        self.tableView = UITableView()
    }
    
    func autolayout() {
        self.tableView.fillAvailableSpaceInSafeArea()
    }
}
