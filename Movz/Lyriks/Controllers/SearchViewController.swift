//
//  SearchViewController.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 01/08/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var resultColection = MainCollectionView(data: [])
    let filterView = FilterView()
    let backgroundImage = UIImageView(image: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieAPI.fetchGenres()
        initViewCoding()
        filterView.searchButton.addTarget(self, action: #selector(self.search), for: .touchUpInside)
        resultColection.didSelect = {[weak self](model) in
            self?.goToDetail(movie:model.getMovie())
            
        }
        //Add tap to remove keyboard from view
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.filterView.addGestureRecognizer(tap)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    @objc func dismissKeyboard() {
        filterView.endEditing(true)
    }
    
    
    @objc func search(){
        if filterView.searchButton.isSelected{
            filterView.show()
        }else{
            //procura
            filterView.hide()
            reloadData()
        }
        filterView.endEditing(true)
    }
    func goToDetail(movie:Movie){
        let detail = DetailViewController(movie: movie)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        if let navController = self.navigationController {
            navController.view.layer.add(transition, forKey: kCATransition)
            navController.pushViewController(detail, animated: false)
        }
    }
    /**
     reload collection data with serach results
    */
    func reloadData (){
        self.resultColection.data.removeAll()
        let genreRequest = filterView.genrePicker.haveValue()
        let yearRequest = filterView.yearPicker.haveValue()
        if filterView.nameView.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true{
            var parameters:[DiscoverParameters] = []
            if genreRequest{
                parameters.append(DiscoverParameters.genre([MovieAPI.getGenreNumber(name: filterView.genrePicker.selected)]))
            }
            if yearRequest{
                parameters.append(DiscoverParameters.releaseYear(filterView.yearPicker.selected))
            }
            //Force unwrapping but validation above prevente crash
            MovieAPI.movieRequest(mode: Request.discover(parameters),sort: Sort.desc(.popularity)) { [weak self] results,err in
                if err != nil{
                    return
                }
                guard let self = self else{
                    return
                }
                
                for movie in results{
                    self.resultColection.data.append(CollectionCellViewModel(movie: movie))
                }
                DispatchQueue.main.async {
                    self.resultColection.reloadData()
                    
                }
            }
        }else{
            MovieAPI.movieRequest(mode: Request.search(filterView.nameView.text!),sort: Sort.desc(.popularity)) {[weak self] results,err in
                if err != nil{
                    return
                }
                guard let self = self else{
                    return
                }
                var err = false
                for movie in results{
                    if yearRequest && !(movie.release_date.contains(self.filterView.yearPicker.selected)){
                        err = true
                    }
                    if genreRequest && !(movie.genres.contains(MovieAPI.getGenreNumber(name: self.filterView.genrePicker.selected))){
                        err = true
                    }
                    if !err{
                        self.resultColection.data.append(CollectionCellViewModel(movie: movie))
                    }
                    err = false
                  
                }
                DispatchQueue.main.async {
                    self.resultColection.reloadData()
                    
                }
            }
        }
    }
    

}

extension SearchViewController:ViewCoding{
    func buildViewHierarchy() {
        self.view.addSubview(backgroundImage)
        self.view.addSubview(resultColection)
        self.view.addSubview(filterView)
    }
    
    func setUpConstraints() {
        backgroundImage.fillSuperview()
        resultColection.fillSuperview()
        filterView.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor,size:CGSize(width: 0, height: self.view.bounds.height*0.6))
    }
    
    func additionalConfigs() {
        backgroundImage.image = UIImage(named: "black_background")
        backgroundImage.contentMode = .scaleAspectFill
    }
    
    
    
    
}
