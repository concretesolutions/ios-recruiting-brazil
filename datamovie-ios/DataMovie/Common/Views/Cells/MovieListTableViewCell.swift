//
//  MovieListTableViewCell.swift
//  DataMovie
//
//  Created by Andre on 25/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit
import Shimmer

enum MovieListTableViewCellStyle {
    case dark
    case clear
}

//Protocol for Presenters
protocol AddMoviesProtocol: class {
    func addMovie(with tmdbID: Int)
}

//Protocol for Viewcontrollers
protocol AddMoviesTableViewProtocol {
    func touchAddMovie(from row: UITableViewCell)
}

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var posterCardView: DMCardView!
    @IBOutlet weak var posterImage: DMImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var addButton: DMButton!
    @IBOutlet weak var shimmerView: FBShimmeringView!
    @IBOutlet weak var containerView: UIView!
    
    var style: MovieListTableViewCellStyle = .clear
    var tableViewProtocol: AddMoviesTableViewProtocol?
    var item: DiscoverItemListView? {
        didSet {
            
            contentView.backgroundColor = style == .dark ? .backgroundColorDarker : .clear
            addButton.tintColor = style == .dark ? .blueColor : .white
            
            guard let item = item else { return }
            titleLabel.text = item.title
            overViewLabel.text = item.overview
            
            if let releaseDate = item.releaseDate, !releaseDate.isEmpty {
                dateLabel.isHidden = false
                dateLabel.text = Date(dateString: releaseDate)?.stringFormat()
            } else {
                dateLabel.isHidden = true
            }
            
            addButton.showStatus(item.buttonStatus)
        }
    }
    var isLoading: Bool = false {
        didSet {
            let backgroundColor = isLoading ? UIColor.white.withAlphaComponent(0.25) : .clear
            titleLabel.backgroundColor = backgroundColor
            dateLabel.backgroundColor = backgroundColor
            posterCardView.backgroundColor = backgroundColor
            posterCardView.shadowColor = isLoading ? .clear : .black
            posterCardView.shadowOpacity = isLoading ? 0.0 : 0.5
            shimmerView.contentView = containerView
            shimmerView.isShimmering = isLoading
            addButton.isHidden = isLoading
            titleLabel.text = "  "
            dateLabel.text = "  "
            posterImage.image = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func touchAddButton(_ sender: Any) {
        tableViewProtocol?.touchAddMovie(from: self)
    }
    
    func updateButtonStatus(_ status: DMButtonStatus) {
        addButton.showStatus(status)
    }
    
}
