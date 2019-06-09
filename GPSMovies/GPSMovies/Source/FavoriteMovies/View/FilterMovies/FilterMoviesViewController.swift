//
//  FilterMoviesViewController.swift
//  GPSMovies
//
//  Created by Gilson Santos on 09/06/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

import UIKit


//MARK: - DELEGATE  -
protocol FilterMoviesDelegate: NSObjectProtocol {
    func applyFilter(endDate: Date?, genre: GenreViewData?)
}

class FilterMoviesViewController: UIViewController {
    // MARK: OUTLETS
    @IBOutlet weak var pickerViewGenre: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var buttonSearch: UIButton!
    
    // MARK: VARIABLES
    lazy var genreList = [GenreViewData]()
    weak var delegate: FilterMoviesDelegate?
    private var dateSelected: Date?
    private var genreSelected: GenreViewData?
    
    // MARK: IBACTIONS
    @IBAction func selectedDate(_ sender: UIDatePicker) {
        self.dateSelected = sender.date
        self.buttonSearch.isEnableButton(true)
    }
    
    @IBAction func filterAction(_ sender: Any) {
        HapticAlert.hapticReturn(style: .medium)
        self.buttonSearch.pulseAnimation(scaleX: 0.8, scaleY: 0.8, timer: 0, alpha: nil, nil)
        self.delegate?.applyFilter(endDate: self.dateSelected, genre: self.genreSelected)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: UIButton) {
        HapticAlert.hapticReturn(style: .medium)
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - LIFE CYCLE -
extension FilterMoviesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupButton()
    }
}

// MARK: - DATASOURCE UIPickerViewDataSource -
extension FilterMoviesViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.genreList.count
    }
}

// MARK: - DELEGATE UIPickerViewDelegate -
extension FilterMoviesViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let label = row == 0 ? "Todos" : self.genreList[row].name
        let attributedString = NSAttributedString(string: label, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            self.genreSelected = GenreViewData(id: 0, name: "Todos")
        }else {
            self.genreSelected = self.genreList[row]
        }
        self.buttonSearch.isEnableButton(true)
    }
}

// MARK: - AUX METHODS -
extension FilterMoviesViewController {
    private func setupView() {
        self.buttonSearch.isEnableButton(false)
        self.datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        self.datePicker.setValue(false, forKey: "highlightsToday")
    }
    
    private func setupButton() {
        self.buttonSearch.layer.cornerRadius = self.buttonSearch.bounds.height / 2
    }
}
