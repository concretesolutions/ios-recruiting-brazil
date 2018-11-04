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
    
    var filter:Filter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableManager.delegate = self
        
        favoriteTable.delegate = tableManager
        favoriteTable.dataSource = tableManager
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let currentFilter = filter{
            tableManager.realoadData(usingFilter: currentFilter)
        }else{
            tableManager.reloadData()
        }
        
        DispatchQueue.main.async {
            self.favoriteTable.reloadData()
        }
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == AppSegues.mediaDetail.rawValue{
            
            let destination = segue.destination as! MediaDetailViewController
            destination.mediaItem = selectedMedia
            
            
            if(selectedMedia?.mediaType == MediaType.movie){
                destination.searchType = ScreenType.movies
            }else{
                destination.searchType = ScreenType.tvShows
            }
            
        }
        
        if(segue.identifier == AppSegues.filterPopover.rawValue){
            
            let destination = segue.destination as! FilterPopOVerViewController
            destination.delegate = self
            
        }
        
    }

}

//MARK:-FilterPopOVerViewControllerDelegate
extension FavoriteViewController:FilterPopOVerViewControllerDelegate{
    
    func applyFilter(filter: Filter) {
        self.filter = filter
        
        if(UI_USER_INTERFACE_IDIOM() == .pad){//Ipad will not dispatch viewDidAppear when dismissing the popover, so we need to reload data here
            
            tableManager.realoadData(usingFilter: filter)
            
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
