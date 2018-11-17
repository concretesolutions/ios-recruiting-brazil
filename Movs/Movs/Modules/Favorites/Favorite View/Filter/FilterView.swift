//
//  FilterView.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 17/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class FilterView: UITableViewController {
    
    // VIPER
    var presenter: FavoritesPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "filterSwitch", sender: "Date")
        }
        if indexPath.row == 1 {
            performSegue(withIdentifier: "filterSwitch", sender: "Genres")
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let switchFilter = sender as? String, let filterSwitchView = segue.destination as? FilterSwitch {
            filterSwitchView.presenter = self.presenter
            filterSwitchView.setup(filterName: switchFilter)
        }
    }

}
