//
//  Category.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 18/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController{
    @IBOutlet weak var tabelaCategoria: UITableView!
    let dataSource = CategoryDataSource()
}

extension CategoryViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabelaCategoria.dataSource = dataSource
    }

    
}

extension CategoryViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: Notification.choosedFilter, object: nil)
       
        self.navigationController?.popViewController(animated: true)
    }
}
