//
//  MoviesViewController.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 22/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        safeArea = view.layoutMarginsGuide
        setContraints()
        getMovie()
        // Do any additional setup after loading the view.
    }
    
    var safeArea:UILayoutGuide!

    lazy var collectionView:UICollectionView = {
        
        //gridView
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = CGFloat(16)
        flowLayout.minimumInteritemSpacing = CGFloat(16)
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        //delegates
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //cell setup
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        return collectionView
        
    }()
    
    func setContraints(){
        
        collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo:safeArea.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
    private func getMovie(){
           let anonymousFunc = {(fetchedData:MovieSearch) in
               DispatchQueue.main.async {
                for movie in fetchedData.results{
                    dao.searchResults.append(movie)
                }
                   self.collectionView.reloadData()
               }
           }
        api.movieSearch(urlStr: dao.fakeSearchURL, onCompletion: anonymousFunc)
           
       }
    
    private func getPosterImage(cell:MovieCollectionViewCell,imageUrl:String){
        let url = "https://image.tmdb.org/t/p/w500\(imageUrl)"
        let anonymousFunc = {(fetchedData:UIImage) in
                DispatchQueue.main.async {
                    cell.setUp(image: fetchedData)
                }
            }
        api.retrieveImage(urlStr: url, onCompletion: anonymousFunc)
        }
    
    
    
}


extension ListViewController:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dao.searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        let imageUrl = dao.searchResults[indexPath.row].poster_path
        getPosterImage(cell: cell, imageUrl: imageUrl!)
//        cell.setUp(image: )
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width/2.5
        let height = self.view.frame.height/3
        let size:CGSize = CGSize(width: width, height: height)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.present(MovieViewController(), animated: true) {
            //tite
        }
        //perform segue to view
    }
    
    
}

