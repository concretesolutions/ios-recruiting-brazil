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
    table.tableFooterView = UIView(frame: .zero)
    table.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    table.translatesAutoresizingMaskIntoConstraints = false
    return table
  }()

  override func loadView() {
    view = ContainerView(frame: UIScreen.main.bounds)
    view.backgroundColor = .white
    setupView()
  }
  
  func setupView() {
    navigationItem.title = "Filtro"
    addViews()
  }
  
  func addViews() {
    view.addSubview(tableview)
    addConstraints()
  }
  
  func addConstraints() {
    tableview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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

extension FilterTypesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableview.dequeueReusableCell(withIdentifier: "filterTypeCell") as! FilterTypeCell
    
    switch indexPath.row {
    case 0:
      cell.configure(name: "Data", sample:
      "\(Calendar.current.dateComponents([.year], from: Date()).year!)")
    case 1:
      cell.configure(name: "Gênero", sample: "")
    default:
      cell.configure(name: "", sample: "")
    }
    return cell
  }
  
  
}
