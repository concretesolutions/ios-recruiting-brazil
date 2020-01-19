//
//  CategoryDataSource.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 18/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import UIKit

class CategoryDataSource: NSObject{
    
    var list:[Category] = []
    
    override init(){
        super.init()
        loadList()
    }
}

extension CategoryDataSource{
    func loadList(){
        CategoryService.getCategory(){
            response in
            guard let data = response.success else{
                return
            }
            self.list = data
        }
    }
}

extension CategoryDataSource:UITableViewDataSource{
    
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          list.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel!.text = list[indexPath.row].name
        return cell
    }
}

