//
//  FitlerItemsViewController.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 04/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import UIKit

enum ItemType {
    case date, genre
}

protocol FilterItemsDelegate {
    func set(date: Date?)
    func set(genre: Genre?)
}

class FilterItemsViewController: UIViewController {

    class var identifier: String {
        return "FilterItemsViewController"
    }
    
    class func instatiate(type: ItemType) -> FilterItemsViewController {
        let vc = UIStoryboard.filterStoryboard.instantiateViewController(withIdentifier: identifier) as! FilterItemsViewController
        vc.type = type
        return vc
    }
    
    var type: ItemType! {
        didSet {
            if type == .date {
                var newDates: [Date] = []
                for date in FavoriteHelper.getFavorites().compactMap({ $0.releaseDate }) {
                    if !newDates.contains(where: { (iDate) -> Bool in
                        return iDate.yearString == date.yearString
                    }) {
                        newDates.append(date)
                    }
                }
                dates = newDates.sorted(by: >)
            } else {
                genres = GenrePersistanceHelper.getGenre()
            }
        }
    }
    
    var genres: [Genre] = []
    var currentlySelectedGenre: Genre?
    var dates: [Date] = []
    var currentlySelectedDate: Date?
    var delegate: FilterItemsDelegate?
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
    }
}

extension FilterItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type! {
        case .date:
            return dates.count
        default:
            return genres.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: "reusableCell") {
            cell = reusableCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reusableCell")
        }
        cell.accessoryView?.tintColor = UIColor.moviesAppYellow
        cell.textLabel?.textColor = UIColor.moviesAppBlack
        
        switch type! {
        case .date:
            cell.textLabel?.text = dates[indexPath.row].yearString
            if currentlySelectedDate?.yearString == dates[indexPath.row].yearString {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        default:
            cell.textLabel?.text = genres[indexPath.row].name
            if currentlySelectedGenre?.name == genres[indexPath.row].name {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch type! {
        case .date:
            if currentlySelectedDate?.yearString == dates[indexPath.row].yearString {
                currentlySelectedDate = nil
                delegate?.set(date: nil)
            } else {
                currentlySelectedDate = dates[indexPath.row]
                delegate?.set(date: dates[indexPath.row])
            }
        default:
            
            if currentlySelectedGenre?.name == genres[indexPath.row].name {
                currentlySelectedGenre = nil
                delegate?.set(genre: nil)
            } else {
                currentlySelectedGenre = genres[indexPath.row]
                delegate?.set(genre: genres[indexPath.row])
            }
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
