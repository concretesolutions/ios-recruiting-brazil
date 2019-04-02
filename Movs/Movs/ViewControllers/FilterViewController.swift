//
//  FilterViewController.swift
//  Movs
//
//  Created by Alexandre Papanis on 01/04/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import UIKit

protocol FilterDelegate {
    func selectGenre(genre: String)
    func selectDate(date: String)
}

class FilterViewController: UIViewController, FilterDelegate {
    
    //MARK: Variables
    let filters: [String] = ["Date", "Genres"]
    var favoriteDelegate: FavoriteDelegate!
    var dateSelected: String = ""
    var genreSelected: String = ""
    
    //MARK: IB Outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func doFilter(_ sender: UIBarButtonItem) {
        favoriteDelegate.doFilter(genre: genreSelected, date: dateSelected)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    
    //MARK: FilterDelegate methods
    func selectGenre(genre: String) {
        genreSelected = genre
        tableView.reloadData()
    }
    
    func selectDate(date: String) {
        dateSelected = date
        tableView.reloadData()
    }
    
    //MARK: Prepare segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GenreFilterViewController {
            vc.filterDelegate = self
            vc.genreSelected = genreSelected
        }
        if let vc = segue.destination as? DateFilterViewController {
            vc.filterDelegate = self
            vc.dateSelected = dateSelected
        }
    }
    
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: UITableView protocol stubs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as! FilterCell
        
        cell.lbTitle.text = filters[indexPath.row]
        if indexPath.row == 0 {
            cell.lbDetail.text = dateSelected
        }
        
        if indexPath.row == 1 {
            cell.lbDetail.text = genreSelected
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            performSegue(withIdentifier: "showDateFilter", sender: nil)
        }
        
        if indexPath.row == 1 {
            performSegue(withIdentifier: "showGenreFilter", sender: nil)
        }
    }
}
