//
//  UICollectionView+List.swift
//  Mov
//
//  Created by Allan on 18/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

extension UICollectionView{
    
    enum EmptyListType {
        case error
        case favorite
        case search
    }
    
    func setEmpty(for type: EmptyListType, hasData: Bool){
        
        if hasData {
            self.backgroundView = nil
            return
        }
        
        let emptyList = EmptyListView()
        
        var title: String = ""
        var imageName: String = ""
        
        switch type {
        case .error:
            title = "Um erro ocorreu. Por favor, tente novamente."
            imageName = "error"
        case .favorite:
            title = "Sua lista de favoritos está vazia."
            imageName = "emptyFav"
        case .search:
            title = "Sua busca não obteve resultados."
            imageName = "search"
        }
        
        emptyList.setup(withTitle: title, imageName: imageName)
        self.backgroundView = emptyList
    }
}
