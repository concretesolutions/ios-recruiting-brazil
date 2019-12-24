//
//  FavoriteMoviesFiltersViewController+UIPickerView.swift
//  Movs
//
//  Created by Gabriel D'Luca on 21/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

extension FavoriteMoviesFiltersViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row > self.viewModel.numberOfYears - 1 { return "Any" }
        
        let title = self.viewModel.yearTitleForRow(at: row)
        if title == "1970" {
            return "⩽ 1970"
        }
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 32.0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row > self.viewModel.numberOfYears - 1 {
            self.selectedYear = "Any"
        } else {
            self.selectedYear = self.viewModel.yearTitleForRow(at: row)
        }
    }
}

extension FavoriteMoviesFiltersViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModel.numberOfYears + 1
    }
}
