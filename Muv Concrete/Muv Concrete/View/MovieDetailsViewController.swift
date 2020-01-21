//
//  MovieDetailsViewController.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 21/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    var id: Int32?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id)
        // Do any additional setup after loading the view.
        let coreData = CoreData()
        let movie = coreData.getElementCoreData(id: id!)
        print(movie?.overview, movie?.genreIDs)
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
