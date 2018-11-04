//
//  FilterCollectionManager.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 03/11/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

protocol FilterCollectionManagerDelegate {
    func reloadCollectionData()
}

class FilterCollectionManager: NSObject {
    
    var delegate:FilterCollectionManagerDelegate?
    
    var genreList:Array<Genre> = Array()
    var yearsList:Array<String> = Array()
    var genreIds:Array<Int> = Array()
    
    var filter = Filter()
    
    //Webservice loader
    let jsonLoader = JsonLoader()
    
    var mediaType:MediaType = MediaType.movie
    
    var currentGenresBeingLoaded = ScreenType.movies
    
    override init(){
        
        yearsList = DatabaseWorker.shared.getAvailableYears()
        genreIds = DatabaseWorker.shared.getAvailableGenres(type: mediaType)
        
        super.init()
        
        jsonLoader.genresDelegate = self
        jsonLoader.loadGenres(type: ScreenType.movies)
        
    }
    
}

extension FilterCollectionManager:JsonLoaderGenresDelegate{
    
    func genresLoaded(genres: GenreResult) {
        
        genreList = genres.genres
        
        if(currentGenresBeingLoaded == .movies){
            currentGenresBeingLoaded = .tvShows
            //Load next genres elements
            jsonLoader.loadGenres(type: ScreenType.tvShows)
        }else{
            delegate?.reloadCollectionData()
        }
        
    }
    
}

extension FilterCollectionManager:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSpacing:CGFloat = 8
        
        return CGSize(width: collectionView.frame.size.width/3 - cellSpacing, height: 42)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)  as! SearchHeaderCollectionReusableView
        
        if(indexPath.section == 0){
            header.tittle.text = "Filter by Genres"
        }else{
            header.tittle.text = "Filter by Years"
        }
        
        return header
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width, height: 42)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(section == 0){//Genres
            return genreList.count
        }else{//Years
            return yearsList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCollectionViewCell
        
        if(indexPath.section == 0){//Genres
            let currentGenre = genreList[indexPath.row];
            filterCell.filterSelected = filter.selectedGenresIds.contains(currentGenre.id)
            filterCell.setGenre(g: currentGenre)
        }else{//Years
            let currentYear = yearsList[indexPath.row];
            filterCell.filterSelected = filter.selectedYears.contains(currentYear)
            filterCell.setYear(y: currentYear)
        }
        
        return filterCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if(indexPath.section == 0){//Genres
            
            let curentGenre = genreList[indexPath.row];
            filter.insertGenre(g: curentGenre)
            
        }else{//Years
            
            let currentYear = yearsList[indexPath.row];
            filter.insertYear(y: currentYear)
            
        }
        
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
        
        
    }
    
    
    
}
