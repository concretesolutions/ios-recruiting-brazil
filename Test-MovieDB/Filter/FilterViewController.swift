//
//  FilterViewController.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 07/07/19.
//  Copyright © 2019 Gabriel Sória Souza. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate: class {
    func didApplyFilter(with id: String?, and period: Int?)
}

class FilterViewController: UIViewController {

    @IBOutlet weak var genreAndDatesTableView: GenreAndDatesTableView!
    var middle: FilterMiddle!
    weak var delegate: FilterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Filter"
        
        middle = FilterMiddle(delegate: self)
        
        setupTableView()
    }
    
    func setupTableView() {
        self.genreAndDatesTableView.delegate = self
        self.genreAndDatesTableView.dataSource = self
    }
    
    
    @IBAction func applyButtonAction(_ sender: ApplyButton) {
        self.navigationController?.popViewController(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.delegate?.didApplyFilter(with: self.middle.genres, and: self.middle.period)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterDetail" {
            let vc = segue.destination as! FilterDetailViewController
            vc.middle = FilterDetailMiddle(delegate: vc)
            vc.delegate = self
            vc.middle.filter = sender as! ChosenFilter
        }
    }
}

extension FilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "filterDetail", sender: middle.filter[indexPath.row])
    }
    
}

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return middle.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filter", for: indexPath) as! FilterTableViewCell
        cell.textLabel?.text = middle.rowNames[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        if indexPath.row == 0 {
            cell.detailTextLabel?.text = String(describing: middle.period)
        } else {
            cell.detailTextLabel?.text = middle.genres
        }
        
        return cell
    }
}

extension FilterViewController: FilterMiddleDelegate {
    
}

extension FilterViewController: FilterDetailViewControllerDelegate {
    
    
    func deselectedGenre(id: String) {
        self.middle.genres = nil
        self.genreAndDatesTableView.reloadData()
    }
    
    func deselectedPeriod(date: Int) {
        self.middle.period = nil
        self.genreAndDatesTableView.reloadData()
    }
    
    
    func selectedGenre(id: String) {
        self.middle.genres = id
        self.genreAndDatesTableView.reloadData()
        
    }
    
    func selectedPeriod(date: Int) {
        self.middle.period = date
        self.genreAndDatesTableView.reloadData()
    }
    
}
