//
//  NoResultsView.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 31/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

class NoResultsView: UIView {
  
  var noResultsLabel: UILabel = {
    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 35))
    label.textAlignment = .center
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
    label.text = "No Results"
    return label
  }()
  
  var searchInfoLabel: UILabel = {
    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 30))
    label.textAlignment = .center
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
    label.text = ""
    return label
  }()
  
  init() {
    super.init(frame: CGRect.zero)
    frame = CGRect(x: 0, y: 0, width: 300, height: 200)
    positionFrames()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func positionFrames() {
    addSubview(noResultsLabel)
    addSubview(searchInfoLabel)
    
    noResultsLabel.frame.origin.x = center.x - noResultsLabel.frame.width / 2
    noResultsLabel.frame.origin.y = center.y - noResultsLabel.frame.height / 2 - 25
    searchInfoLabel.frame.origin.x = center.x - searchInfoLabel.frame.width / 2
    searchInfoLabel.frame.origin.y = noResultsLabel.frame.maxY
  }
  
  func setSearchString(_ string: String) {
    self.searchInfoLabel.text = "for \"\(string)\"."
  }

}
