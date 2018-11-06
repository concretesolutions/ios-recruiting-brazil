//
//  AppSettings.swift
//  Wonder
//
//  Created by Marcelo on 06/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

private let sharedSingleton = AppSettings()

class AppSettings {

    // internet connection status
    public var isConnectedToInternet = false
    
    class var standard: AppSettings {
        return sharedSingleton
    }
    
    // MARK: - Reachability Helper
    public func updateInternetConnectionStatus(_ status: Bool) {
        self.isConnectedToInternet = status
        if status {
            print("🌎 internet ok 👍")
            
        }else{
            print("🌎 internet NOT ok ‼️")
        }
    }
    
    public func internetConnectionStatus() -> Bool {
        return self.isConnectedToInternet
    }

}
