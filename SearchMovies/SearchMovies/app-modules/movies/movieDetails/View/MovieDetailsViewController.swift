//
//  MovieDetailsViewController.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 08/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    //MARK: Properties
    var presenter:ViewToMovieDetailsPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieDetailsRouter.setModule(self)
        
    }
 

}

extension MovieDetailsViewController : PresenterToMovieDetailsViewProtocol {
    func returnMainMenu(menuList: [MainMenu]) {
        
    }
    
    
}
