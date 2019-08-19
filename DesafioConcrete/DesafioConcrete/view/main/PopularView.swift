//
//  PrincipalView.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 17/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import UIKit

class PopularView: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView?
    @IBOutlet var progress: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.title = "Populares"
        navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.yellow]
        
        self.progress?.startAnimating()
        
        self.collectionView?.register(UINib.init(nibName: "PopularesCell", bundle: nil), forCellWithReuseIdentifier: "PopularesCell")
        
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout

        let itemSpacing = layout.minimumInteritemSpacing
        let layoutItemWidth = layout.itemSize.width
        let viewWidth = view.frame.size.width
        let numColumns = Int (viewWidth / layoutItemWidth)

        let width = layoutItemWidth*CGFloat(numColumns) + itemSpacing*CGFloat(numColumns-1)
        
        layout.sectionInset.left = (width - viewWidth)/2
        layout.sectionInset.right = (width - viewWidth)/2
//
//        self.collectionView?.frame.size = CGSize(width: width, height: view.frame.size.height)

        let requester = Requester()
        requester.requestGenreList()
        requester.requestPopular(page: 1) {
            self.collectionView?.reloadData()
            self.progress?.stopAnimating()
            self.progress?.isHidden = true
        }
    }
}

extension PopularView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Singleton.shared.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularesCell", for: indexPath) as! PopularesCell
        cell.configure(with: Singleton.shared.movies[indexPath.row])
        return cell
    }
}

extension PopularView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = indexPath.row
        let movie = Singleton.shared.movies[item]
        
        let vc = DetalhesView(nibName: "DetalhesView", bundle: nil)
        vc.movie = movie
        vc.movieArrIndex = item
        self.navigationController!.pushViewController(vc, animated: false)
    }
}
