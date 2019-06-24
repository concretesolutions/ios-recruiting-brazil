//
//  MovsCollectionViewCell.swift
//  Movs
//
//  Created by Filipe on 17/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit
import CoreData

class MovsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var favButton: UIButton!
    var isFav = false
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favButton.isSelected = false
        setCell(with: .none)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.image = #imageLiteral(resourceName: "placeholder")
        favButton.isSelected = false
        activityIndicator.hidesWhenStopped = true
    }
    
    
    //MARK: Configure cell
    func setCell(with movie: Movie?) {
        if let movie = movie {
            titleLabel?.text = movie.title
            checkIfFav(id: Int32(movie.id))
            imageView.loadImageWithUrl(posterUrl: movie.posterUrl) { result in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                    debugPrint("Erro ao baixar imagem: \(error.reason)")
                case .success(let response):
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.imageView.image = response.banner
                    }
                }
            }
        } else {
            activityIndicator.startAnimating()
        }
    }
    
    //MARK: CoreData
    private func checkIfFav(id: Int32) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjCont = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavMovie")
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        do {
            let result = try managedObjCont.fetch(fetchRequest)
            for _ in result as! [NSManagedObject] {
                isFav = true
            }
        } catch {
            debugPrint("Deus erro ao verificar se é favorito na celula do collection")
        }
        if isFav {
            DispatchQueue.main.async {
                self.favButton.isSelected = true
            }
            
        }
//        else {
//            favButton.isSelected = false
//        }
    }
    
    
    
}
