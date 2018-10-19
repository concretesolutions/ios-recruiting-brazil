//
//  FilterSelectionViewController.swift
//  Mov
//
//  Created by Allan on 16/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

protocol FilterSelectionViewControllerDelegate {
    func didSelectFilter(filter: Filter)
}

final class FilterSelectionViewController: BaseViewController{

    @IBOutlet weak private var tableView: UITableView!
    
    var filter: Filter!
    var delegate: FilterSelectionViewControllerDelegate?
    private var selectedOptions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupInterface() {
        super.setupInterface()
        tableView.register(UINib(nibName: "CheckTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
        currentTitle = filter.property
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.didSelectFilter(filter: self.filter)
    }

}

//MARK: - TableView DataSource, Delegate

extension FilterSelectionViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.values.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckTableViewCell", for: indexPath) as! CheckTableViewCell
        let option = filter.values[indexPath.row]
        cell.setup(with: option, showCheckMark: filter.selectedValues.contains(option))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = filter.values[indexPath.row]
        if let index = filter.selectedValues.index(of: option){
            filter.selectedValues.remove(at: index)
        }
        else{
            filter.selectedValues.append(option)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
