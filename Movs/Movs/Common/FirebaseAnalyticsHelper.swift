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

    }
    
    static func removeFavoriteEventLogger(movieId: Int, movieTitle: String){
        Analytics.logEvent("removeFavorite", parameters: [
            "id": movieId as NSObject,
            "title": movieTitle as NSObject
        ])
    }
    
    static func isNotConnectedEventLogger(){
        Analytics.logEvent("isNotConnected", parameters: nil)
    }
}
