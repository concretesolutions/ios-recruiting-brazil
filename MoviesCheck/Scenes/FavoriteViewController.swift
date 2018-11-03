//
//  FavoriteViewController.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 03/11/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet var favoriteTable: UITableView!
    
    //TableView manager
    let tableManager = FavoritesTableManager()
    var selectedMedia:MediaItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableManager.delegate = self
        
        favoriteTable.delegate = tableManager
        favoriteTable.dataSource = tableManager
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableManager.reloadData()
        DispatchQueue.main.async {
            self.favoriteTable.reloadData()
        }
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == AppSegues.mediaDetail.rawValue{
            
            let destination = segue.destination as! MediaDetailViewController
            destination.mediaItem = selectedMedia
            
        }
        
    }

}

//MARK:-FavoritesTableManagerDelegate
extension FavoriteViewController:FavoritesTableManagerDelegate{
    
    func mediaSelected(media: MediaItem) {
        
        selectedMedia = media
        performSegue(withIdentifier: AppSegues.mediaDetail.rawValue, sender: nil)
        
    }
    
}
