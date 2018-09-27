//
//  AdvencedFilterViewController.swift
//  TheMovieDBConcrete
//
//  Created by eduardo soares neto on 27/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

protocol passFilter {
    func filterDidChange(filter: AdvancedFilter)
}

class AdvancedFilterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, passUniqueFilter {
    
    var filter = AdvancedFilter()
    var delegate: passFilter?
    
    @IBOutlet weak var filtersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filter"
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.filtersTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func applyFilter(_ sender: Any) {
        filter.isActive = true
        delegate?.filterDidChange(filter: filter)
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "filter")
        cell.accessoryType = .disclosureIndicator
        if indexPath.row == 0 {
            cell.textLabel?.text = "Date"
            cell.detailTextLabel?.text = filter.year
        } else {
            cell.textLabel?.text = "Genres"
            cell.detailTextLabel?.text = filter.genre.name
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("chegou aqui")
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "filterPicker") as? PickAdvencedFilterViewController {
            vc.delegate = self
            vc.filter = self.filter
            if indexPath.row == 0 {
                vc.isPickingGender = false
            } else {
                vc.isPickingGender = true
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func didChangeGenre(genre: Genre) {
        filter.genre = genre
    }
    
    func didChangeYear(year: String) {
        filter.year = year
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
