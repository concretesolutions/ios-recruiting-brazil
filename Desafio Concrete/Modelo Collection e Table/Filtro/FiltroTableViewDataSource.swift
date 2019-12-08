//
//  FiltroTableViewDataSource.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 07/12/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation
import UIKit

final class filtroTableViewDataSource: NSObject, UITableViewDataSource{
    
    let cellIdentifier = "cell"
    let elementos: [Any]
    
    init(elementos: [Any]){
        self.elementos = elementos
        super.init()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
       
        let elemento = elementos[indexPath.row]
        cell.textLabel?.text = "\(elemento)"
        return cell
    }
    
    
}
