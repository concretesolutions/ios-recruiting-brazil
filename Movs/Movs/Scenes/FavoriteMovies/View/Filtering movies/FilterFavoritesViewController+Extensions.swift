//
//  FilterFavoritesViewController+Extensions.swift
//  Movs
//
//  Created by Maisa on 01/11/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

// MARK: - UIPicker
extension FilterFavoritesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count == 0 ? 0 : years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return years[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentlyYear = years[row]
    }
    
}
// MARK: - Table View
extension FilterFavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    // Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count == 0 ? 0 : genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = genres[indexPath.row]
        
        return cell
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedElement = genres[indexPath.row]
        currentlyGenres.append(selectedElement)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedElement = genres[indexPath.row]
        currentlyGenres.removeAll { (element) -> Bool in
            element == selectedElement
        }
    }
    
}
