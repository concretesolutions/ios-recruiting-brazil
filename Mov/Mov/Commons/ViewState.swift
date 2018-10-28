//
//  ViewState.swift
//  Mov
//
//  Created by Miguel Nery on 28/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

protocol ViewState {
    func hideViews() -> [UIView]
    func showViews() -> [UIView]
    func onEnter()
    func onExit()
    func enter()
}

extension ViewState {
    func enter() {
        self.hide()
        self.show()
        self.onEnter()
    }
    
    func hide() {
        for view in self.hideViews() {
            view.isHidden = true
        }
    }
    
    func show() {
        for view in self.showViews() {
            view.isHidden = false
        }
    }
    
    func hideViews() -> [UIView] { return [] }
    func showViews() -> [UIView] { return [] }
    func onEnter() {}
    func onExit() {}
}
