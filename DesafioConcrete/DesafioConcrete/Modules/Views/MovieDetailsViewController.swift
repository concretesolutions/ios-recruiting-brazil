//  Created Gustavo Garcia Leite on 05/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
import UIKit

final class MovieDetailsViewController: UIViewController {
    //MARK: - Variables
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var detalisTableView: UITableView!
    var activityIndicatorView = UIActivityIndicatorView()
    var presenter: MovieDetailsPresenterProtocol?
}

//MARK: - Life cycles
extension MovieDetailsViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Movie"
        guard let presenter = presenter else { return }
        presenter.callCreateActivityIndicator()
        presenter.setAnimation(to: true)
        presenter.getGenres()
    }
}

//MARK: - MovieDetailsViewProtocol
extension MovieDetailsViewController: MovieDetailsViewProtocol {
    func requestViewSetup() {
        guard let presenter = presenter else { return }
        presenter.setAnimation(to: false)
        presenter.setupView(with: detalisTableView, and: posterImageView)
    }
    
    func createActivityIndicator() {
        activityIndicatorView.frame = UIScreen.main.bounds
        self.view.addSubview(activityIndicatorView)
    }
    
    func changeIsAnimating(to animation: Bool) {
        if animation {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
}
