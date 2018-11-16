//
//  TabBarRouter.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 15/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class TabBarRouter{
    
    // MARK: - Properties
    var presenter: TabBarPresenter!
    
    
    // MARK: Init
    init(with screens:[UIViewController]) {
        
        //Instancing Storyboard
        let storyboard = UIStoryboard(name: StoryboardID.tabBar.rawValue, bundle: Bundle.main)
        let viewController: TabBarView = storyboard.instantiateViewController()
        
        viewController.setViewControllers(screens, animated: false)
        
        //Instancing Interactor
        let interactor = TabBarInteractor()
        
        //Instancing Presenter
        self.presenter = TabBarPresenter(router: self, interactor: interactor, view: viewController)
    }
    
}
