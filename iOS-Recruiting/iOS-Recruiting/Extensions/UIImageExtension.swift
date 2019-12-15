//
//  UIImageExtension.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 15/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation
import UIKit
import Constraints

private var key: UInt8 = 0
fileprivate let cache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    class func fetch(path: String,  handler: @escaping (UIImage?) -> Void) {
        if let image = cache.object(forKey: path as NSString) {
            handler(image)
        } else if let url = URL(string: path) {
            let request = URLSession.shared.dataTask(with: url) { data, response, _ in
                DispatchQueue.main.async {
                    let key = response?.url?.absoluteString ?? ""
                    if let image = UIImage(data: data ?? Data()) {
                        cache.setObject(image, forKey: key as NSString)
                        handler(image)
                    } else {
                        handler(nil)
                    }
                }
            }
            
            request.resume()
        }
    }

    func setImage(url: URL, showLoader: Bool = true) {
        self.image = nil
        
        if showLoader {
            self.showLoader()
        }

        let activityIndicator = self.subviews.first { (view) -> Bool in
            view is UIActivityIndicatorView && view.tag == 5
        }
        
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            self.image = image
            activityIndicator?.removeFromSuperview()
        } else {
            self.fetch(url: url)
            activityIndicator?.removeFromSuperview()
        }
    }

    func setImage(path: String, showLoader: Bool = true) {
        self.image = nil
        
        if showLoader {
            self.showLoader()
        }

        let activityIndicator = self.subviews.first { (view) -> Bool in
            view is UIActivityIndicatorView && view.tag == 5
        }
        
        if let image = cache.object(forKey: path as NSString) {
            self.image = image
            activityIndicator?.removeFromSuperview()
        } else if let url = URL(string: path) {
            self.fetch(url: url)
        } else {
            activityIndicator?.removeFromSuperview()
        }
    }
    
    private func showLoader() {
        
        
        var activityIndicator: UIActivityIndicatorView?
        
        
        if !self.subviews.contains(where: { (view) -> Bool in
            let isActivityIndicator = view is UIActivityIndicatorView && view.tag == 5
            if isActivityIndicator {
                activityIndicator = view as? UIActivityIndicatorView
            }
            return isActivityIndicator
        }) {
            
            let loader = UIActivityIndicatorView(style: .whiteLarge)
            loader.hidesWhenStopped = true
            loader.startAnimating()
            loader.color = #colorLiteral(red: 0.3411764706, green: 0.3529411765, blue: 0.368627451, alpha: 1)
            loader.tag = 5

            self.addSubview(loader)
            
            activityIndicator = loader
        }
        
        activityIndicator?.constraint(on: self).centerX().centerY().activate()
        activityIndicator?.isHidden = false
        activityIndicator?.startAnimating()
    }

    private func fetch(url: URL) {
        let request = URLSession.shared.dataTask(with: url) { data, response, _ in
            DispatchQueue.main.async {
                let key = response?.url?.absoluteString ?? ""
                if let image = UIImage(data: data ?? Data()) {
                    cache.setObject(image, forKey: key as NSString)
                    self.image = image
                }
                let activityIndicator = self.subviews.first { (view) -> Bool in
                    view is UIActivityIndicatorView && view.tag == 5
                }
                activityIndicator?.removeFromSuperview()
            }
        }
        
        request.resume()
    }

}
