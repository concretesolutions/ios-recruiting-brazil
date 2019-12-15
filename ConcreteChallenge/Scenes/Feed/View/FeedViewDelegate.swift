//
//  FeedViewDelegate.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

protocol FeedViewDelegate: ViewDelegate, FavoriteViewDelegate {
    
    /// Whenever new data is loaded, the feed must reload the displayed data
    func reloadFeed()
}
