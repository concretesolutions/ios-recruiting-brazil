//
//  BackgroundState.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

class BackgroundStateView: UIView {
    var emptyStateView: EmptyStateView!
    var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createViews() {
        if emptyStateView == nil {
            emptyStateView = Helpers.loadXib(named: "EmptyStateView", owner: self)
            emptyStateView.frame = self.bounds
            addSubview(emptyStateView, stretchToFit: true)
        }
        
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(frame: self.bounds)
            addSubview(activityIndicator, stretchToFit: true)
        }
        
        self.clear()
    }
    
    func showEmptyState(with configuration: BackgroundStateViewModel) {
        clear()
        emptyStateView.isHidden = false
        emptyStateView.set(with: configuration)
    }
    
    func showLoading() {
        clear()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func clear() {
        emptyStateView.isHidden = true
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}
