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
    var movieId:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieDetailsRouter.setModule(self)
        
    }
 

}

extension MovieDetailsViewController : PresenterToMovieDetailsViewProtocol {
    func returnloadGenerNames(genders: [String]) {
        DispatchQueue.main.async {
            let strGender:String = genders.joined(separator: ", ")
        }
    }
    
    
}
