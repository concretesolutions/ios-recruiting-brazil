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
    @IBOutlet var noResultLb: UILabel?
    
    private var page = 1
    private var requester:Requester?
    private var searchTask: DispatchWorkItem?
    private var shouldLoadMore = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Populares"
        noResultLb?.isHidden = true
        
        showLoading()
        
        self.collectionView?.register(UINib.init(nibName: "PopularesCell", bundle: nil), forCellWithReuseIdentifier: "PopularesCell")
        
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout

        let itemSpacing = layout.minimumInteritemSpacing
        let layoutItemWidth = layout.itemSize.width
        let viewWidth = view.frame.size.width
        let numColumns = Int (viewWidth / layoutItemWidth)

        let width = layoutItemWidth*CGFloat(numColumns) + itemSpacing*CGFloat(numColumns-1)
        
        layout.sectionInset.left = (width - viewWidth)/2
        layout.sectionInset.right = (width - viewWidth)/2
        
        requester = Requester(vc: self)
        requester?.requestGenreList(didFail: {
            Alerta.alerta("Aconteceu algo inesperado", msg: "Houve uma falha na requisição dos gêneros, isso pode ser devido ao servidor ou algum problema na sua conexão", view: self)
        })
        
        requester?.requestPopular(page: page, callback: { success in
            if (success) {
                self.page += 1
                self.collectionView?.reloadData()
            } else {
                Alerta.alerta("Aconteceu algo inesperado", msg: "Houve uma falha na requisição dos filmes populares, isso pode ser devido ao servidor ou algum problema na sua conexão", view: self)
            }
            self.hideLoading()
        }, jsonErrorCallback: {
            self.page += 1
            Alerta.alerta("A página não pôde ser recuperada", msg: "A página seguinte será recuperada na próxima rolagem", view: self)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.title = "Populares"
        collectionView?.reloadData()
    }
    
    func showLoading() {
        self.progress?.isHidden = false
        self.progress?.startAnimating()
    }
    
    func hideLoading() {
        self.progress?.isHidden = true
        self.progress?.stopAnimating()
    }
}


extension PopularView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Singleton.shared.populares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularesCell", for: indexPath) as! PopularesCell
        cell.configure(with: Singleton.shared.populares[indexPath.row], index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == Singleton.shared.populares.count - 1 && shouldLoadMore) {
            showLoading()
            requester?.requestPopular(page: page, callback: { success in
                if (success) {
                    sleep(1)
                    self.page += 1
                    self.collectionView?.reloadData()
                } else {
                    Alerta.alerta("Aconteceu algo inesperado", msg: "Houve uma falha na requisição dos filmes populares, isso pode ser devido ao servidor ou algum problema na sua conexão", view: self)
                }
                self.hideLoading()
            }, jsonErrorCallback: {
                self.page += 1
                Alerta.alerta("A página não pôde ser recuperada", msg: "A página seguinte será recuperada na próxima rolagem", view: self)
                self.hideLoading()
            })
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

extension PopularView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // to limit network activity, reload half a second after last key press.
        self.searchTask?.cancel()
        
        // Replace previous task with a new one
        let task = DispatchWorkItem { [weak self] in
            self?.reload(searchText)
        }
        self.searchTask = task
        
        // Execute task in 0.75 seconds (if not cancelled !)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75, execute: task)
    }
    
    func reload(_ text: String) {
        showLoading()
        if(text == "") {
            shouldLoadMore = true                   //desabilita scroll load
            Singleton.shared.resetPopulares()
            noResultLb?.isHidden = true
        } else {
            shouldLoadMore = false                  //habilita scroll load
            if Singleton.shared.findMovie(nome: text) {
                noResultLb?.isHidden = true
            } else {
                noResultLb?.isHidden = false                
            }
        }
        collectionView?.reloadData()
        hideLoading()
    }
}
