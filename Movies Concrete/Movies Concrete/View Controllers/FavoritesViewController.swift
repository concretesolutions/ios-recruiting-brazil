//
//  FavoritesViewController.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 21/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit

//protocol FavoritesViewControllerDelegate: class {
//  func didTapBack()
//}

class FavoritesViewController: UIViewController {
  
  // MARK: Members
  
  @IBOutlet weak var favoritesTableView: UITableView!
//  weak var delegate: FavoritesViewControllerDelegate?
  
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    self.navigationController?.navigationBar
//    self.navigationItem.title = "My Favorites"
    
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    
    favoritesTableView.dataSource = self
    favoritesTableView.delegate = self
    favoritesTableView.register(UINib(nibName: "FavoriteMoviesTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "FavoriteMoviesTableViewCell")
    
  }

  
}

// MARK: Extensions

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate  {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "FavoriteMoviesTableViewCell", for: indexPath) as! FavoriteMoviesTableViewCell
    
    cell.titleMovie.text = "O Rei Leão"
    cell.yearMovie.text = "2019"
    cell.plotMovie.text = "Simba (Donald Glover) é um jovem leão cujo destino é se tornar o rei da selva. Entretanto, uma armadilha elaborada por seu tio Scar (Chiwetel Ejiofor) faz com que Mufasa (James Earl Jones), o atual rei, morra ao tentar salvar o filhote. Consumido pela culpa, Simba deixa o reino rumo a um local distante, onde encontra amigos que o ensinam a mais uma vez ter prazer pela vida."
    
    return cell
  }
  
}


