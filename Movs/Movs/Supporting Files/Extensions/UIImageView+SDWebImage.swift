//
//  UIImageView+SDWebImage.swift
//  Movs
//
//  Created by Brendoon Ryos on 26/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import SDWebImage

extension UIImageView {
  func download(image url: String?, activityIndicator: UIActivityIndicatorView) {
    guard let url = url else {
      image = UIImage()
      activityIndicator.stopAnimating()
      return
    }
    activityIndicator.startAnimating()
    let request = MovsAPI.fetchImage(named: url)
    let path = request.path
    let fullURL = request.baseURL.appendingPathComponent(path)
    self.sd_setImage(with: fullURL, placeholderImage: .none, options: [.retryFailed, .progressiveDownload, .scaleDownLargeImages, .highPriority, .continueInBackground]) { (_, _, _, _) in
      activityIndicator.stopAnimating()
    }
  }
}
