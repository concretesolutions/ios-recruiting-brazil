//
//  FilterTableViewController.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 02/11/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit
import SnapKit

class FilterTableViewController: UITableViewController {

  // MARK: Types
  
  enum FilterSelected {
    case year
    case genre
    case none
  }
  
  // MARK: Properties
  
  var years = ["None"]
  
  var genres: [Genre?] = [nil]
  
  var genresIds: [Int] = []
  
  var currentFilterSelect: FilterSelected = .none
  
  var filterDelegate: FilterTableViewControllerDelegate!
  
  var genreSelectedIndex: Int = 0
  
  var yearSelectedIndex: Int = 0
  
  var selectedYear: Int?
  
  var selectedGenre: Genre?
  
  @IBOutlet weak var selectedYearLabel: UILabel!
  
  @IBOutlet weak var selectedGenreLabel: UILabel!
  
  lazy var endEditingBarButtonItem: UIBarButtonItem = {
    return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(endEditing))
  }()
  
  let pickerView: UIPickerView = {
    let pickerView = UIPickerView(frame: CGRect(x: 0, y: 200, width: 100, height: 100))
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    pickerView.showsSelectionIndicator = true
    pickerView.backgroundColor = UIColor.paleGrey.withAlphaComponent(0.1)
    return pickerView
  }()

  // MARK: Filter methods
  
  func setFilterValue() {
    if currentFilterSelect != .none {
      let value = pickerView.selectedRow(inComponent: 0)
      
      if currentFilterSelect == .genre {
        genreSelectedIndex = value
        selectedGenreLabel.text = value == 0 ? "" : genres[value]!.name
      } else {
        yearSelectedIndex = value
        selectedYearLabel.text = value == 0 ? "" : years[value]
      }
    }
  }
  
  @objc func endEditing() {
    setFilterValue()
    hidePickeView()
    currentFilterSelect = .none
    tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isSelected = false
    tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.isSelected = false
  }
  
  // MARK: Networking
  
  public func getGenres() {
    NetworkClient.shared.getGenres { (result) in
      switch result {
      case .success(let fetchedGenres):
        var newGenres: [Genre] = []
        self.genresIds.forEach({ (identificator) in
          fetchedGenres.forEach({ (fetchedGenre) in
            if fetchedGenre.identificator == identificator {
              newGenres.append(fetchedGenre)
            }
          })
        })
        
        self.genres.append(contentsOf: newGenres.sorted { $0.name < $1.name })
      case .failure:
        print("Error")
      }
    }
  }
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getGenres()
    
    if let genre = selectedGenre {
      for (index, aGenre) in genres.enumerated() where aGenre?.name == genre.name {
          genreSelectedIndex = index
      }
      selectedGenreLabel.text =  genre.name
    } else {
      selectedGenreLabel.text = ""
    }
    
    if let year = selectedYear {
      for (index, anYear) in years.enumerated() where year == Int(anYear) {
        yearSelectedIndex = index
      }
      
      selectedYearLabel.text = "\(year)"
    } else {
      selectedYearLabel.text = ""
    }
    
    tableView.tableFooterView = UIView()
    print(genresIds)
    setupPickerView()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    hidePickeView()
    filterDelegate.didChangeFilterValues(Int(years[yearSelectedIndex]), selectedGenre: genres[genreSelectedIndex])
  }
  
  // MARK: Table view delegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    setFilterValue()
    let row: Int
    switch indexPath.row {
    case 0:
      currentFilterSelect = .year
      row = yearSelectedIndex
    case 1:
      currentFilterSelect = .genre
      row = genreSelectedIndex
    default:
      fatalError("Invalid cell")
    }
    
    pickerView.selectRow(row, inComponent: 0, animated: false)
    pickerView.reloadAllComponents()
    showPickerView()
  }
  
}

/////////////////////////////////////////
//
// MARK: Picker view delegate and data source
//
/////////////////////////////////////////
extension FilterTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if currentFilterSelect == .genre {
      return genres.count
    }
    
    return years.count
  }

  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    var label: UILabel
    if let view = view as? UILabel {
      label = view
    } else {
      label = UILabel()
    }
    
    if currentFilterSelect == .genre {
      label.text = row == 0 ? "None" : genres[row]!.name
    } else {
      label.text = years[row]
    }
    
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
    label.textColor = .orangePizazz
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.5
    label.isUserInteractionEnabled = true
    
    return label
  }
  
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 35
  }

  func setupPickerView() {
    navigationController?.view.addSubview(pickerView)
    pickerView.delegate = self
    pickerView.dataSource = self
    
    pickerView.snp.makeConstraints { make in
      make.left.right.equalToSuperview()
      make.bottom.equalToSuperview().offset(200)
      make.height.equalTo(200)
    }
    
    pickerView.isHidden = true
    navigationController?.view.layoutIfNeeded()
  }
  
  func showPickerView() {
    pickerView.isHidden = false
    
    let animations = {
      self.pickerView.snp.updateConstraints({ (make) in
        make.bottom.equalToSuperview().offset(-self.tabBarController!.tabBar.frame.height)
      })
      
      self.navigationController?.view.layoutIfNeeded()
    }
    
    UIView.animate(withDuration: 0.2, animations: animations, completion: { _ in
      self.navigationItem.rightBarButtonItem = self.endEditingBarButtonItem
    })
  }
  
  func hidePickeView() {
    self.navigationItem.rightBarButtonItem = nil
    
    let animations = {
      self.pickerView.snp.updateConstraints({ (make) in
        make.bottom.equalToSuperview().offset(200)
      })
      
      self.navigationController?.view.layoutIfNeeded()
    }
    
    UIView.animate(withDuration: 0.2, animations: animations) { _ in
      self.pickerView.isHidden = true
    }
  }
  
}

protocol FilterTableViewControllerDelegate: class {
  func didChangeFilterValues(_ selectedYear: Int?, selectedGenre: Genre?)
}
