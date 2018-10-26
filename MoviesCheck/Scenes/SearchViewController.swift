//
//  SearchViewController.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 26/10/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var mediaCollectionView: UICollectionView!
    
    //Search parameter that will be sent to the webserver
    var currentSearchType = ""//movie, series
    
    //Type for the search of the current ViewController
    var searchType:DestinationScreen? = nil
    
    //Webservice loader
    let jsonLoader = JsonLoader()
    
    //Media items to be displayed on the Collection View
    var mediaItems:Array<MediaItem> = Array()
    
    //Identifies whether the searched word returned any result
    var sucessfulResponse = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if(searchType == .movies){
            currentSearchType = "movie"
            title = "Movies"
        }else{
            currentSearchType = "series"
            title = "TV/Shows"
        }
        
        //SearchBar configuration
        searchBar.setTextColor(color: UIColor.white)
        searchBar.delegate = self
        
        //Loader configuration
        jsonLoader.delegate = self
        
        //CollectionView configuration
        mediaCollectionView.delegate = self
        mediaCollectionView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//MARK:- Collection View
extension SearchViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSpacing:CGFloat = 10
        let screenSize = view.frame.size
        
        if mediaItems.count > 0{
            
            if(UI_USER_INTERFACE_IDIOM() == .pad){//iPad only cell distribution
                return CGSize(width: (screenSize.width - (cellSpacing * 4)) / 4, height: 255)
            }else{
                //TODO:- iPHONE SIZE FOR THE CELLS
                return CGSize.zero
            }
            
        }else{
            
            return CGSize(width: view.frame.size.width, height: 100)
            
        }
        
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
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaItem", for: indexPath)
            
            let posterImageView = cell.viewWithTag(1) as! UIImageView
            let titleLabel = cell.viewWithTag(2) as! UILabel
            let yearLabel = cell.viewWithTag(3) as! UILabel
            
            //Clear items before assigning proper values to avoid strange CollectionView behavior
            posterImageView.image = nil
            titleLabel.text = ""
            yearLabel.text = ""
            
            let currentTitle = mediaItems[indexPath.row]
            
            posterImageView.loadImage(fromURL: currentTitle.poster)
            titleLabel.text = currentTitle.title
            yearLabel.text = currentTitle.year
            
            
        }else{
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedbackMessage", for: indexPath)
            
            let messageTextView = cell.viewWithTag(1) as! UITextView
            
            if(!sucessfulResponse){
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

//MARK:- JsonLoaderDelegate
extension SearchViewController:JsonLoaderDelegate{
    
    func loaderCompleted(result: SearchResult) {
        mediaItems = result.items
        sucessfulResponse = result.getResponse()
        DispatchQueue.main.async {
            self.mediaCollectionView.reloadData()
        }
    }
    
}

//MARK:- UISearchBarDelegate
extension SearchViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let textToSearch = searchBar.text{
            //Execute search
            jsonLoader.searchRequest(withText: textToSearch, type: currentSearchType)
            //Hide keyboard
            searchBar.resignFirstResponder()
        }
        
    }
    
}

