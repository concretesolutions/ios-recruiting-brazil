//
//  FilterView.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 25/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilterView: UIViewController {
    // MARK: - Properties
    // MARK: - Outlets
    @IBOutlet weak var outletTableView: UITableView!
    // MARK: - Public
    var presenter: FilterPresenter!
    // MARK: - Private
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.presenter.viewDidLoad()
        
        // Set Delegate
        self.outletTableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        self.presenter.viewWillAppear()
    }
    
    //MARK: - Functions
    //MARK: - Actions
    @IBAction func applyFilter(_ sender: UIButton) {
        if let navController = self.navigationController, navController.viewControllers.count >= 2 {
            let favoriteView = navController.viewControllers[navController.viewControllers.count - 2] as! FavoriteView
            self.presenter.dismissWithFilter(inFavoriteView: favoriteView)
        }
    }
    //MARK: - Public
}

extension FilterView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        UIView.animate(withDuration: 0.075, animations: {
            cell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (_) in
            UIView.animate(withDuration: 0.075, animations: {
                cell?.transform = CGAffineTransform.identity
            }) { (_) in
                if indexPath.row == 0 {
                    self.presenter.goToFilter(toChoose: FilterFavoriteType.year)
                }else{
                    self.presenter.goToFilter(toChoose: FilterFavoriteType.genre)
                }
            }
        }
    }
}
