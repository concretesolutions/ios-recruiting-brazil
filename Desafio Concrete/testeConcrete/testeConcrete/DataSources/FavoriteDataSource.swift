//
//  FavoriteDataSource.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 20/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import Foundation
import UIKit

class FavoriteDataSource:NSObject,UITableViewDataSource{
    var filtro = ""
    var listMovies = Array<Dictionary<String,String>>()
    var filteredList:Array<Dictionary<String,String>>{
        get{
            if(filtro.count==0){
                return listMovies
            }
            
            return listMovies.filter({dict in return dict["titulo"]!.lowercased().contains(filtro.lowercased())})
        }
    }
    override init(){
        super.init()
        loadFavoriteIds()
    }
    
    private static var persistencia = "persistencia"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func loadFavoriteIds(){
        self.listMovies = Array<Dictionary<String,String>>()
        guard let list = UserDefaults().array(forKey: FavoriteDataSource.persistencia) as? [Int] else{return }
        for id in list{
            
            guard let mdic = UserDefaults().dictionary(forKey: "\(id)") as? [String : String] else{return}
            listMovies.append(mdic)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FavoriteTableCell
        cell.titulo.text = filteredList[indexPath.row]["titulo"]
        
        cell.imageView!.image = UIImage(data: NSData(base64Encoded: listMovies[indexPath.row]["image"]!, options:  NSData.Base64DecodingOptions(rawValue: 0))! as Data)
        cell.descricao.text = listMovies[indexPath.row]["descricao"]!
        cell.ano.text       = listMovies[indexPath.row]["ano"]!.components(separatedBy: "-")[0]
        return cell
    }
    
    
    
    
}
