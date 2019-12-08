//
//  OpcoesFiltro.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 07/12/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation
import UIKit

final class opcoesFiltroTableViewDataSource: NSObject, UITableViewDataSource{
    
    let cellIdentifier = "cell"
    let elementos: [Any]
    var filtroAno: Int? = nil
    var filtroGenero: String? = nil
    
    init(elementos: [Any], filtroAno: Int?, filtroGenero: String?){
        self.elementos = elementos
        self.filtroAno = filtroAno
        self.filtroGenero = filtroGenero
        super.init()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        cell.accessoryType = .disclosureIndicator
        
        let elemento = elementos[indexPath.row]
        cell.textLabel?.text = "\(elemento)"
        
        if indexPath.row.isZero() && filtroAno != nil{
            cell.textLabel?.text = "\(elemento): \(filtroAno ?? 0)"
        }else if indexPath.row == 1 && filtroGenero != nil{
            cell.textLabel?.text = "\(elemento): \(filtroGenero ?? "")"
        }
       
        return cell
    }
    
    
}
