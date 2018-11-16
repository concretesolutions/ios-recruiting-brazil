//
//  FilmsRouter.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 15/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilmsRouter{
    
    // MARK: - Properties
    var presenter: FilmsPresenter!
    
    
    // MARK: Init
    init() {
        
        //Instancing Storyboard
        let storyboard = UIStoryboard(name: StoryboardID.films.rawValue, bundle: Bundle.main)
        let viewController: FilmsView = storyboard.instantiateViewController()
        
        //Instancing Interactor
        let interactor = FilmsInteractor()
        
        //Instancing Presenter
        self.presenter = FilmsPresenter(router: self, interactor: interactor, view: viewController)
    }
    
}

