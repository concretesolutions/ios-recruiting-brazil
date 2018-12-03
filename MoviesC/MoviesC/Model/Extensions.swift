//
//  Extensions.swift
//  MoviesC
//
//  Created by Isabel Lima on 03/12/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func displayActivityIndicator(on backgroundView: UIView) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.startAnimating()
        indicator.center = backgroundView.center
        
        DispatchQueue.main.async {
            backgroundView.addSubview(indicator)
        }
   
        return indicator
    }
    
    func removeActivityIndicator(_ activityIndicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            activityIndicator.removeFromSuperview()
        }
    }
    
}

extension UILabel {
    func setYear(from date: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dd"
        guard let date = dateFormatter.date(from: date) else { return }
        self.text = String(Calendar.current.component(.year, from: date))
    }
}
