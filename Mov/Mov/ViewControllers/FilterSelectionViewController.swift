//
//  FilterSelectionViewController.swift
//  Mov
//
//  Created by Allan on 16/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

final class FilterSelectionViewController: BaseViewController{

    @IBOutlet weak private var tableView: UITableView!
    
    var options = [String]()
    private var selectedOptions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupInterface() {
        super.setupInterface()
        tableView.register(UINib(nibName: "CheckTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
    }

}

//MARK: - TableView DataSource, Delegate

extension FilterSelectionViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckTableViewCell", for: indexPath) as! CheckTableViewCell
        cell.setup(with: options[indexPath.row], showCheckMark: selectedOptions.contains(options[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let index = selectedOptions.index(of: options[indexPath.row]){
            selectedOptions.remove(at: index)
        }
        else{
            selectedOptions.append(options[indexPath.row])
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
