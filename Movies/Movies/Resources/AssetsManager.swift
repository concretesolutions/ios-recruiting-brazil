//
//  Assets.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 31/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

enum Assets {
  case star
  case moviePostPlaceholder
  case starSelected
}

class AssetsManager {
  
  static func getImage(forAsset asset: Assets) -> UIImage {
    switch asset {
    case .star:
      return UIImage(named: "star")!
    case .moviePostPlaceholder:
      return UIImage(named: "placeholder")!
    case .starSelected:
      return UIImage(named: "star_select")!
    }
  }
  
}
