//
//  YearGenreFilterViewController.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 20/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

class YearGenreFilterViewController: UIViewController {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    private(set) var genreFilter: Int?
    private(set) var yearFilter: String?
    
    var favoriteMovies: [Movie] = []
    
    // Public Methods
    
    var doneBlock: (() -> Void)?
    
    // Initialisation/Lifecycle Methods
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initController()
    }
    
    deinit {
        favoriteMovies = []
    }
    
    // Override Methods
    
    override func viewWillAppear(_ animated: Bool) {
        genreFilter = nil
        yearFilter = nil
        
        years = []
        years.append("None")
        
        favoriteMovies.sorted(by: { (a, b) -> Bool in
            if let movieDateA = a.releaseDate {
                if let movieDateB = b.releaseDate {
                    return movieDateA < movieDateB
                }
            }
            return false
        }).forEach { (movie) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            if let movieDate = movie.releaseDate {
                let year = dateFormatter.string(from: movieDate)
                if !self.years.contains(year) {
                    self.years.append(year)
                }
            }
        }
        
        genres = []
        self.genres.append((-1, "None"))
        
        Genres.list.sorted(by: { (a, b) -> Bool in
            a.value < b.value
        }).forEach { (genre) in
            if favoriteMovies.contains(where: { $0.genreIds.contains(genre.key)} ) {
                self.genres.append(genre)
            }
        }
        
        filterView.yearFilterPickerView.reloadAllComponents()
        filterView.genresFilterPickerView.reloadAllComponents()
        
        filterView.yearFilterPickerView.selectRow(0, inComponent: 0, animated: true)
        filterView.genresFilterPickerView.selectRow(0, inComponent: 0, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        favoriteMovies = []
        doneBlock?()
    }
    
    // Private Types
    // Private Properties
    
    private var filterView: YearGenreFilterView {
        return self.view as! YearGenreFilterView
    }
    
    private var years: [String] = []
    private var genres: [(Int, String)] = []
    
    // Private Methods
    
    private func initController() {
        self.view = YearGenreFilterView()
        
        filterView.yearFilterPickerView.dataSource = self
        filterView.yearFilterPickerView.delegate = self
        filterView.genresFilterPickerView.dataSource = self
        filterView.genresFilterPickerView.delegate = self
        
        filterView.doneButton.addTarget(self, action: #selector(didTouchDoneButton), for: .touchUpInside)
        navigationItem.rightBarButtonItem = filterView.doneBarButtonItem
    }
    
    @objc private func didTouchDoneButton() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension YearGenreFilterViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case filterView.yearFilterPickerView:
            return self.years.count
            
        case filterView.genresFilterPickerView:
            return self.genres.count
            
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case filterView.yearFilterPickerView:
            return self.years[row]
            
        case filterView.genresFilterPickerView:
            return self.genres[row].1
            
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case filterView.yearFilterPickerView:
            if row == 0 {
                self.yearFilter = nil
            }
            else {
                self.yearFilter = self.years[row]
            }
            
        case filterView.genresFilterPickerView:
            if row == 0 {
                genreFilter = nil
            }
            else {
                self.genreFilter = self.genres[row].0
            }
            
        default:
            do { /* Nothing */ }
        }
    }
}
