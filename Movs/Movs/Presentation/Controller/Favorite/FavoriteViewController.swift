//
//  FavoriteTableViewController.swift
//  Movs
//
//  Created by Adann Simões on 18/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

enum FavoriteBehavior {
    case All
    case Filtering
    case GenericError
}

class FavoriteViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var removeFilterConstraint: NSLayoutConstraint!
    
    var favorite: [Favorite]?
    var filterApplied: Filter?
    let favoriteCellIdentifier = "favoriteCell"
    let favoriteToDescriptionSegue = "favoriteToDescription"
    var behavior: FavoriteBehavior = .All {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    let heightForRow = CGFloat(200.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        if behavior == .All {
            fetchFavorite()
        }
    }

    
    
    
    @IBAction func removeFilterButtonAction(_ sender: UIButton) {
        setBehavior(newBehavior: .All)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DescriptionViewController {
            vc.data = sender as? Favorite
            vc.behavior = .Favorite
        } else if let vc = segue.destination as? FilteringViewController {
            guard let favorite = favorite else { return }
            vc.favorite = favorite
            vc.delegate = self
        }
        
    }
    
}

// MARK: Data setup
extension FavoriteViewController {
    private func initialSetup() {
        tableView.tableFooterView = UIView()
        removeFilterConstraint.constant = 0
        fetchFavorite()
    }
    
    private func fetchFavorite() {
        // Get all favorite movies
        FavoriteServices.getAllFavorite { (error, favoriteList) in
            if error == nil {
                guard let data = favoriteList else {return}
                self.favorite = data
                self.behavior = .All
                self.tableView.reloadData()
            } else {
                self.setBehavior(newBehavior: .GenericError)
            }
        }
    }
    
    private func setBehavior(newBehavior: FavoriteBehavior) {
        behavior = newBehavior
        switch behavior {
        case .GenericError:
            tableView.backgroundView = UIView()
        case .All:
            removeFilterConstraint.constant = 0
        case .Filtering:
            removeFilterConstraint.constant = 44
        }
    }
}

// MARK: Filter Setup
extension FavoriteViewController {
    func getFilteredFavorite() -> [Favorite]? {
        var favoriteFiltered = [Favorite]()
        
        if let data = favorite,
            let genreFiltered = filterApplied?.genre?.first {
            
            let favoritesWithGenreFilter = data.filter { (fav) -> Bool in
                guard let genres = fav.genres else { return false }
                return genres.contains(genreFiltered)
            }
            
            if !favoritesWithGenreFilter.isEmpty {
                favoriteFiltered.append(contentsOf: favoritesWithGenreFilter)
            }
        }
        
        if let data = favorite,
            let yearFiltered = filterApplied?.year?.first {
            
            let favoritesWithYearFilter = data.filter { (fav) -> Bool in
                guard let date = fav.releaseDate else { return false }
                let year = transformDateInYear(date as Date)
                return year == yearFiltered
            }
            
            if !favoritesWithYearFilter.isEmpty {
                favoriteFiltered.append(contentsOf: favoritesWithYearFilter)
            }
        }
        
        return favoriteFiltered
    }
    
    private func transformDateInYear(_ date: Date) -> Int {
        let myCalendar = Calendar(identifier: .gregorian)
        let year = myCalendar.component(.year, from: date)
        return year
    }
}

// MARK: Tableview Data source
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: favoriteCellIdentifier) as? FavoriteTableViewCell
        
        switch behavior {
        case .All:
            if let data = favorite?[indexPath.row] {
                cell?.setData(data: data)
            }
        case .Filtering:
            if let filteredData = getFilteredFavorite() {
                cell?.setData(data: filteredData[indexPath.row])
            }
        default:
            break
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch behavior {
        case .All:
            guard let numberOfRows = favorite?.count else { return 0 }
            return numberOfRows
        case .Filtering:
            guard let numberOfRows = getFilteredFavorite()?.count else { return 0 }
            return numberOfRows
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch behavior {
        case .All:
            if let data = favorite?[indexPath.row] {
                performSegue(withIdentifier: favoriteToDescriptionSegue, sender: data)
            }
        case .Filtering:
            if let data = getFilteredFavorite() {
                performSegue(withIdentifier: favoriteToDescriptionSegue, sender: data[indexPath.row])
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            switch behavior {
            case .All:
                if let data = favorite?[indexPath.row] {
                    deleteFavorite(data: data)
                    self.favorite?.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    tableView.layoutIfNeeded()
                }
            case .Filtering:
                if let data = getFilteredFavorite() {
                    deleteFavorite(data: data[indexPath.row])
                    tableView.layoutIfNeeded()
                    self.favorite?.removeAll(where: { (fav) -> Bool in
                        fav.id == data[indexPath.row].id
                    })
                }
                tableView.reloadData()
            default:
                break
            }
        default:
            return
        }
    }
    
}

// MARK: Service call
extension FavoriteViewController {
    private func deleteFavorite(data: Favorite) {
        FavoriteServices.deleteFavorite(favorite: data) { (_, error) in
            self.tableView.reloadData()
            if let err = error {
                self.customAlert(title: "Erro",
                                 message: "Não foi possível deletar este filme favoritado.",
                                 actionTitle: "Ok")
                print(err.localizedDescription)
            }
        }
    }
}

// MARK: Delegate
extension FavoriteViewController: FilteringDelegate {
    func setFilter(_ filter: Filter) {
        filterApplied = filter
        setBehavior(newBehavior: .Filtering)
    }
}
