//
//  FilterTypesViewController.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 02/11/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

class FilterTypesViewController: UIViewController {
  lazy var tableview: UITableView = {
    let table = UITableView()
    table.register(FilterTypeCell.self, forCellReuseIdentifier: "filterTypeCell")
    table.dataSource = self
    table.delegate = self
    table.tableFooterView = UIView(frame: .zero)
    table.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    table.translatesAutoresizingMaskIntoConstraints = false
    return table
  }()
  
  var applyFilterButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 6
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = UIColor.orange
    button.setTitle("Aplicar Filtro", for: .normal)
    return button
  }()

  override func loadView() {
    view = ContainerView(frame: UIScreen.main.bounds)
    view.updateConstraints()
    view.backgroundColor = .white
    setupView()
  }
  
  func setupView() {
    navigationItem.title = "Filtro"
    addViews()
  }
  
  func addViews() {
    view.addSubview(tableview)
    view.addSubview(applyFilterButton)
    addConstraints()
  }
  
  func addConstraints() {
    tableview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    applyFilterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    applyFilterButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
    applyFilterButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
    applyFilterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15 - (tabBarController?.tabBar.frame.size.height)!).isActive = true
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

extension FilterTypesViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableview.dequeueReusableCell(withIdentifier: "filterTypeCell") as! FilterTypeCell
    
    switch indexPath.row {
    case 0:
      cell.configure(name: "Data de lançamento", sample:
      "\(Calendar.current.dateComponents([.year], from: Date()).year!)")
    case 1:
      cell.configure(name: "Gênero", sample: "")
    default:
      cell.configure(name: "", sample: "")
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    var controller = FilterTableViewController()
//    navigationController?.pushViewController(controller, animated: true)
  }
  
}
