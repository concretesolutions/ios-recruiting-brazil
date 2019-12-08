//
//  feedDelegate.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 07/12/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation
import UIKit

final class feedCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    let filmes: [Filme]
    let delegate: feedSelecionado
    
    init(filmes: [Filme], delegate: feedSelecionado) {
        self.filmes = filmes
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filme = filmes[indexPath.row]
        delegate.didSelect(filme: filme)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegate.puxarProximaPagina(index: indexPath)
    }
    
}
