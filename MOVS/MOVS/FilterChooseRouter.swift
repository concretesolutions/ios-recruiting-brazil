//
//  FilterChooseRouter.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 25/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilterChooseRouter {
    // MARK: - Properties
    var presenter: FilterChoosePresenter!
    
    
    // MARK: Init
    init(withFilterType type: FilterFavoriteType) {
        
        //Instancing Storyboard
        let storyboard = UIStoryboard(name: StoryboardID.filterChoose.rawValue, bundle: Bundle.main)
        let viewController: FilterChooseView = storyboard.instantiateViewController()
        
        //Instancing Interactor
        let interactor = FilterChooseInteractor(cellType: type)
        
        //Instancing Presenter
        self.presenter = FilterChoosePresenter(router: self, interactor: interactor, view: viewController)
    }
    
    init(withFilterType type: FilterFavoriteType, andInfo info: Any) {
        
        //Instancing Storyboard
        let storyboard = UIStoryboard(name: StoryboardID.filterChoose.rawValue, bundle: Bundle.main)
        let viewController: FilterChooseView = storyboard.instantiateViewController()
        
        //Instancing Interactor
        let interactor = FilterChooseInteractor(cellType: type, withData: info)
        
        
        //Instancing Presenter
        self.presenter = FilterChoosePresenter(router: self, interactor: interactor, view: viewController)
    }
    
}
