//
//  ViewController.swift
//  MovieApp
//
//  Created by Mac Pro on 26/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var selected:Int = 0
    var datamanager = DataManager()
    var controller = MovieController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        
        controller.getMoviesAPI { (sucesso) in
            if sucesso {
                self.collectionView.reloadData()
                print("Sucesso")
            }else{
                print("Deu ruim")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            if let vc = segue.destination as? DetailsViewController{
                let ind = sender as! Int
                vc.movie = controller.arrayMovieDB[ind]
            }
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller.arrayMovieDB.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as? HomeCell{
           cell.setCell(movie: controller.arrayMovieDB[indexPath.item])
           cell.cellDelegate = self
           cell.index = indexPath
           return cell
        }
    
        return UICollectionViewCell()
    }
}
extension HomeViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        selected = indexPath.row
        self.performSegue(withIdentifier: "detailSegue", sender: indexPath.item)
        print("Clidou no detail")
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = (collectionView.frame.width / 2) * 1.5 + 60
        return CGSize(width: collectionView.frame.width / 2, height: height)
    }
    
}
extension HomeViewController: HomeCellDelegate{
    func onClickFavoriteCell(index: Int) {
        print("\(index) foi clicado")
        datamanager.saveInformation(movie: controller.arrayMovieDB[index]) { (sucess) in
            if sucess{
                print("Sucesso")
            }else{
                print("Sorry")
            }
        }
    }
}
