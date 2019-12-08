//
//  feedDataSource.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 07/12/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation
import UIKit
import CoreData

final class feedCollectionViewDataSource: NSObject, UICollectionViewDataSource{
    
    let filmes: [Filme]
    let identifier = "feedFilmeCell"
    let context: NSManagedObjectContext
    let requestFavoritos: RequestFavoritos
    
    init(filmes: [Filme], context: NSManagedObjectContext, requestFavoritos: RequestFavoritos){
        self.filmes = filmes
        self.context = context
        self.requestFavoritos = requestFavoritos
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FilmeFeedCollectionViewCell
        
        let filme = filmes[indexPath.row]
        
        cell.setupCell(filme: filme, context: context)
        
        cell.btFavorito.layer.setValue(indexPath.row, forKey: "index")
        cell.btFavorito.addTarget(self, action: #selector(salvarFavorito), for: .touchUpInside)
        
        return cell
    }
    
    @objc func salvarFavorito(sender: UIButton){
        
        guard let indexFilme = (sender.layer.value(forKey: "index")) as? Int else { return }
    
        let filme = filmes[indexFilme]
        var image: UIImage!
        
        if requestFavoritos.pegarFavoritoPorId(id: filme.filmeDecodable.id ?? 0) == nil {
            image = #imageLiteral(resourceName: "favorite_full_icon")
        }else{
            image = #imageLiteral(resourceName: "favorite_gray_icon")
        }
        sender.setBackgroundImage(image, for: .normal)
        requestFavoritos.salvarFavorito(id: filme.filmeDecodable.id ?? 0)
    
    }
    
}
