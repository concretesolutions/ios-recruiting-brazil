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
    //MARK:Properties
    @IBOutlet weak var moveImage: UIImageView!
    @IBOutlet weak var titleTextCell: TextCellView!
    
    @IBOutlet weak var genderTextCell: TextCellView!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var yearTextCell: TextCellView!
    //MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieDetailsRouter.setModule(self)
        
    }
 
    //MARK: Actions
    @IBAction func didBackButtonTap(_ sender: UIBarButtonItem) {
        
    }
    
}

extension MovieDetailsViewController : PresenterToMovieDetailsViewProtocol {
    
    func returnMovieDetails(details: MovieDetailsData) {
        
    }

    func returnMovieDetails(releaseDate: DataReleaseDate) {
        
    }
    
    func returnMovieDetailsError(messageError: String) {
        
    }
    
    func returnloadGenerNames(genders: [String]) {
        DispatchQueue.main.async {
            let strGender:String = genders.joined(separator: ", ")
        }
    }
    
    
}
