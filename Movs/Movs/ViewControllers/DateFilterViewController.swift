//
//  YearFilterViewController.swift
//  Movs
//
//  Created by Alexandre Papanis on 01/04/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import UIKit
import CoreData

protocol DateCellDelegate {
    func selectDate(date: String)
}

class DateFilterViewController: UIViewController, DateCellDelegate {
    
    //MARK: Variables
    var filterDelegate: FilterDelegate!
    var dateSelected: String = ""
    
    var dates: [String] = []
    var uniqueDates: [String] = []
    
    //MARK: IB Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        getDateOfMovies()
        tableView.reloadData()

        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    //MARK: other methods
    func selectDate(date: String) {
        if(self.filterDelegate != nil){ //Just to be safe.
            self.filterDelegate.selectDate(date: date)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    fileprivate func getDateOfMovies(){
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(FavoriteMovie.year), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do{
            let favoriteMovies = try PersistenceService.context.fetch(fetchRequest)
            
            for favoriteMovie in favoriteMovies {
                dates.append(favoriteMovie.year!)
            }
            
            uniqueDates = Array(Set(dates))
            
        } catch {
            print("Error while fetching FavoriteMovie")
        }
    }

}

extension DateFilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: UITableViewController stubs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uniqueDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell") as! DateCell
        
        cell.textLabel?.text = uniqueDates[indexPath.row]
        cell.delegate = self
        
        if dateSelected == uniqueDates[indexPath.row] {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if dateSelected == uniqueDates[indexPath.row]{
            dateSelected = ""
            selectDate(date: dateSelected)
        } else {
            dateSelected = uniqueDates[indexPath.row]
            selectDate(date: dateSelected)
        }
        
    }
    
    
}
