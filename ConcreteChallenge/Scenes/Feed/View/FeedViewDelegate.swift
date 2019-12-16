//
//  FeedViewDelegate.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

protocol FeedViewDelegate: ViewDelegate {
    
    /// Whenever new data is loaded, the feed must reload the displayed data.
    func reloadFeed()
    
    /// Called when the feed needs to be at the first position.
    func resetFeedPosition()
}
