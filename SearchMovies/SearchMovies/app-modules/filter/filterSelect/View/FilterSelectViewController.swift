//
//  FilterSelectViewController.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 10/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import UIKit

class FilterSelectViewController: UIViewController {
    //MARK:Properties
    var presenter:ViewToFilterSelectPresenterProtocol?
    var listFilter:[FilterSelectData]?
    private var cellIdentifier:String = "cellItem"
    //MARK:Outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var applyButton: UIButton!
    //MARK:Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        FilterSelectRouter.setModule(self)
        self.navigationController?.navigationBar.styleDefault()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableHeaderView = UIView(frame: CGRect.zero)
        self.applyButton.layer.cornerRadius = 5
    }
    
    //MARK: Actions
    @IBAction func didButtonBackTap(_ sender: UIBarButtonItem) {
        self.presenter?.route?.dismiss(self, animated: true)
    }
    
    @IBAction func didApplyButtonTap(_ sender: UIButton) {
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterResultSegue" {
            let navigation:UINavigationController = (segue.destination as! UINavigationController)
            let viewCtr:FilterResultViewController = (navigation.viewControllers[0] as! FilterResultViewController)
            viewCtr.delegate = self
            if sender is FilterSelectData {
                viewCtr.listFilter = (sender as! FilterSelectData).resultData
                viewCtr.parentId = (sender as! FilterSelectData).id
            }
        }
    }

}

extension FilterSelectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.listFilter?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let objFilter:FilterSelectData = self.listFilter![indexPath.row]
        cell.textLabel?.text = objFilter.filterName
        cell.detailTextLabel?.text = objFilter.filterValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objFilter:FilterSelectData = self.listFilter![indexPath.row]
        self.presenter?.route?.pushToScreen(self, segue: "filterResultSegue", param: objFilter as AnyObject)
    }
}

extension FilterSelectViewController: PresenterToFilterSelectViewProtocol {
    
}

extension FilterSelectViewController: FilterResultViewControllerDelegate {
    func returnSelectObject(value: String, parentId: Int) {
        for i in 0..<(self.listFilter?.count)! {
            if self.listFilter![i].id == parentId {
                self.listFilter![i].filterValue = value
                break
            }
        }
    
        self.tableView.reloadData()
    }
    
    
    
    
}
