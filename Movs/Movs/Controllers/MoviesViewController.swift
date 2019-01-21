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
    @IBOutlet weak var placeHolderImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Movies"
        configureCollectionView()
        viewModel.dataSource.asObservable()
            .subscribe(onNext: { [weak self] (value) in
                self!.collectionView.reloadData()
            }, onError: { [weak self] (error) in
                self!.placeHolderImage.image = UIImage(named: "error")
            }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    func configureCollectionView() {
        collectionView.register(UINib(nibName: Constants.moviesCellIdentifier, bundle: nil), forCellWithReuseIdentifier: Constants.moviesCellIdentifier)
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItensInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.moviesCellIdentifier, for: indexPath) as! MovieCell
        
            cell.configure(movie: viewModel.getMovie(index: indexPath.item))
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ManagerCenter.shared.router.route(
            from: self,
            to: .movieDetail,
            data: viewModel.getMovie(index: indexPath.item),
            action: .push
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width + 16 + 16) * 9 / 16
        return CGSize(width: (view.frame.width/2) - 8 , height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16.0, left: 2.0, bottom: 0.0, right: 2.0)
    }
}

extension MoviesViewController: StoryboardItem {
    static func containerStoryboard() -> ApplicationStoryboard {
        return ApplicationStoryboard.main
    }
}
