//
//  FilterRouter.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 25/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilterRouter {
    // MARK: - Properties
    var presenter: FilterPresenter!
    
    
    // MARK: Init
    init() {
        
        //Instancing Storyboard
        let storyboard = UIStoryboard(name: StoryboardID.filter.rawValue, bundle: Bundle.main)
        let viewController: FilterView = storyboard.instantiateViewController()
        
        //Instancing Interactor
        let interactor = FilterInteractor()
        
        //Instancing Presenter
        self.presenter = FilterPresenter(router: self, interactor: interactor, view: viewController)
    }
    
    func goToFilter(withChooseType type: FilterFavoriteType){
        let filterChoose = FilterChooseRouter(withFilterType: type)
        if let navigationController = self.presenter.view.navigationController {
            navigationController.pushViewController(filterChoose.presenter.view, animated: true)
        }
    }
    
    func goToFilter(withChooseType type: FilterFavoriteType, andOptions option: Any){
        let filterChoose = FilterChooseRouter(withFilterType: type, andInfo: option)
        if let navigationController = self.presenter.view.navigationController {
            navigationController.pushViewController(filterChoose.presenter.view, animated: true)
        }
    }
    
    func dismissWithFilter(inNavigationController navigationController: UINavigationController?){
        navigationController?.popViewController(animated: true)
    }
}
