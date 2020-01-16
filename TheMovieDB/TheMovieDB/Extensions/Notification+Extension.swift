//
//  Notification+Extension.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 11/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation

extension Notification {
    public static let moviesUpdated = Notification.init(name: Notification.Name(rawValue: "moviesUpdated"))
}

extension Notification.Name {
     public static let updateSelectedMovie = Notification.Name(rawValue: "updateSelectedMovie")
}
