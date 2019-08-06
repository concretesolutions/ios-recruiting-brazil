//
//  MainCollectionView.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 28/07/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit

class MainCollectionView: UICollectionView {
    var didSelect:((CollectionCellViewModel)->Void)?
    var data:[CollectionCellViewModel]{ didSet{
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    var paging:Bool = false
    private let customLayout:MainCollectionLayout
    var pageCount = 1
    var canRefresh = true
    init(data:[CollectionCellViewModel]) {
        self.data = data
        let layout = MainCollectionLayout()
        layout.itemSize = CGSize(width: MainMovieCollectionViewCell.cellWidth, height: MainMovieCollectionViewCell.cellHeight)
        layout.scrollDirection = .horizontal
        self.customLayout = layout
        super.init(frame: CGRect.zero
            , collectionViewLayout:layout )
        self.delegate = self
        self.dataSource = self
        self.register(MainMovieCollectionViewCell.self, forCellWithReuseIdentifier:MainMovieCollectionViewCell.reuseIdentifier )
        self.backgroundColor = .clear
        
       
    }
    /**
     refresh images when get then from api
    */
    func refreshImages(){
        data.forEach { (model) in
            //Change only default images
            if model.image?.accessibilityIdentifier == "empty_image" {
                  model.image = model.getMovie().image
            }
        }
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
        Converte Movie to collection view model
    */
    func convertToModel(movie:[Movie]) -> [CollectionCellViewModel]{
        var modelArray:[CollectionCellViewModel] = []
        movie.forEach { (movie) in
            modelArray.append(CollectionCellViewModel(movie: movie))
        }
        return modelArray
    }
    /**
        Add new page on collection
    */
    func newPage(){
        self.pageCount+=1
        MovieAPI.movieRequest(mode:Request.popular(self.pageCount),sort:Sort.desc(.voteAverage)){
            [weak self](request,err) in
            if err != nil{
                return
            }
            guard let self = self else{
                return
            }
            for movie in request{
                self.data.append(CollectionCellViewModel(movie: movie))
            }
            DispatchQueue.main.async {
                self.reloadData()
                
            }
            self.canRefresh = true
            
        }
        
    }
    /**
     identify when to add the new page
    */
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView.contentOffset.x >= (scrollView.contentSize.width - (MainMovieCollectionViewCell.cellWidth + customLayout.minimumInteritemSpacing)*5) && self.canRefresh){
            if(paging){
                newPage()
            }
            canRefresh = false
            
        }
    }
    
    
    
 
    
}


extension MainCollectionView:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: review
        self.didSelect?(data[indexPath.item])
    }
}
extension MainCollectionView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: MainMovieCollectionViewCell.reuseIdentifier, for: indexPath) as? MainMovieCollectionViewCell else{
            return MainMovieCollectionViewCell()
        }
        cell.setUpCell(movie: data[indexPath.item])
        self.backgroundColor = .clear
        return cell
    }
    
}

