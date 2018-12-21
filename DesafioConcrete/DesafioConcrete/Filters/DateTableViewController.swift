//
//  DateTableViewController.swift
//  DesafioConcrete
//
//  Created by Ian Manor on 18/12/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import UIKit

class DateTableViewController: UITableViewController {
    
    var dates: [Int] = []
    var previouslyChosen: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        let date = Date()
        let yearString = dateFormatter.string(from: date)
        let maxYear = Int(yearString)! + 2
        dates = Array(1895...maxYear).reversed()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let savedDate = FilterSettings.shared.date {
            for (offset, date) in dates.enumerated() {
                if String(date) == savedDate {
                    previouslyChosen = IndexPath(row: offset, section: 0)
                }
            }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath) as! DateTableViewCell

        cell.dateLabel.text = String(dates[indexPath.row])
        
        if indexPath == previouslyChosen {
            cell.selectedImageView.isHidden = false
        } else {
            cell.selectedImageView.isHidden = true
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let previouslyChosen = previouslyChosen {
            if let previouslySelectedCell = tableView.cellForRow(at: previouslyChosen) as? DateTableViewCell {
                previouslySelectedCell.selectedImageView.isHidden = true
            }
        }
        
        let currentlySelectedCell = tableView.cellForRow(at: indexPath) as! DateTableViewCell
        currentlySelectedCell.selectedImageView.isHidden = false
        
        FilterSettings.shared.date = String(dates[indexPath.row])

        if previouslyChosen == indexPath {
            currentlySelectedCell.selectedImageView.isHidden = true
            FilterSettings.shared.date = nil
            previouslyChosen = nil
        } else {
            previouslyChosen = indexPath
        }
    }

}
