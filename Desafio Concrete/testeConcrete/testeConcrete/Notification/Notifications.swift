//
//  Notifications.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 19/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import Foundation

extension Notification{
    private static var standardName = "testeConcrete."
    static var choosedFilter = Notification.Name(rawValue: Notification.standardName+"choosedFile")
    static var loadedPopularMovies = Notification.Name(rawValue: Notification.standardName+"loadedPopularMovies")
    static var finishedLoadedMovieAndPoster = Notification.Name(rawValue: Notification.standardName+"finishedLoadedMovieAndPoster")
}
