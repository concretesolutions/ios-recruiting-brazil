//
//  OptionFilterDataSource.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 18/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import Foundation
import UIKit

class OptionFilterDataSource:NSObject,UITableViewDataSource{
    let options = ["Genero","Data"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "memes")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel!.text = options[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    
}
