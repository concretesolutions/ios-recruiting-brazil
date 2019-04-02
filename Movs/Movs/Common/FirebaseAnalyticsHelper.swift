//
//  GoogleAnalyticsHelper.swift
//  Movs
//
//  Created by Alexandre Papanis on 02/04/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import Foundation
import FirebaseAnalytics

class FirebaseAnalyticsHelper {
    
    static func addFavoriteEventLogger(movieId: Int, movieTitle: String){
        
        Analytics.logEvent("addFavorite", parameters: [
            "id": movieId as NSObject,
            "title": movieTitle as NSObject
        ])
        
//        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
//            AnalyticsParameterItemID: "id-\(movieId)",
//            AnalyticsParameterItemName: movieTitle,
//            AnalyticsParameterContentType: "addFavorite"
//            ])
    }
    
    static func removeFavoriteEventLogger(movieId: Int, movieTitle: String){
        Analytics.logEvent("removeFavorite", parameters: [
            "id": movieId as NSObject,
            "title": movieTitle as NSObject
        ])
//        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
//            AnalyticsParameterItemID: "id-\(movieId)",
//            AnalyticsParameterItemName: movieTitle,
//            AnalyticsParameterContentType: "removeFavorite"
//            ])
    }
}
