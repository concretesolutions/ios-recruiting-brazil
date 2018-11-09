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
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = movie.title
        
        let imageView = UIImageView()
        imageView.image = movieImage
        imageView.frame = view.bounds
        imageView.contentMode = .scaleToFill
        
        ///
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = imageView.bounds
        imageView.addSubview(blurredEffectView)
        
        tableView.backgroundView = imageView
        
    }
    
    private func loadTableStructure() {
        tableStructure.append("DetailImageCell")
    }
    
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableStructure.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: tableStructure[indexPath.row]) as! DetailImageCell
            cell.backgroundColor = UIColor.clear
            cell.detailPoster.image = movieImage
//            cell.detailImageView.image = movieImage
//            ///
//            let blurEffect = UIBlurEffect(style: .dark)
//            let blurredEffectView = UIVisualEffectView(effect: blurEffect)
//            blurredEffectView.frame = cell.detailImageView.bounds
//            cell.detailImageView.addSubview(blurredEffectView)
            ///
            return cell
        }
        return UITableViewCell()
    }
    
}
