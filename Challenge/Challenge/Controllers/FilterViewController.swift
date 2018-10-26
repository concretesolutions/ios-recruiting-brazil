//
//  FilterViewController.swift
//  Challenge
//
//  Created by Sávio Berdine on 25/10/18.
//  Copyright © 2018 Sávio Berdine. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    
    var picker1 = UIPickerView()
    var picker2 = UIPickerView()
    var genres: [Genre] = []
    var years: [Int] = [1971, 1972, 1973, 1974, 1975, 1976, 1977, 1978, 1979, 1980, 1981, 1982, 1983, 1984, 1985, 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker1.delegate = self
        self.picker1.dataSource = self
        self.picker2.delegate = self
        self.picker2.dataSource = self
        
        self.yearTextField.addBottomBorderWithColor(color: .black, width: 1)
        self.genreTextField.addBottomBorderWithColor(color: .black, width: 1)
        self.yearTextField.inputView = picker1
        self.genreTextField.inputView = picker2
        
        if !Genre.currentGenres.isEmpty {
            self.genres = Genre.currentGenres
        } else {
            Genre.getCurrentGenres(onSuccess: { (genresResult) in
                Genre.currentGenres = genresResult
                self.genres = genresResult
                self.picker2.reloadAllComponents()
            }) { (error) in
                print(error)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.picker1 {
            return (self.years.count)
        } else {
            return (self.genres.count)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.picker1 {
            if row == 0 {
                return "Selecione"
            } else {
                return String(describing: self.years[row])
            }
        } else {
            if row == 0 {
                return "Selecione"
            } else {
                return self.genres[row].name
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.picker1 {
            if row == 0 {
                print("Selecione")
                self.yearTextField.text = "Selecione"
                Filter.filterState.year = ""
            } else {
                self.yearTextField.text = String(describing: self.years[row])
                Filter.filterState.year = String(describing: self.years[row])
            }
        } else {
            if !genres.isEmpty {
                if row == 0 {
                    print("Selecione")
                    self.genreTextField.text = "Selecione"
                    Filter.filterState.genre = ""
                } else {
                    self.genreTextField.text = self.genres[row].name
                    Filter.filterState.genre = self.genres[row].name
                }
            }
        }
    }
    
    @IBAction func apply(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        FavoritesViewController.filterIsActive = true
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        Filter.filterState.genre = ""
        Filter.filterState.year = ""
        FavoritesViewController.filterIsActive = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
