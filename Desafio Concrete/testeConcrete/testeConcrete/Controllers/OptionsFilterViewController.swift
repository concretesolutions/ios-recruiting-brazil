//
//  OptionsFilter.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 18/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import Foundation
import UIKit
class OptionsFilterViewController:UIViewController{
    let tableSource = OptionFilterDataSource()
    @IBOutlet weak var tableOption: UITableView!
    override func viewDidLoad() {
        tableOption.dataSource = tableSource
        loadListeners()
    }
}

extension OptionsFilterViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.row){
            case 0:
                performSegue(withIdentifier:"categorysegue" , sender: nil)
            default:
                break;
        }
    }
    
    func loadListeners(){
        NotificationCenter.default.addObserver(self, selector: #selector(popView), name: Notification.choosedFilter, object: nil)
    }
    
    
    @objc func popView(){
         self.navigationController?.popViewController(animated: true)
    }
}

    
    
