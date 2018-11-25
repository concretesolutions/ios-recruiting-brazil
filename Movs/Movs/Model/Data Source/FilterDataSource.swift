//
//  FilterDataSource.swift
//  Movs
//
//  Created by Julio Brazil on 25/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit

private let reuseIdentifier = "filterCell"

extension FilterTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.yearFilter.count
        case 1:
            return self.genreFilter.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        switch indexPath.section {
        case 0:
            let filterInfo = self.yearFilter.enumerated().first { (offset, _) -> Bool in
                return offset == indexPath.row
                }?.1
            guard let yearInfo = filterInfo else { return cell }
            
            cell.textLabel?.text = yearInfo.0
            cell.imageView?.image = UIImage(named: "check_icon")!
            cell.imageView?.isHidden = !yearInfo.1
            
        case 1:
            let filterInfo = self.genreFilter.enumerated().first { (offset, _) -> Bool in
                return offset == indexPath.row
                }?.1
            guard let genreInfo = filterInfo else { return cell }
            
            cell.textLabel?.text = genreInfo.0
            cell.imageView?.image = UIImage(named: "check_icon")!
            cell.imageView?.isHidden = !genreInfo.1
            
        default:
            fatalError("There is no such thing as a section number \(indexPath.section)")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let filterInfo = self.yearFilter.enumerated().first { (offset, _) -> Bool in
                return offset == indexPath.row
                }?.1
            guard let yearInfo = filterInfo else { return }
            
            let value = !yearInfo.1
            self.yearFilter[yearInfo.0] = value
        case 1:
            let filterInfo = self.genreFilter.enumerated().first { (offset, _) -> Bool in
                return offset == indexPath.row
                }?.1
            guard let genreInfo = filterInfo else { return }
            
            let value = !genreInfo.1
            self.genreFilter[genreInfo.0] = value
        default:
            fatalError("Absurd scenario, selected row \(indexPath.row) in section \(indexPath.section)")
        }
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Year of launch" : "Gender"
    }
}
