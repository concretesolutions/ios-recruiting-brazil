//
//  MovieSearchViewController.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 04/07/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {
    
    //Mark: - Properties
    @IBOutlet weak var movieSearch: UISearchBar!
    @IBOutlet weak var movieCollection: UICollectionView!
    
    var movie = [Result]()
    //For system of search
    var filteredMovie = [Result]()
    var inSearchMode = false
    
    var isLoading = false
    var pageCount: Int = 1
    var totalPages: Int = 46
    
    //Mark: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponents()
        
        movieCollection.delegate = self
        movieCollection.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        api()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetail"){
            let vc : MovieDetailViewController = segue.destination as! MovieDetailViewController
            vc.movieCell = sender as! Result
        }
    }
    
    func configureViewComponents(){
        //Navigation Controller
        self.navigationItem.title = "Movies"
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.mainColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.mainColor()
        self.navigationController?.navigationBar.tintColor = UIColor.mainDarkBlue()
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainDarkBlue(), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        //
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //TODO: left bar button
        //        let rightButton : UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "IconFilter"), style: .plain, target: self, action: #selector(self.actionFilter(sender:)))
        //        self.navigationItem.rightBarButtonItem = rightButton
        
        
        //Search
        movieSearch.barTintColor = UIColor.mainColor()
        movieSearch.tintColor = UIColor.mainOrange()
        movieSearch.showsCancelButton = false
        for v:UIView in movieSearch.subviews.first!.subviews {
            if v.isKind(of: UITextField.classForCoder()) {
                (v as! UITextField).tintColor = UIColor.white
                (v as! UITextField).backgroundColor = UIColor.mainOrange()
            }
        }
    }
    
    
    
    // MARK: - API
    func api(){
        MovieServices.instance.getMovies(page: pageCount){ movies in
            DispatchQueue.main.async {
                self.movie = movies
                self.movieCollection.reloadData()
            }
        }
    }
    
    //MARK: _ HELPER FUNCTIONS
    //    func showDetailViewController(withMovie movie: Result) {
    //        let controller = MovieDetailViewController()
    //        controller.movie = movie
    //        self.navigationController?.pushViewController(controller, animated: true)
    //    }
    
    func loadMovies(){
        print("LoadMovies")
        print(pageCount)
        MovieServices.instance.getMovies(page: pageCount){ movies in
            self.isLoading = false
            print(movies)
            DispatchQueue.main.async {
                self.movie += movies
                self.movieCollection.reloadData()
            }
        }
    }
    
}

// MARK: - UISearchDelate

extension MovieSearchViewController: UISearchBarDelegate{
    
}

// Mark: - CollectionView
extension MovieSearchViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        cell.movie = movie[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //let movieCell = inSearchMode ? filteredMovie[indexPath.row] : movie[indexPath.row]
        let movieCell = movie[indexPath.row]
        
        self.performSegue(withIdentifier: "toDetail", sender: movieCell)
        //showDetailViewController(withMovie: movieCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movie.count - 8 && !isLoading && pageCount <= totalPages {
            pageCount += 1
            loadMovies()
            print("carregando")
        }
    }
    
    
}

extension MovieSearchViewController: UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 30.0) / 2.0
        let height = width * 1.6
        
        return CGSize.init(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    //    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    //
    //        if (self.currentYear != nil || self.currentGenre != nil){
    //            return CGSize.init(width: collectionView.frame.size.width, height: 40.0)
    //        }else{
    //            return CGSize.zero
    //        }
    //    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
}
