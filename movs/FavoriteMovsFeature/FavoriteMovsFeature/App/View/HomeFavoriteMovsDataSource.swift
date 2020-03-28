//
//  HomeFavoriteMovsDataSource.swift
//  FavoriteMovsFeature
//
//  Created by Marcos Felipe Souza on 27/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import ModelsFeature
import AssertModule
import NetworkLayerModule
import CommonsModule

class HomeFavoriteMovsDataSource: NSObject, UITableViewDataSource {
    
    var favorites = [FavoriteMovsModel]()
    var nlLoadImage = NLLoadImage()
    var removed: ((_ favoriteModel: FavoriteMovsModel) -> ())?
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeFavoriteItemCell.reuseCell, for: indexPath) as? HomeFavoriteItemCell {
            
            let viewData = self.favorites[indexPath.row]
                        
            self.loadImage(favoriteModel: viewData, cell: cell)
            
            return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: "cellDefault", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let model = self.favorites[indexPath.row]
            self.removed?(model)
            
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)            
        }
    }
    
    private func loadImage(favoriteModel: FavoriteMovsModel, cell: HomeFavoriteItemCell) {
        if let urlString = favoriteModel.imageURL {
            //Load from cache
            if let image = ImageCache.shared.getImage(in: urlString) {
                let modelCell = FavoriteItemCellModel(title: favoriteModel.title,
                                                      image: image,
                                                      year: favoriteModel.year,
                                                      overview: favoriteModel.overview)
                cell.configCell(with: modelCell)
            } else {
                self.nlLoadImage.loadImage(absoluteUrl: urlString) { data in
                    DispatchQueue.main.async {
                        guard let data = data, let image = UIImage(data: data) else { return }
                        ImageCache.shared.setImage(image, in: urlString)
                        let modelCell = FavoriteItemCellModel(title: favoriteModel.title,
                                                              image: image,
                                                              year: favoriteModel.year,
                                                              overview: favoriteModel.overview)
                        cell.configCell(with: modelCell)
                    }
                }
            }
        } else {
            let modelCell = FavoriteItemCellModel(title: favoriteModel.title,
                                                  image: Assets.Images.defaultImageMovs,
                                                  year: favoriteModel.year,
                                                  overview: favoriteModel.overview)
            cell.configCell(with: modelCell)
        }
    }
}
