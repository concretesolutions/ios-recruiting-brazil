//
//  FilterChooseView.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 25/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilterChooseView: UIViewController {
    // MARK: - Properties
    // MARK: - Outlets
    @IBOutlet weak var outletTableView: UITableView!
    // MARK: - Public
    var presenter: FilterChoosePresenter!
    // MARK: - Private
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.presenter.viewDidLoad()
        
        // Set Delegate
        self.outletTableView.delegate = self
        
        // Set title
        if self.presenter.interactor.cellType == .genre{
            self.title = "Gêneros"
        }else{
            self.title = "Anos"
        }
    }
    
    override func willMove(toParent parent: UIViewController?) {
        if parent == nil{
            if let navController = self.navigationController, navController.viewControllers.count >= 2 {
                let filterView = navController.viewControllers[navController.viewControllers.count - 2] as! FilterView
                self.presenter.willDismiss(toFilterView: filterView)
            }
        }
    }
    
    //MARK: - Functions
    //MARK: - Actions
    //MARK: - Public
}

extension FilterChooseView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterChooseTableViewCell
        
        UIView.animate(withDuration: 0.075, animations: {
            cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (_) in
            UIView.animate(withDuration: 0.075, animations: {
                cell.transform = CGAffineTransform.identity
            }) { (_) in
                self.presenter.cellDidSelected(tableView, withCell: cell, andIndexPath: indexPath)
            }
        }
    }
}
