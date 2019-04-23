//
//  DetailViewController.swift
//  Concrete
//
//  Created by Vinicius Brito on 21/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, Storyboarded {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelSynopsis: UILabel!

    @IBOutlet weak var buttonBookmark: UIButton!
    @IBOutlet weak var imageViewMovie: UIImageView!

    weak var coordinator: MainCoordinator?
    var viewModel: MovieViewModel?
    weak var movie: Result?

    private let serviceManager = MoviesService()

    override func viewDidLoad() {
        super.viewDidLoad()
        fillScreen()
    }

    override func viewWillAppear(_ animated: Bool) {
        if let idMovie = viewModel?.idMovie {
            if DBManager.sharedInstance.checkBookmarkedItemFromKey(pKey: idMovie) {
                buttonBookmark.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            } else {
                buttonBookmark.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
            }
        }
    }

    private func fillScreen() {
        if let title = viewModel?.title {
            labelTitle.text = title
        }

        if let year = viewModel?.year {
            labelDate.text = year
        }

        if let genre = viewModel?.genres {
            labelGenre.text = genre
        }

        if let synopsis = viewModel?.synopsis {
            labelSynopsis.text = synopsis
        }

        if let image = viewModel?.image {
            print(ConstUrl.urlImage(image: image))
            imageViewMovie.sd_setImage(with:
                URL(string: ConstUrl.urlImage(image: image)), placeholderImage: UIImage(named: ""))
        }
    }

    @IBAction func bookmark(_ sender: Any) {
        if let idMovie = viewModel?.idMovie {
            if DBManager.sharedInstance.changeBookmarkedItemFromKey(pKey: idMovie) {
                buttonBookmark.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            } else {
                buttonBookmark.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
            }
        }
    }
}
