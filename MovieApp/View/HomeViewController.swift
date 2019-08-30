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
    var favoriteArray: [MovieFavorite] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        
        controller.getMoviesAPI { (sucesso) in
            if sucesso {
                self.collectionView.reloadData()
            }else{
                print("Deu ruim")
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        datamanager.loadData { (arrayMovie) in
            if arrayMovie!.count > 0{
                self.favoriteArray = arrayMovie!
                self.collectionView.reloadData()
            }else{
                print("Ruim")
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
            if favoriteArray.contains(where: {$0.id == controller.arrayMovieDB[indexPath.item].idMovie}) {
                cell.setCell(movie: controller.arrayMovieDB[indexPath.item], isFavorite: true)
            } else {
                cell.setCell(movie: controller.arrayMovieDB[indexPath.item], isFavorite: false)
            }

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
    func onClickFavoriteCell(index: Int, isFavorite: Bool) {
        print("\(index) foi clicado")
        if isFavorite {
            datamanager.saveInformation(movie: controller.arrayMovieDB[index]) { (sucess) in
                if sucess{
                    print("Sucesso")
                }else{
                    print("Sorry")
                }
            }
        } else {
            datamanager.deletePerson(movie: controller.arrayMovieDB[index]) { (sucess) in
                if sucess {
                    print("sdad")
                } else {
                    print("deu ruim")
                }
            }
        }
    }
}
