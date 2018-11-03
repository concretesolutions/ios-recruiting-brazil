//
//  SearchCollectionManager.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 26/10/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

protocol SearchDataManagerDelegate {
    func shouldRealoadData()
    func displayLoadingIndicator()
    func hideLoadingIndicator()
    func mediaItemSelected(item:MediaItem)
}

protocol SearchDataManagerDataSource {
    func getViewSize()->CGSize
}

class SearchCollectionManager:NSObject{
    
    var delegate:SearchDataManagerDelegate?
    var dataSource:SearchDataManagerDataSource?
    
    //Webservice loader
    let jsonLoader:JsonLoader
    
    //Media items to be displayed on the Collection View
    var mediaItems:Array<MediaItem>
    
    //Identifies whether the searched frase/word returned any result
    var sucessfulResponse:Bool
    var firstSearchExecuted:Bool
    
    let searchType:ScreenType
    
    var waitingWebServiceResponse = false
    var currentPage = 0
    var totalPages = 0
    
    var lastSearchedText = "";
    
    init(type:ScreenType){
        
        jsonLoader = JsonLoader()
        mediaItems = Array()
        sucessfulResponse = false
        firstSearchExecuted = false
        searchType = type
        
        super.init()
        
        jsonLoader.delegate = self
        
    }
    
    //Load more data to the CollectionView if available in webserver
    func paginateData(){
        
        waitingWebServiceResponse = true
        
        //Load next page, if there is subsequent pages
        if(currentPage < totalPages && firstSearchExecuted){
            let nextPage = currentPage + 1
            jsonLoader.searchMedia(withText: lastSearchedText, type: searchType, page: nextPage)
        }else{
            if(currentPage < totalPages){
                let nextPage = currentPage + 1
                jsonLoader.searchPopularMedia(type: searchType, page: nextPage)
            }
        }
        
    }
    
    func requestPopularMedia(){
        
        jsonLoader.searchPopularMedia(type: searchType, page: 1)
        
    }
    
}

//MARK:- UISearchBarDelegate
extension SearchCollectionManager: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let textToSearch = searchBar.text{
            
            if(textToSearch == ""){
                return
            }
            
            //Reset previous media items
            mediaItems = []
            
            if(!firstSearchExecuted){
                firstSearchExecuted = true
            }
            
            //Hide keyboard
            searchBar.resignFirstResponder()
            delegate?.displayLoadingIndicator()
            
            //Execute search - bring the first page from webservice
            jsonLoader.searchMedia(withText: textToSearch, type: searchType, page: 1)
            
            lastSearchedText = textToSearch
            
        }
        
    }
    
}

//MARK:- JsonLoaderDelegate
extension SearchCollectionManager: JsonLoaderDelegate{
    
    /**
     Finished loading movies, start display or pagination of media items
     */
    func loaderCompleted(withMovies result: MovieSearchResult) {
        
        currentPage = result.page
        totalPages = result.totalPages
        
        mediaItems.append(contentsOf: result.items)
        sucessfulResponse = true
        
        delegate?.hideLoadingIndicator()
        delegate?.shouldRealoadData()
        
        waitingWebServiceResponse = false
        
        
        
    }
    
    /**
     Finished loading tv shows, start display or pagination of media items
     */
    func loaderCompleted(withTvShows result: TvShowSearchResult) {
        
        currentPage = result.page
        totalPages = result.totalPages
        
        mediaItems.append(contentsOf: result.items)
        sucessfulResponse = true
        
        delegate?.hideLoadingIndicator()
        delegate?.shouldRealoadData()
        
        waitingWebServiceResponse = false
        
    }
    
    func loaderFailed() {
        
        sucessfulResponse = false
        delegate?.hideLoadingIndicator()
        delegate?.shouldRealoadData()
        
    }
    
}

//MARK:- Collection View
extension SearchCollectionManager:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSpacing:CGFloat = 10
        
        if let screenSize = dataSource?.getViewSize(){
            
            if (mediaItems.count > 0 && indexPath.row < mediaItems.count && firstSearchExecuted) || (indexPath.section == 1 && indexPath.row < mediaItems.count){
                
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if(firstSearchExecuted){
            return 1
        }else{
            return 2
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)  as! SearchHeaderCollectionReusableView
        
        if(indexPath.section == 0){
            header.isHidden = true
        }else{
            header.isHidden = false
            
            if(searchType == .movies){
                header.tittle.text = "Most Popular Movies"
            }else{
                header.tittle.text = "Most Popular TV Shows"
            }
            
        }
        
        return header
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 0{
            return CGSize.zero
        }else{
            return CGSize(width: collectionView.frame.size.width, height: 42)
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(section == 0 && !firstSearchExecuted){
            return 1
        }
        
        //Display informative cell when there is no media items to display
        if mediaItems.count > 0{
            
            //Add loading cell if aditional pages is available
            if(currentPage < totalPages){
                return mediaItems.count + 1
            }else{
                return mediaItems.count
            }
            
        }else{
            if(section == 0){//Onboarding message
                return 1
            }else{
                return 0
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell:UICollectionViewCell
        
            //Display media item cells when the current row is in the mediaitems count range
            if (mediaItems.count > 0 && indexPath.row < mediaItems.count && firstSearchExecuted) || (indexPath.section == 1 && indexPath.row < mediaItems.count) {
                
                let mediaCell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaItem", for: indexPath) as! MediaCollectionViewCell
                
                let currentMedia = mediaItems[indexPath.row]
                
                mediaCell.setMedia(mediaItem: currentMedia)
                
                return mediaCell
                
            }else{
                
                if(currentPage < totalPages && indexPath.row == mediaItems.count){
                    
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loadingCell", for: indexPath)
                    
                }else{
                    
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedbackMessage", for: indexPath)
                    
                    let messageTextView = cell.viewWithTag(1) as! UITextView
                    
                    //Feedback messages
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
                
            }
            
            
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if(indexPath.row == mediaItems.count - 1 && !waitingWebServiceResponse){
            paginateData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedMediaItem = mediaItems[indexPath.row]
        delegate?.mediaItemSelected(item: selectedMediaItem)
        
    }
    
    
}
