//
//  FilmDetailRouter.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 23/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilmDetailRouter{
    // MARK: - Properties
    var presenter: FilmDetailPresenter!
    
    
    // MARK: Init
    init(withFilm film: ResponseFilm) {
        
        //Instancing Storyboard
        let storyboard = UIStoryboard(name: StoryboardID.filmDetail.rawValue, bundle: Bundle.main)
        let viewController: FilmDetailView = storyboard.instantiateViewController()
        
        //Instancing Interactor
        let interactor = FilmDetailInteractor(withFilm: film)
        
        //Instancing Presenter
        self.presenter = FilmDetailPresenter(router: self, interactor: interactor, view: viewController)
    }
}
