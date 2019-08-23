//
//  DetalheMovieViewController.swift
//  Movs
//
//  Created by Gustavo Caiafa on 16/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import UIKit
import ObjectMapper

class DetalheMovieViewController: UIViewController {

    @IBOutlet weak var detalheMoviewView: DetalheMovieView!
    
    var movie = MoviesModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detalheMoviewView.configuraCell(movie: movie, controller: self)
    }

    @IBAction func BtVoltar(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
