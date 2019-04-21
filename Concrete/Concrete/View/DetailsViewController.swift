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
    weak var viewModel: MovieViewModel?

    private let serviceManager = MoviesService()

    override func viewDidLoad() {
        super.viewDidLoad()
        fillScreen()
    }

    private func fillScreen() {
        if let title = viewModel?.title {
            labelTitle.text = title
        }

        if let year = viewModel?.year {
            labelDate.text = year
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
}
