//
//  DesignManager.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 15/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class DesignManager: NSObject {
    
    // MARK: - Properties
    // MARK: - Public
    public static let cornerRadiusValue: CGFloat = 9
    public static let bebasNeueRegular: UIFont = UIFont(name: "Bebas-Regular", size: 34) ?? UIFont.boldSystemFont(ofSize: 34)
    public static let montserratSemiBold: UIFont = UIFont(name: "Montserrat-SemiBold", size: 25) ?? UIFont.systemFont(ofSize: 25)
    public static let montserratMedium: UIFont = UIFont(name: "Montserrat-Medium", size: 20) ?? UIFont.systemFont(ofSize: 20)
    public static let montserratLight: UIFont = UIFont(name: "Montserrat-Light", size: 18) ?? UIFont.systemFont(ofSize: 18)
    // MARK: - Private
    private static let shadowRadius: CGFloat = 4.0 // Shadow blur
    private static let shadowOpacity: Float = 0.2 // Shadow color opacity
    private static let shadowWidth: CGFloat = 0 // Shadow x
    private static let shadowHeight: CGFloat = 0 // Shadow y
    
    // MARK: - functions
    // MARK: - Public
    public static func gradient(toView view: UIView){
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor(red: 48/256, green: 48/256, blue: 48/256, alpha: 1), UIColor.white.withAlphaComponent(0)]
        gradient.zPosition = -1
        view.layer.addSublayer(gradient)
    }
    
    public static func applyShadow(toView view: UIView, color: UIColor = UIColor.black, opacity: Float = DesignManager.shadowOpacity, x: CGFloat = DesignManager.shadowWidth, y: CGFloat = DesignManager.shadowHeight, blur: CGFloat = DesignManager.shadowRadius){
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowRadius = blur
        view.layer.shadowOffset = CGSize(width: x, height: y)
        view.layer.masksToBounds = false
    }
    
    public static func applyShadow(toViews views: [UIView], color: UIColor = UIColor.black, opacity: Float = DesignManager.shadowOpacity, x: CGFloat = DesignManager.shadowWidth, y: CGFloat = DesignManager.shadowHeight, blur: CGFloat = DesignManager.shadowRadius){
        for view in views {
            applyShadow(toView: view, color: color, opacity: opacity, x: x, y: y, blur: blur)
        }
    }
    
    public static func configureTabBar(tabBar: UITabBar){
        tabBar.barTintColor = PaletColor.oceanBlue.rawValue
        tabBar.tintColor = .white
        tabBar.isTranslucent = false
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    }
    
    public static func configureNavigation(navigationBar: UINavigationBar){
        navigationBar.shadowImage = UIImage(named: "NavBarShade")
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = PaletColor.gray.rawValue
        navigationBar.prefersLargeTitles = true
        navigationBar.tintColor = PaletColor.esmerald.rawValue
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: DesignManager.bebasNeueRegular, NSAttributedString.Key.foregroundColor: PaletColor.esmerald.rawValue]
        
    }
    
    // MARK: - Private
}

