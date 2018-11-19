//
//  PopularMoviesTableViewController.swift
//  Movs
//
//  Created by Adann Simões on 14/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

struct CustomSegueSender {
    var result: Result?
    var behavior: DescriptionBehavior
}

class PopularViewController: UITableViewController {
    // MARK: Behavior View IBOutlets
    @IBOutlet var emptySearchView: UIView!
    @IBOutlet var genericErrorView: UIView!
    @IBOutlet var loadingView: UIView!

    // MARK: Class Attributes
    var popularMovie: PopularMovie?
    var favorite = Favorite()
    var behavior: Behavior = .LoadingView {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    let popularMovieCellIdentifier = "popularCell"
    let popularToDescriptionSegue = "PopularToDescription"
    let heightForRow = CGFloat(200.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSetup()
    }
    
    func dataSetup() {
        tableView.tableFooterView = UIView()
        fetchPopularMovieData(page: 1) { (popular) -> Void in
            if let data = popular {
                self.popularMovie = data
                self.setBehavior(newBehavior: .Success)
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if popularMovie != nil {
            return 1
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRows = popularMovie?.results?.count {
            return numberOfRows
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: popularMovieCellIdentifier,
                                                 for: indexPath) as? PopularTableViewCell
        if let data = popularMovie?.results?[indexPath.row] {
            isFavorite(result: data, completionHandler: { (status) in
                cell?.setData(data: data, popularRanking: (indexPath.row + 1), isFavorite: status)
            })
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = popularMovie?.results?[indexPath.row] {
            isFavorite(result: data, completionHandler: { (favorite) in
                var customSender: CustomSegueSender?
                if favorite {
                    customSender = CustomSegueSender(result: data, behavior: .Favorite)
                } else {
                    customSender = CustomSegueSender(result: data, behavior: .Normal)
                }
                
                self.performSegue(withIdentifier: self.popularToDescriptionSegue, sender: customSender)
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueData = sender as? CustomSegueSender else { return }
        if let vc = segue.destination as? DescriptionViewController {
            vc.result = segueData.result
            vc.behavior = segueData.behavior
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }

}

// MARK: Frufru setup
extension PopularViewController {
    private func setBehavior(newBehavior: Behavior) {
        behavior = newBehavior
        switch behavior {
        case .Success:
            tableView.backgroundView = UIView()
        case .EmptySearch:
            tableView.backgroundView = emptySearchView
        case .LoadingView:
            tableView.backgroundView = loadingView
        case .GenericError:
            tableView.backgroundView = genericErrorView
        }
    }
}

// MARK: Service call
extension PopularViewController {
    private func fetchPopularMovieData(page: Int, completionHandler: @escaping (PopularMovie?) -> Void) {
        setBehavior(newBehavior: .LoadingView)
        PopularMovieServices.getPopularMovie(page: page) { (data, _) in
            if data != nil {
                completionHandler(data)
            } else {
                self.setBehavior(newBehavior: .GenericError)
                completionHandler(nil)
            }
        }
    }
    
    private func isFavorite(result: Result, completionHandler: @escaping (Bool) -> Void) {
        FavoriteServices.getAllFavorite { (_, data) in
            guard let status = data?.filter({ (fav) -> Bool in
                return Int(fav.id) == result.id
            }).isEmpty else {return}
            completionHandler(!status)
        }
    }
}
