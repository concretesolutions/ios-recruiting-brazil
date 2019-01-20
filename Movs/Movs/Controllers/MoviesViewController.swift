//
//  ViewController.swift
//  Movs
//
//  Created by Franclin Cabral on 1/17/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import UIKit
import RxSwift

class MoviesViewController: UIViewController, BaseController {

    var baseViewModel: BaseViewModelProtocol! {
        didSet {
            viewModel = (baseViewModel as! MoviesViewModelProtocol)
        }
    }
    
    var viewModel: MoviesViewModelProtocol!
    let disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        
        viewModel.dataSource.asObservable()
            .subscribe(onNext: { (value) in
                
            }, onError: { (error) in
                
            }).disposed(by: disposeBag)
        
        
    }
    
    func configureCollectionView() {
        collectionView.register(MoviesCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.moviesCellIdentifier)
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItensInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.moviesCellIdentifier, for: indexPath) as! MoviesCollectionViewCell
        
//            cell.configure(viewModel.getMovie(index: indexPath.item))
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: send the user to another page
    }
}

extension MoviesViewController: StoryboardItem {
    static func containerStoryboard() -> ApplicationStoryboard {
        return ApplicationStoryboard.main
    }
}
