//
//  FilterFavoriteViewController.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 26/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

class FilterFavoriteViewController: UIViewController, FilterFavoriteView {
    
    //MARK: - Outlets
    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    //MARK: - Contract Properties
    var presenter: FilterFavoritePresentation!
    
    //MARK: - Properties
    var movies: [MovieEntity] = []
    var movieFilterStrings: [String] = []
    var dateFilter: String = ""
    var genreFilter: String = ""
    
    //MARK: - View Start Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        adjustConstraints()
        
        applyFilterButton.backgroundColor = ColorPalette.paleYellow.uiColor
        applyFilterButton.titleLabel?.textColor = ColorPalette.textGray.uiColor
        applyFilterButton.isEnabled = false
        
        pickerView.isHidden = true
        pickerView.backgroundColor = .lightGray
        
        
    }
    
    //MARK: - Contract Functions
    func showAvaliableFilters(movies: [MovieEntity]) {
        self.movies = movies
    }
    
    func adjustConstraints() {
        filterTableView.translatesAutoresizingMaskIntoConstraints = false
        applyFilterButton.translatesAutoresizingMaskIntoConstraints = false
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Filter table view constraints
        if let filterTableView = self.filterTableView {
            self.view.addConstraints([
                NSLayoutConstraint(item: filterTableView, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: filterTableView, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: filterTableView, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: filterTableView, attribute: .bottom, relatedBy: .equal, toItem: applyFilterButton, attribute: .top, multiplier: 1.0, constant: 0)
                ])
        }
        
        //MARK: Apply filter button constraints
        if let applyFilterButton = self.applyFilterButton {
            self.view.addConstraints([
                NSLayoutConstraint(item: applyFilterButton, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: applyFilterButton, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: applyFilterButton, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: applyFilterButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 70)
                ])
        }
        
        //MARK: Picker view button constraints
        if let pickerView = self.pickerView {
            self.view.addConstraints([
                NSLayoutConstraint(item: pickerView, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: pickerView, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: pickerView, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: pickerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 200)
                ])
        }
        
        self.view.updateConstraints()
    }
    
    //MARK: - Functions
    @IBAction func didClickApplyFilter(_ sender: UIButton) {
        if sender.isEnabled {
            let dict: Dictionary<String, String> = ["Date" : dateFilter, "Genre" : genreFilter]
            presenter.didEnterFilters(dict)
        }
    }
    
}

//MARK: - Table View Extension Functions
extension FilterFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath)
        
        // Date cell
        if indexPath.row == 0 {
            cell.textLabel?.text = "Date"
            cell.detailTextLabel?.text = self.dateFilter
        }
        // Genre cell
        else if indexPath.row == 1 {
            cell.textLabel?.text = "Genres"
            cell.detailTextLabel?.text = self.genreFilter
        }
        
        cell.detailTextLabel?.textColor = ColorPalette.darkYellow.uiColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieFilterStrings = []
        
        // Date cell
        if indexPath.row == 0 {
            for item in self.movies {
                if !movieFilterStrings.contains(item.formatDateString()) {
                    movieFilterStrings.append(item.formatDateString())
                }
            }
            
        }
        // Genre cell
        else if indexPath.row == 1 {
            if let genres = GenresEntity.getAllGenres() {
                for item in genres{
                    movieFilterStrings.append(item.name!)
                }
            }
        }
        if movieFilterStrings.count > 0 {
            self.pickerView.reloadAllComponents()
            self.pickerView.selectRow(0, inComponent: 0, animated: false)
            self.pickerView.isHidden = false
        }
    }
    
}

extension FilterFavoriteViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return movieFilterStrings.count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return ""
        }
        else {
            return movieFilterStrings[row - 1]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row != 0 {
            if filterTableView.cellForRow(at: IndexPath(row: 0, section: 0))!.isSelected {
                dateFilter = movieFilterStrings[row - 1]
            }
            else {
                genreFilter = movieFilterStrings[row - 1]
            }
            filterTableView.reloadData()
        }
        
        pickerView.isHidden = true
        
        if dateFilter != "" || genreFilter != "" {
            applyFilterButton.isEnabled = true
        }
    }
    
}
