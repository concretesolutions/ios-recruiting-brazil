//
//  LoadingView.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 31/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

class LoadingView: UIView {
  
  var loadingActivityIndicatorView: UIActivityIndicatorView = {
    var activityIndicator = UIActivityIndicatorView(style: .gray)
    activityIndicator.startAnimating()
    return activityIndicator
  }()
  
  var loadingLabel: UILabel = {
    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 13))
    label.textAlignment = .center
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
    label.text = "LOADING"
    return label
  }()
  
   init() {
    super.init(frame: CGRect.zero)
    frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    positionFrames()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func positionFrames() {
    addSubview(loadingActivityIndicatorView)
    addSubview(loadingLabel)
    
    loadingActivityIndicatorView.frame.origin.x = center.x - loadingActivityIndicatorView.frame.width / 2
    loadingActivityIndicatorView.frame.origin.y = center.y - loadingActivityIndicatorView.frame.height / 2 - 25
    loadingLabel.frame.origin.x = center.x - loadingLabel.frame.width / 2
    loadingLabel.frame.origin.y = loadingActivityIndicatorView.frame.maxY + 8
  }
  
}
