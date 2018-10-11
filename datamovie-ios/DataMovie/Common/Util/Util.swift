//
//  Util.swift
//  DataMovie
//
//  Created by Andre on 27/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit
import SafariServices

class Util: NSObject {
    
    private override init() { }
    
    static func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    static func newSFSafariInstance(with url: URL) -> SFSafariViewController {
        let safariVC = SFSafariViewController(url: url)
        safariVC.dismissButtonStyle = .close
        safariVC.preferredBarTintColor = .backgroundColorDarker
        safariVC.preferredControlTintColor = .white
        safariVC.modalPresentationStyle = .overFullScreen
        return safariVC
    }
    
}
