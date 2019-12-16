//
//  UIViewController+ScrollToTop.swift
//  movies
//
//  Created by Jacqueline Alves on 13/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit
import Combine

extension UIViewController {
    func scrollToTop() {
        func scrollToTop(view: UIView?) {
            guard let view = view else { return }
            
            switch view {
            case let scrollView as UIScrollView:
                scrollView.perform(NSSelectorFromString("_scrollToTopIfPossible:"), with: true)
            default:
                break
            }
            
            for subView in view.subviews {
                scrollToTop(view: subView)
            }
        }
        
        scrollToTop(view: self.view)
    }
    
    func subscribeToTabSelection(cancellable: inout AnyCancellable?) {
        guard let tabBarController = self.tabBarController as? TabBarViewController else { return }
        cancellable = tabBarController.publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { (currentViewController, nextViewController) in
                // Check if is showing this view controller and tab bar item was pressed again
                if currentViewController == self && currentViewController == nextViewController {
                    self.scrollToTop()
                }
            })
    }
}
