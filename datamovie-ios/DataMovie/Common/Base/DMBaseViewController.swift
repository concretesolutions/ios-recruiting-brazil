//
//  DMBaseViewController.swift
//  DataMovie
//
//  Created by Andre on 02/05/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class DMBaseViewController: UIViewController {
    
    private lazy var fenceView: FenceView = {
        return FenceView.fromNib()
    }()
    
}

//MARK: - Fence Functions -

extension DMBaseViewController {
    
    private func verifyFenceView() {
        if(!fenceView.isDescendant(of: view)) {
            view.addSubview(fenceView)
            fenceView.bindFrameToSuperviewBounds()
            fenceView.isHidden = true
        }
    }
    
    func showFenceError(error: ErrorInterface, target: Any?, action: Selector?) {
        verifyFenceView()
        fenceView.showErrorView(error: error, target: target, action: action)
        view.bringSubviewToFront(fenceView)
        fenceView.isHidden = false
    }
    
    func showFenceLoading() {
        verifyFenceView()
        fenceView.showFenceLoadingView()
        view.bringSubviewToFront(fenceView)
        fenceView.isHidden = false
    }
    
    func hideFenceView() {
        view.sendSubviewToBack(fenceView)
        fenceView.isHidden = true
    }
    
}

