//
//  FilterResultViewController.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 10/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import UIKit

class FilterResultViewController: BaseViewController {
    //MARK: Properties
    var presenter:ViewToFilterResultPresenterProtocol?
    var listFilter:[FilterResultData]?
    private var cellIdentifier:String = "cellItem"
    //MARK:Outlets
    @IBOutlet weak var tableView: UITableView!
    //MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        FilterResultRouter.setModule(self)
        self.navigationController?.navigationBar.styleDefault()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableHeaderView = UIView(frame: CGRect.zero)
    }

    //MARK: Actions
    @IBAction func didButtonBackTap(_ sender: UIBarButtonItem) {
        self.presenter?.route?.dismiss(self, animated: true)
    }
}

extension FilterResultViewController: PresenterToFilterResultViewProtocol {
    
}

extension FilterResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.listFilter?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let objFilter:FilterResultData = self.listFilter![indexPath.row]
        cell.textLabel?.text = objFilter.value
      
        
        return cell
    }
    
    
}
