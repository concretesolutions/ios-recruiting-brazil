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
    private var page = 1
    private var requester:Requester?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Populares"
        
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
        requester = Requester(vc: self)
        requester?.requestGenreList()
        requester?.requestPopular(page: page) {
            self.page += 1
            self.collectionView?.reloadData()
            self.progress?.stopAnimating()
            self.progress?.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.title = "Populares"
    }
}


extension PopularView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Singleton.shared.populares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularesCell", for: indexPath) as! PopularesCell
        cell.configure(with: Singleton.shared.populares[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == Singleton.shared.populares.count - 1 ) {
            self.progress?.startAnimating()
            self.progress?.isHidden = false
            requester?.requestPopular(page: page) {
                sleep(1)
                self.page += 1
                self.collectionView?.reloadData()
                self.progress?.stopAnimating()
                self.progress?.isHidden = true
            }
        }
    }
}

extension PopularView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = indexPath.row
        let movie = Singleton.shared.populares[item]
        
        let vc = DetalhesView(nibName: "DetalhesView", bundle: nil)
        vc.movie = movie
        self.navigationController!.pushViewController(vc, animated: false)
    }
}
