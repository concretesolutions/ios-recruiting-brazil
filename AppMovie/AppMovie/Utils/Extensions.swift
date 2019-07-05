//
//  Extensions.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 04/07/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

var cache = [String: UIImage]()

extension UIImageView {
    
    
}

extension UIImage{
    /** Cria uma imagem flat num tamanho específico.*/
    static func createFlatImage(size:CGSize, corners:UIRectCorner, cornerRadius:CGSize, color:UIColor) -> UIImage{
        
        let rect:CGRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        let path:UIBezierPath = UIBezierPath.init(roundedRect: rect , byRoundingCorners: corners, cornerRadii: cornerRadius)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        path.fill()
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //
        return image
    }
}

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    //#F7CE5B - Yellow
    static func mainColor() -> UIColor {
        return UIColor.rgb(red: 247, green: 206, blue: 91)
    }
    //#2D3047 - DarkBlue
    static func mainDarkBlue() -> UIColor {
        return UIColor.rgb(red: 45, green: 48, blue: 71)
    }
    //#D9971E - Orange
    static func mainOrange() -> UIColor {
        return UIColor.rgb(red: 217, green: 151, blue: 30)
    }
    //#FFFFFF - White
    static func mainWhite() -> UIColor {
        return UIColor.rgb(red: 1.0, green: 1.0, blue: 1.0)
    }
}

extension UIView {
    
    func center(inView view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}


