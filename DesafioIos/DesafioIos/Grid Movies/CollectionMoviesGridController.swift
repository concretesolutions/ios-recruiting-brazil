//
//  CollectionMoviesGridController.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 16/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit
final class CollectionMoviesGridController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    var movie:[Movie] = [] {
        didSet{
            DispatchQueue.main.async {
                if !self.movie.isEmpty{
                    self.collectionView.reloadData()
                    self.statusView.isHidden = true
                }
                else{
                    self.statusView.isHidden = false
                }
            }
        }
    }
    private let reuseIdentifier = "cell"
    private var statusView = StatusView(image: #imageLiteral(resourceName: "search_icon"), descriptionScreen: "dont find X")
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MovieCellView.self, forCellWithReuseIdentifier:reuseIdentifier)
        collectionView.backgroundColor = #colorLiteral(red: 0.08962006122, green: 0.1053769067, blue: 0.1344628036, alpha: 1)
        self.collectionView.addSubview(statusView)
        statusView.isHidden = true
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movie.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieCellView{
            cell.movie = self.movie[indexPath.row]
                   return cell
        }
       return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        let height = Int(self.collectionView.frame.height / 3)
        return CGSize(width: size, height: height)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailMovieController()
              vc.movie = self.movie[indexPath.row]
              navigationController?.pushViewController(vc, animated: true)
    }

}
