//
//  UITableView+ReusableCell.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 23/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

extension UITableView{
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T{
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            print("Unable to get cell of type: \(T.self) in: \(self)")
            fatalError()
        }
        
        return cell
    }
    
    func register<T: UITableViewCell>(cellType: T){
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
}
