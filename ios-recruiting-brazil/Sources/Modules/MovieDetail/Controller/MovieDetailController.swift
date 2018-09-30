//
//  MovieDetailController.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import UIKit
import RxSwift

final class MovieDetailController: UITableViewController, StoryboardLoadable {
    
    static var storyboardName: String = "MovieDetail"
    
    private var viewModel: MovieDetailViewModelType!
    private let disposeBag = DisposeBag()
    
    @IBOutlet private weak var imgPoster: UIImageView!
    @IBOutlet private weak var lbTitle: UILabel!
    @IBOutlet private weak var lbYear: UILabel!
    @IBOutlet private weak var lbGender: UILabel!
    @IBOutlet private weak var lbdesc: UILabel!
    @IBOutlet private weak var btFavorite: UIButton!
    
    func prepareForShow(viewModel: MovieDetailViewModelType) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBindReload()
    }
    
    private func setupBindReload() {
        self.viewModel.reload.asObservable().subscribe(onNext: {[weak self] reload in
            guard reload else { return }
            self?.imgPoster.loadImage(url: self?.viewModel.imgURL ?? "")
            self?.lbTitle.text = self?.viewModel.title
            self?.lbYear.text = self?.viewModel.year
            self?.lbGender.text = self?.viewModel.gender
            self?.lbdesc.text = self?.viewModel.desc
            self?.btFavorite.setImage(UIImage(named: self?.viewModel.imgFavorite ?? ""),
                                      for: .normal)
        }).disposed(by: self.disposeBag)
    }
    
    @IBAction func favoriteAction(sender: UIButton) {
        self.viewModel.saveFavorite()
        self.btFavorite.setImage(UIImage(named: self.viewModel.imgFavorite ?? ""),
                                  for: .normal)
    }
}
