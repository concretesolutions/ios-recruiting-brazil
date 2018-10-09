//
//  MoviesController.swift
//  ios_recruit_challenge
//
//  Created by Lucas de Brito on 09/10/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class MoviesController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var movieView = MoviesView()
    let cellId = "cellId"
    var cellStatusList:[Bool] = [true,false,true,false,true,false]
    var maxNumberOfCells = 10
    
    override func viewDidLoad() {
        self.view.backgroundColor = .blue
        setup()
    }
    
    
    func setup(){
        movieView = MoviesView(frame: self.view.frame)
        movieView.collectionView.delegate = self
        movieView.collectionView.dataSource = self
        movieView.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        self.view.addSubview(movieView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellStatusList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width/2) - 8, height: 180)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieCollectionViewCell
        cell.isUserInteractionEnabled = true
        cell.favButton.tag = indexPath.row
        cell.favButton.addTarget(self, action: #selector(teste), for: .touchUpInside)
        cell.favButton.setImage(setBtnImage(index: indexPath.row), for: .normal)
        return cell
    }
    
    
    @objc func teste(sender: UIButton){
        cellStatusList[sender.tag] = !cellStatusList[sender.tag]
        movieView.collectionView.reloadData()
    }
    
    func setBtnImage(index:Int) -> UIImage{
        if cellStatusList[index]{
            return UIImage(named: "fullHeart")!
        }else{
            return UIImage(named: "heart")!
        }
    }
    
}

