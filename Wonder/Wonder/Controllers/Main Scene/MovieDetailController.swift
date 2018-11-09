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
        tableStructure.append("DetailTitleCell")
        tableStructure.append("DetailInfoCell")
        tableStructure.append("DetailDescriptionCell")
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
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: tableStructure[indexPath.row]) as! DetailTitleCell
            cell.backgroundColor = UIColor.clear
            cell.detailTitle.text = movie.title
            return cell
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: tableStructure[indexPath.row]) as! DetailInfoCell
            cell.backgroundColor = UIColor.clear
            cell.detailInfo.text = releaseYear() + genreDisplay(genreIdArray: movie.genre_ids)
            return cell
        }else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: tableStructure[indexPath.row]) as! DetailDescriptionCell
            if movie.overview.isEmpty {
               cell.detailDescription.text = ""
            }else{
               cell.detailDescription.text = movie.overview
            }
            
            return cell

        }
        return UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    // MARK: - UI Actions
    @IBAction func closeView(_ sender: Any) {
        print(".........")
        self.dismiss(animated: true, completion: nil)
//        navigationController?.dismiss(animated: true, completion: nil)
//        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    // MARK: - Status Bar Helper
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    // MARK: - Helpers
    private func releaseYear() -> String {
        let releaseDate = movie.release_date.components(separatedBy: "-")
        let year = String(describing: releaseDate[0])
        
        if !year.isEmpty{
            return "℗ " + year + "  "
        }else{
            return ""
        }
    }
    
    private func genreDisplay(genreIdArray:[Int]) -> String{
        
        var resultString = ""
        for genreId in genreIdArray {
            resultString = resultString + " ⚐ " + AppSettings.standard.getDefualtsCategory(id: genreId)
        }
        return resultString
    }
    
    
}
