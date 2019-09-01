//
//  FilterController.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import UIKit

class FilterController: UIViewController{
    let screen = FilterView()
    let viewModel = FilterViewModel()
    
    override func viewDidLoad() {
        navigationItem.title = "Filters"
        
        self.view = screen
        screen.picker.delegate = self
        screen.picker.dataSource = self
        screen.applyButton.addTarget(self, action: #selector(filterResults), for: .touchUpInside)
    }
    
    @objc func filterResults(){
        viewModel.delegate?.getFiltersData(filters: viewModel.results)
        navigationController?.popViewController(animated: true)
    }
}





//MARK: -  Picker Methods
extension FilterController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return viewModel.filters.count
    }
    
    //The components items count
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 1 {
            return viewModel.genres.count
        }else{
            return viewModel.years.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let atribute = [NSAttributedString.Key.foregroundColor: UsedColors.gold.color]
        
        if component == 1 {
            let value = viewModel.genres[row]
            let title = NSMutableAttributedString(string: value, attributes: atribute)
            return title
        }else{
            let value = viewModel.years[row]
            let title = NSMutableAttributedString(string: value, attributes: atribute)
            return title
        }
    }
    
    //Populate the picker with the data
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 1 {
            return viewModel.genres[row]
        }else{
            return viewModel.years[row]
        }
        
    }
    
    //Populate the results with the data selected in the picker
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 {
            viewModel.results[component] = viewModel.genres[row]
        }else{
            viewModel.results[component] = viewModel.years[row]
        }
    }
}
