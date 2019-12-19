//
//  DetailMovieController.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 11/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit

class DetailMovieController: UIViewController {
    var movie:Movie? {
        didSet{
           setView()
        }
    }
    override func loadView() {
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setView(){
        guard let movie = self.movie else{
            return
        }
        let view = DetailMovieView(movie: movie)
        self.view = view
    }
    @objc func favoriteMovie(sender: UIButton!) {
        (self.view as? DetailMovieView)?.favoriteButton.setBackgroundImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
        if let movie = self.movie{
            save(movie: movie)
        }
    }
}
