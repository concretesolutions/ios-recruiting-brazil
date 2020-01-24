//
//  MoviesViewController.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 22/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    //MARK: - Variables
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
    //MARK: -Init methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        safeArea = view.layoutMarginsGuide
        setContraints()
        getMovie()
        // Do any additional setup after loading the view.
    }

    private func setContraints(){
        
        collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo:safeArea.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    //MARK: - Complimentary Methods
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
}

//MARK:- Extensions and Delegates
extension ListViewController:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dao.searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        guard let imageUrl = dao.searchResults[indexPath.row].poster_path else {fatalError("Could not retrieve poster image for cell")}
        cell.setUp(imageName: imageUrl)
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

