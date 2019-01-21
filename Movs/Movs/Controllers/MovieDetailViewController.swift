//
//  MovieDetailViewController.swift
//  Movs
//
//  Created by Franclin Cabral on 1/20/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

class MovieDetailViewController: UIViewController, BaseController {
    var baseViewModel: BaseViewModelProtocol! {
        didSet {
            viewModel = (baseViewModel as! MovieDetailProtocol)
        }
    }
    
    var viewModel: MovieDetailProtocol!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var descricao: UITextView!
    @IBOutlet weak var genre: UILabel!
    
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.movie.asObservable()
            .subscribe(onNext: { [weak self] (movie) in
                self!.image.af_setImage(withURL: URL(string: movie.backdropPath)!)
                self!.movieTitle.text = movie.title
                self!.year.text = movie.releaseDate
                self!.descricao.text = movie.overview
                if movie.favorited {
                    self?.favoriteBtn.setImage(UIImage(named: "favorite_full"), for: UIControl.State.normal)
                }
            })
        .disposed(by: disposeBag)
        
        viewModel.genres.asObservable()
            .subscribe(onNext: { [weak self] (genre) in
                self!.genre.text = genre
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func favorite(_ sender: Any) {
        self.favoriteBtn.setImage(
            UIImage(named: !viewModel.isFavorited() ? "favorite_full" : "favorite_empty"), for: UIControl.State.normal
        )
        viewModel.favoriteMovie(favorited: !viewModel.isFavorited())
    }
    
}

extension MovieDetailViewController: StoryboardItem {
    static func containerStoryboard() -> ApplicationStoryboard {
        return ApplicationStoryboard.main
    }
}
