//
//  Extensions.swift
//  Challenge
//
//  Created by Sávio Berdine on 23/10/18.
//  Copyright © 2018 Sávio Berdine. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func dateYyyyMmDdToDdMmYyyyWithDashes() -> String {
        var indexStartOfText = self.index(self.startIndex, offsetBy: 0)
        var indexEndOfText = self.index(self.endIndex, offsetBy: -6)
        let year = "\(self[indexStartOfText..<indexEndOfText])"
        print(year)
        indexStartOfText = self.index(self.startIndex, offsetBy: 5)
        indexEndOfText = self.index(self.endIndex, offsetBy: -3)
        let month = "\(self[indexStartOfText..<indexEndOfText])"
        print(month)
        indexStartOfText = self.index(self.startIndex, offsetBy: 8)
        indexEndOfText = self.index(self.endIndex, offsetBy: 0)
        let day = "\(self[indexStartOfText..<indexEndOfText])"
        print(day)
        return "\(day)/\(month)/\(year)"
    }
}

extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0,y: 0, width:self.frame.size.width, height:width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width,y: 0, width:width, height:self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:self.frame.size.height - width, width:self.frame.size.width, height:width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:0, width:width, height:self.frame.size.height)
        self.layer.addSublayer(border)
    }
}
