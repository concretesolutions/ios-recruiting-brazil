//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit


final class MoviesViewController: UIViewController {
    
    //MARK: - Variables
    @IBOutlet weak var collectionView: UICollectionView!
    var activityIndicatorView = UIActivityIndicatorView()
    var presenter: MoviesPresenterProtocol?
}

//MARK: - Life cycles
extension MoviesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Movies"
        guard let presenter = presenter else { return }
        activityIndicatorView.frame = UIScreen.main.bounds
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        presenter.requestData()
    }
}


//MARK: - MoviesView
extension MoviesViewController: MoviesViewProtocol {
    func requestCollectionSetup() {
        guard let presenter = presenter else { return }
        activityIndicatorView.stopAnimating()
        presenter.setupView(with: collectionView)
    }
}
