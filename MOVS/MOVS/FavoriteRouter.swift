//
//  FavoriteRouter.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 24/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FavoriteRouter{
    // MARK: - Properties
    var presenter: FavoritePresenter!
    
    
    // MARK: Init
    init() {
        
        //Instancing Storyboard
        let storyboard = UIStoryboard(name: StoryboardID.favorite.rawValue, bundle: Bundle.main)
        let viewController: FavoriteView = storyboard.instantiateViewController()
        
        //Instancing Interactor
        let interactor = FavoriteInteractor()
        
        //Instancing Presenter
        self.presenter = FavoritePresenter(router: self, interactor: interactor, view: viewController)
    }
    
    func goToFilter(){
        let filter = FilterRouter()
        if let navigationController = self.presenter.view.navigationController {
            navigationController.pushViewController(filter.presenter.view, animated: true)
        }
    }
}
