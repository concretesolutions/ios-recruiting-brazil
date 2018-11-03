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

  enum FilterSelected {
    case year
    case genre
    case none
  }
  
  var years = ["None", "Action", "Fantasy", "Drama", "Action", "Fantasy"]
  
  var genres = ["None", "a", "b", "c", "a", "b", "c"]
  
  var currentFilterSelect: FilterSelected = .none
  
  override func viewDidLoad() {
    super.viewDidLoad()
    selectedYearLabel.text = ""
    selectedGenreLabel.text = ""
    
    tableView.tableFooterView = UIView()
    
    setupPickerView()
  }
  
  @objc func endEditing() {
    setFilterValue()
    hidePickeView()
    currentFilterSelect = .none
    tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isSelected = false
    tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.isSelected = false
  }
  
  func setFilterValue() {
    if currentFilterSelect != .none {
      let value = pickerView.selectedRow(inComponent: 0)
      if currentFilterSelect == .genre {
        selectedGenreLabel.text = value == 0 ? "" : genres[value]
      } else {
        selectedYearLabel.text = value == 0 ? "" : years[value]
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    setFilterValue()
    
    switch indexPath.row {
    case 0:
      currentFilterSelect = .year
    case 1:
      currentFilterSelect = .genre
    default:
      fatalError("Invalid cell")
    }
    
    pickerView.reloadAllComponents()
    showPickerView()
  }
  
}

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
      label.text = genres[row]
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
