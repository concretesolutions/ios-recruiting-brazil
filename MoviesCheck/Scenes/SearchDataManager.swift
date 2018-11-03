//
//  SearchDataManager.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 26/10/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

protocol SearchPresenterDelegate {
    func shouldRealoadData()
    func displayLoadingIndicator()
    func hideLoadingIndicator()
}

protocol SearchPresenterDataSource {
    func getViewSize()->CGSize
}

class SearchDataManager:NSObject{
    
    var delegate:SearchPresenterDelegate?
    var dataSource:SearchPresenterDataSource?
    
    //Webservice loader
    let jsonLoader:JsonLoader
    
    //Media items to be displayed on the Collection View
    var mediaItems:Array<MediaItem>
    
    //Identifies whether the searched frase/word returned any result
    var sucessfulResponse:Bool
    var firstSearchExecuted:Bool
    
    let searchType:ScreenType
    
    init(type:ScreenType){
        
        jsonLoader = JsonLoader()
        mediaItems = Array()
        sucessfulResponse = false
        firstSearchExecuted = false
        searchType = type
        
        super.init()
        
        jsonLoader.delegate = self
        
    }
    
}

//MARK:- UISearchBarDelegate
extension SearchPresenter: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let textToSearch = searchBar.text{
            //Execute search
            jsonLoader.searchRequest(withText: textToSearch, type: searchType)
            //Hide keyboard
            searchBar.resignFirstResponder()
            delegate?.displayLoadingIndicator()
        }
        
    }
    
}

//MARK:- JsonLoaderDelegate
extension SearchPresenter: JsonLoaderDelegate{
    
    func loaderCompleted(withMovies result: MovieSearchResult) {
        
        mediaItems = result.items
        sucessfulResponse = true
        
        if(!firstSearchExecuted){
            firstSearchExecuted = true
        }
        
        delegate?.hideLoadingIndicator()
        delegate?.shouldRealoadData()
        
    }
    
    func loaderCompleted(withTvShows result: TvShowSearchResult) {
        
        mediaItems = result.items
        sucessfulResponse = true
        
        if(!firstSearchExecuted){
            firstSearchExecuted = true
        }
        
        delegate?.hideLoadingIndicator()
        delegate?.shouldRealoadData()
        
    }
    
    func loaderFailed() {
        
        sucessfulResponse = false
        delegate?.shouldRealoadData()
        
    }
    
}

//MARK:- Collection View
extension SearchPresenter:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSpacing:CGFloat = 10
        
        if let screenSize = dataSource?.getViewSize(){
            
            if mediaItems.count > 0{
                
                if(UI_USER_INTERFACE_IDIOM() == .pad){//iPad only cell distribution
                    return CGSize(width: (screenSize.width - (cellSpacing * 4)) / 4, height: 255)
                }else{//iPhone only cell distribution
                    return CGSize(width: (screenSize.width - (cellSpacing * 2)) / 2, height: 255)
                }
                
            }else{
                
                return CGSize(width: screenSize.width, height: 100)
                
            }
            
        }
        
        return CGSize.zero
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //Display informative cell when there is no media items to display
        if mediaItems.count > 0{
            return mediaItems.count
        }else{
            return 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell:UICollectionViewCell
        
        if mediaItems.count > 0{
            
            let mediaCell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaItem", for: indexPath) as! MediaCollectionViewCell
            
            let currentMedia = mediaItems[indexPath.row]
            
            mediaCell.setMedia(mediaItem: currentMedia)
            
            return mediaCell
            
        }else{
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedbackMessage", for: indexPath)
            
            let messageTextView = cell.viewWithTag(1) as! UITextView
            
            if(!sucessfulResponse && firstSearchExecuted){
                messageTextView.text = "The title was not found, please try again."
            }else{
                if(searchType == .movies){
                    messageTextView.text = "Use the search bar above to find the Movie you want to bookmark."
                }else{
                    messageTextView.text = "Use the search bar above to find the TV Show you want to bookmark."
                }
            }
            
        }
        
        return cell
        
    }
    
}
