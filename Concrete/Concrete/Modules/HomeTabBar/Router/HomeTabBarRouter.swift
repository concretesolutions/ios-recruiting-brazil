//
//  HomeTabBarRouter.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 17/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

class HomeTabBarRouter: NSObject {
    
    private(set) var presenter:HomeTabBarPresenter!
    
    private override init() {}
    
    required init(viewControllers:[UIViewController]) {
        //Instancing Variables
        
        super.init()
        
        //
        let storyboard = UIStoryboard(name: "HomeTabBarViewController", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeTabBarViewController")
        
        //Instancing View
        guard let view = viewController as? HomeTabBarViewController else {
            Logger.logError(in: self, message: "Could not cast \(viewController) as HomeTabBarViewController")
            return
        }
        
        view.viewControllers = viewControllers
        
        //Instancing Interactor
        let interactor = HomeTabBarInteractor()
        //Instancing Presenter
        self.presenter = HomeTabBarPresenter(router: self, interactor: interactor, view: view)
    }
}
