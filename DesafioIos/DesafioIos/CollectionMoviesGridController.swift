//
//  CollectionMoviesGridController.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 16/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit
final class CollectionMoviesGridController: UICollectionViewController , UICollectionViewDelegateFlowLayout , SendDataApi {
    var movie:[Movie] = [] {
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    let reuseIdentifier = "cell"
    let manege = ManegerApiRequest()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MovieCellView.self, forCellWithReuseIdentifier:reuseIdentifier)
        collectionView.backgroundColor = .red
        manege.delegate = self
        manege.sendMovies(page: 4)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movie.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCellView
        cell.movie = self.movie[indexPath.row]
        //cell.backgroundColor = .white
        return cell
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
    func sendMovie(movies: [Movie]) {
        self.movie.append(contentsOf: movies)
    }
    
    func sendStatus(status: StatusConnection) {
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

}
