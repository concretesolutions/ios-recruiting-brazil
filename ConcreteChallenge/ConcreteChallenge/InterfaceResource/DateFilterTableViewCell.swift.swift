//
//  FavoriteMovieTableViewCell.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 16/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class DateFilterTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var dateLabel: UILabel!

    // MARK: - Properties
    var date: Date? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Functions
    func setupCell(date: Date) {
        self.date = date
        if let year = date.year {
            self.dateLabel.text = String(year)
        }
    }
}
