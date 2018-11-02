//
//  UIImage+AspectRatio.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 02/11/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

extension UIImageView {
  public func getImageRatioBasedOnSize(_ imgSize: CGSize) -> CGSize {
    let margin: CGFloat = 30.0
    let screenWidth = UIScreen.main.bounds.width - margin
    let ratio =  imgSize.height / imgSize.width
    let newHeight = screenWidth * ratio
    self.frame.size = CGSize(width: screenWidth, height: newHeight)
    return CGSize(width: screenWidth, height: newHeight)
  }
}
