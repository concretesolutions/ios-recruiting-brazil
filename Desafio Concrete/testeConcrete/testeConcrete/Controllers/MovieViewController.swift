//
//  MovieCollectionDelegate.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 11/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import Foundation
import UIKit

class MovieViewController:UIViewController{
    let dataSource = MoviesCollectionDataSource()
    @IBOutlet weak var collectionView: UICollectionView!
    var selectIndex:Int?
    
    @IBOutlet weak var moviesearchbar: UISearchBar!
    
}


extension MovieViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.count==0){
            searchBar.resignFirstResponder()
        }
        dataSource.filtro = searchText;
        self.collectionView.reloadData()
    }
}
extension MovieViewController{
    override func viewDidLoad() {
        collectionView.dataSource = self.dataSource
        self.moviesearchbar.delegate = self
        loadListeners()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func loadListeners(){
        NotificationCenter.default.addObserver(self, selector: #selector(finishedLoadData), name: Notification.finishedLoadedMovieAndPoster, object: nil)
    }
    
    @objc func finishedLoadData(){
        collectionView.reloadData()
    }
}

extension MovieViewController:UICollectionViewDelegate{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MovieDetailsViewController
        vc.movie = dataSource.listMovie[selectIndex!].movie
        vc.image = dataSource.listMovie[selectIndex!].image
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectIndex = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
}

extension MovieViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
           layout collectionViewLayout: UICollectionViewLayout,
           sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: UIScreen.main.bounds.width/2.2, height: UIScreen.main.bounds.width/2.2 + 100)
    }
}
