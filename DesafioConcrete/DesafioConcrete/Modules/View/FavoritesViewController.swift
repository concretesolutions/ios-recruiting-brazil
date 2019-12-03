//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

class FavoritesViewController: UIViewController {

	var presenter: FavoritesPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension FavoritesViewController: FavoritesViewProtocol {
    
}
