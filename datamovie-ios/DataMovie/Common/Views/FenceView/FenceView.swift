//
//  FenceView.swift
//  TheVargo
//
//  Created by Andre on 11/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class FenceView: UIView {

    @IBOutlet weak var loadingView: DMCardView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var btRetry: DMButton!
    @IBOutlet weak var messageLbl: UILabel!
    
    @IBAction func touchRetry(_ sender: Any) {
        showFenceLoadingView()
    }
    
}

extension FenceView {
    
    func showFenceLoadingView() {
        errorView.isHidden = true
        loadingView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func showErrorView(error: ErrorInterface, target: Any?, action: Selector?) {
        errorView.isHidden = false
        messageLbl.text = error.message
        loadingView.isHidden = true
        btRetry.removeTarget(nil, action: nil, for: .allEvents)
        if let target = target, let action = action, !error.hideButton {
            btRetry.setTitle(error.buttonText, for: .normal)
            btRetry.addTarget(target, action: action, for: .touchUpInside)
        } else {
            btRetry.isHidden = true
        }
        
        activityIndicator.stopAnimating()
    }
    
}
