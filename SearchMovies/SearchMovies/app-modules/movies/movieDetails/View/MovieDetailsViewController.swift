//
//  MovieDetailsViewController.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 08/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import UIKit

class MovieDetailsViewController: BaseViewController {
    //MARK: Properties
    var presenter:ViewToMovieDetailsPresenterProtocol?
    var movieId:Int!
    var genrerIds:[Int]!
    //MARK:Properties
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var display: DisplayInformationView!
    @IBOutlet weak var titleTextCell: TextCellView!
    @IBOutlet weak var genderTextCell: TextCellView!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var yearTextCell: TextCellView!
    @IBOutlet weak var viewContent: UIView!
    //MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieDetailsRouter.setModule(self)
        self.titleTextCell.showImage(showImage: true)
        self.genderTextCell.showImage(showImage: false)
        self.yearTextCell.showImage(showImage: false)
        self.navigationController?.navigationBar.styleDefault()
        self.showActivityIndicator()
        self.presenter?.loadMovieDetails(id: self.movieId)
        self.presenter?.loadGenerNames(ids: self.genrerIds)
        self.presenter?.loadMovieReleaseDates(id: self.movieId)
    }
 
    //MARK: Actions
    @IBAction func didBackButtonTap(_ sender: UIBarButtonItem) {
        self.presenter?.route?.dismiss(self, animated: true)
    }
    
}

extension MovieDetailsViewController : PresenterToMovieDetailsViewProtocol {
     
    
    func returnDateReleaseError(messageError: String) {
        self.hideActivityIndicator()
        DispatchQueue.main.async {
            self.showPainelView(painelView: self.display, contentView: self.viewContent, description: "Um erro ocorreu, tente novamente mais tarde", typeReturn: .error)
        }
    }
    
    
    func returnMovieDetails(details: MovieDetailsData) {
        self.hideActivityIndicator()
        DispatchQueue.main.async {
            self.movieImage.downloaded(from: "\(Constants.imdbBaseUrlImage)\(details.imageUrl)")
            self.titleTextCell.fill(description: details.name, showImage: true, isFavorite: false)
            self.overViewLabel.text = details.description
        }
    }

    func returnDateRelease(releaseDate: DataReleaseDate) {
        self.hideActivityIndicator()
        DispatchQueue.main.async {
            self.yearTextCell.fill(description: String(releaseDate.releaseYear), showImage: false, isFavorite: false)
        }
    }
    
    func returnMovieDetailsError(messageError: String) {
        self.hideActivityIndicator()
        DispatchQueue.main.async {
            self.showPainelView(painelView: self.display, contentView: self.viewContent, description: "Um erro ocorreu, tente novamente mais tarde", typeReturn: .error)
        }
    }
    
    func returnloadGenerNames(genders: [String]) {
        DispatchQueue.main.async {
            let strGender:String = genders.count > 0 ? genders.joined(separator: ", ") : genders[0]
            self.genderTextCell.fill(description: strGender, showImage: false, isFavorite: false)
        }
    }
    
    
}
