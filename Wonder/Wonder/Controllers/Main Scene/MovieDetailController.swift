//
//  MovieDetailController.swift
//  Wonder
//
//  Created by Marcelo on 09/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

class MovieDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Public Properties
    public var movie = Results()
    public var movieImage = UIImage()
    
    // MARK: - Private Propertie
    private var tableStructure = [String]()
    private var movieTableCellFactory = MovieTableCellFactory()
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        uiConfig()
        loadTableStructure()
        
    }
    
    // MARK: - UI Config
    private func uiConfig() {
        // Visual Effects
        tableView.backgroundView = view.blur(image: movieImage)
    }
    
    private func loadTableStructure() {
        tableStructure.append("DetailImageCell")
        tableStructure.append("DetailTitleCell")
        tableStructure.append("DetailInfoCell")
        tableStructure.append("DetailDescriptionCell")
        tableStructure.append("DetailSeparatorCell")
        tableStructure.append("DetailActionCell")
    }
    
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableStructure.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.movieTableCellFactory.movieTableCell(movie: movie, indexPath: indexPath, movieImage: movieImage, tableView: tableView)
    }
    
    // MARK: - UI Actions
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Status Bar Helper
    override var prefersStatusBarHidden: Bool {
        return true
    }
 
}
