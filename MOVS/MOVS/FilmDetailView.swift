//
//  FilmDetailView.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 23/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilmDetailView: UIViewController {
    // MARK: - Properties
    // MARK: - Outlets
    @IBOutlet weak var outletTableView: UITableView!
    // MARK: - Public
    var presenter: FilmDetailPresenter!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure Navigation
        self.title = "Detalhes"
        //Load table
        self.presenter.viewDidLoad(withTableView: self.outletTableView)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.viewDidAppear(withTableView: self.outletTableView)
    }

    //MARK: - Functions
    //MARK: - Public

}
