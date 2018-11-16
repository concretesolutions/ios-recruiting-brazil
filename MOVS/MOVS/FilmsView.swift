//
//  FilmsView.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 15/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilmsView: UIViewController {

    // MARK: - Properties
    // MARK: - Outlets
    @IBOutlet weak var outletFilmsCollectionView: UICollectionView!
    
    // MARK: - Public
    var presenter: FilmsPresenter!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Navigation
        self.setNavigationBar()
        
        // Load collection
        self.presenter.viewDidLoad(withCollection: self.outletFilmsCollectionView)
    }

    
    //MARK: - Functions
    //MARK: - Public
    func setNavigationBar(){
        guard let navBar = self.navigationController?.navigationBar else {
            print("Error to get navBar in: \(FilmsView.self)")
            return
        }
        DesignManager.configureNavigation(navigationBar: navBar)
        navBar.topItem?.title = "Filmes"
    }
}
