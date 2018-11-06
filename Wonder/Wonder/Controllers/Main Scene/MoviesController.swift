//
//  MoviesController.swift
//  Wonder
//
//  Created by Marcelo on 06/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

// reachability
var reachability = Reachability(hostname: "www.apple.com")

class MoviesController: UIViewController {

    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // observers
        observerManager()
        
        // Check internet status
        checkInternetStatus()
        
    }
    

    // MARK: - Observers
    private func observerManager() {
        
        //
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityStatusChanged(_:)),
                                               name: NSNotification.Name(rawValue: "ReachabilityChangedNotification"),
                                               object: nil)
        
        
        
    }
    
    // observer actions
    // rawValue: ReachabilityChangedNotification)
    @objc private func reachabilityStatusChanged(_ sender: NSNotification) {
        
        guard ((sender.object as? Reachability)?.currentReachabilityStatus) != nil else { return }
        
        checkInternetStatus()
        
    }
    
    private func checkInternetStatus() {
        if !reachability.isReachable() {
            AppSettings.standard.updateInternetConnectionStatus(false)
            performSegue(withIdentifier: "showErrorHandler", sender: self)
        }else{
            AppSettings.standard.updateInternetConnectionStatus(true)

//            self.setNoContent(msg: "Loading...")
//            self.setActivityIndicator(show: true)
//            loadAppData()
            
            // post notification to error hanlder to dismiss UI
            NotificationCenter.default.post(name: Notification.Name("didConnectToInternet"), object: nil, userInfo: nil)
        }
    }

    
    
}
