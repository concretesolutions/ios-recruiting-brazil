//
//  FilterViewController.swift
//  movs
//
//  Created by Lorien Moisyn on 20/04/19.
//  Copyright © 2019 Auspex. All rights reserved.
//

import UIKit
import SnapKit

class FilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: FilterPresenter!
    var selected: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        presenter = FilterPresenter(vc: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let favoritesVC = navigationController?.children.first as? FavoritesViewController else { return }
        favoritesVC.presenter.filterUsingGenres(selected)
    }
    
    func updateLayout() {
        tableView.reloadData()
    }

}

extension FilterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = presenter.data[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let imageView = UIImageView(image: UIImage(named: "check_icon") ?? UIImage())
        cell?.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(cell!).offset(-10)
            make.centerY.equalTo(cell!)
        }
        guard let text = cell?.textLabel?.text else { return }
        selected.append(text)
    }
    
}


