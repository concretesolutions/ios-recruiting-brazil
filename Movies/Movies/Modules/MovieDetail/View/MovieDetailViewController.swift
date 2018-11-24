//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Renan Germano on 24/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var overview: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
