//
//  MoviesSearchController.swift
//  Movs
//
//  Created by Gabriel Reynoso on 02/11/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class MoviesSearchViewController: UITableViewController {
    
    var searchResults:[Movie] = [] {
        didSet {
            if self.searchResults.count > 0 {
                self.showBackground()
            } else {
                self.hideBackground()
            }
            self.tableView.reloadData()
        }
    }
    
    var didSelectorRowAt: ((IndexPath) -> Void)?
    
    init() {
        super.init(style: .plain)
        self.commonInit()
    }
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.tableView = UITableView()
        self.tableView.register(Cell.self, forCellReuseIdentifier: Cell.identifier)
    }
    
    func hideBackground() {
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
    }
    
    func showBackground() {
        self.tableView.backgroundColor = Colors.white.color
        self.tableView.separatorStyle = .singleLine
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectorRowAt?(indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        
        cell.setupView()
        cell.configure(movie: self.searchResults[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    final class Cell:UITableViewCell,ReusableViewCode {
        static let identifier = "Cell"
        
        private var movieImageView:UIImageView! {
            didSet {
                self.movieImageView.contentMode = .scaleAspectFill
                self.addSubview(self.movieImageView)
            }
        }
        
        private var movieTitleLabel:UILabel! {
            didSet {
                self.addSubview(self.movieTitleLabel)
            }
        }
        
        var settedUp: Bool = false
        
        func configure(movie:Movie) {
            self.movieTitleLabel.text = movie.title
            self.setMovieImageView(image: nil)
            ImageCache.global.getImage(for: movie.w92PosterPath) { [weak self] img in
                self?.setMovieImageView(image: img)
            }
        }
        
        func setMovieImageView(image:UIImage?) {
            self.movieImageView.image = image
        }
        
        func design() {
            self.clipsToBounds = true
            self.movieImageView = UIImageView()
            self.movieTitleLabel = UILabel()
        }
        
        func autolayout() {
            
            self.movieImageView.translatesAutoresizingMaskIntoConstraints = false
            self.movieImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            self.movieImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.movieImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            self.movieImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
            
            self.movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            self.movieTitleLabel.leftAnchor.constraint(equalTo: self.movieImageView.rightAnchor, constant: 5.0).isActive = true
            self.movieTitleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.movieTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            self.movieTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        }
    }
}
