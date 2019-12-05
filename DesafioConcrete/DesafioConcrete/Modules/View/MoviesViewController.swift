//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

//MARK: - Variables
final class MoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var activityIndicatorView = UIActivityIndicatorView()
    var presenter: MoviesPresenterProtocol?
}

//MARK: - Life cycles
extension MoviesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let presenter = presenter else { return }
        activityIndicatorView.stopAnimating()
        presenter.requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Movies"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
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
