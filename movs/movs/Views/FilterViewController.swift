//
//  FilterViewController.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    
    internal var list = [String]()
    
    var filterHandler: ((year: String, genre: Genre))?
    
    private var years = [String]()
    private var genres: Genres?
    
    private var selectedYear: String = ""
    private var selectedGenre: Genre?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = Localizable.filter
        
        self.setButton()
        self.setTableView()
        
        self.list.append(Localizable.date)
        self.list.append(Localizable.genres)
        
        self.years = ["2020", "2019", "2018"]
        self.genres = Genres.shared
    }

    @IBAction func buttonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController {
    internal func setButton() {
        self.button.setTitle(Localizable.apply, for: .normal)
        self.button.setTitleColor(.black, for: .normal)
        self.button.backgroundColor = .primary
        self.button.roundedCorners()
        self.button.shadow()
    }
    
    internal func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.addFooterView()
        self.tableView.register(cell: UITableViewCell.self)
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: UITableViewCell.identifier)
        let item = self.list[indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.text = item
//        cell.detailTextLabel?.text = indexPath
        cell.detailTextLabel?.textColor = .primary
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = self.list[indexPath.row]
        
        let view = ListFilterViewController()
        view.navigationItem.title = item
        view.list = ["Um", "Dois", "Tres", "Quatro"]
        view.choiseHandler = { item in
            print(item)
        }
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}
