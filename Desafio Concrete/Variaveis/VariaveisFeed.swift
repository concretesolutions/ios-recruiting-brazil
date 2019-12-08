//
//  VariaveisFeed.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 07/12/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class VariaveisFeed {
    var collectionView: UICollectionView!
    var filmesPopulares = [Filme]()
    var paginaAtual = 1
    var pesquisaAtual = ""
    var context : NSManagedObjectContext!
    var requestFavoritos: RequestFavoritos!
    var dataSource: feedCollectionViewDataSource!
    var delegate: feedCollectionViewDelegate!
    init(collectionView: UICollectionView){
        self.collectionView = collectionView
    }
    
}
