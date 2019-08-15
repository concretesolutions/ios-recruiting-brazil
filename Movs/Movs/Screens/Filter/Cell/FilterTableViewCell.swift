//
//  FilterTableViewCell.swift
//  Movs
//
//  Created by Marcos Lacerda on 12/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

  // MARK: - Outlets
  
  @IBOutlet weak fileprivate var itemLabel: UILabel!
  @IBOutlet weak fileprivate var itemValue: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    self.prepareForReuse()
  }
  
  // MARK: - Setup
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    itemLabel.text = ""
    itemValue.text = ""
  }
  
  func setup(with type: FilterOptions, filter: Filters) {
    itemLabel.text = type.title
    
    switch type {
    case .date: itemValue.text = filter.year

    case .genres:
      if filter.genres.count > 0 {
        itemValue.text = String(format: "genre-filter-selected".localized(), filter.genres.count, filter.genres.count > 1 ? "genre-filter-selected-character".localized() : "")
      }
    }
  }

}
