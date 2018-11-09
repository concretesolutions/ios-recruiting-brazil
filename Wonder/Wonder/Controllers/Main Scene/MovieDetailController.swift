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
        observerManager()
        
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
    
    // MARK: - Observers
    private func observerManager() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didChangeFavorite(_:)),
                                               name: NSNotification.Name(rawValue: "didChangeFavorite"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didSelectShare(_:)),
                                               name: NSNotification.Name(rawValue: "didSelectShare"),
                                               object: nil)
    }
    
    // observer actions
    @objc private func didChangeFavorite(_ sender: NSNotification) {
        print("FAVORITE action")
    }
    @objc private func didSelectShare(_ sender: NSNotification) {
        let webService = WebService()
        displayShareSheet(shareContent: movie.title + " - " + webService.getFullUrl(movie.poster_path))
    }
 
    // MARK: - Share Sheet Helper
    private func displayShareSheet(shareContent:String) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
    }
}
