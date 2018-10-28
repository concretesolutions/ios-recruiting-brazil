//
//  ImageFetcher.swift
//  Mov
//
//  Created by Miguel Nery on 27/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

protocol ImageFetcher {
    func fetchImage(from url: URL, to imageView: UIImageView)
}
