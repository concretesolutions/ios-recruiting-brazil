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
        setCell(with: .none)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.image = #imageLiteral(resourceName: "placeholder")
        activityIndicator.hidesWhenStopped = true
    }
    
    
    //MARK: Configure cell
    func setCell(with movie: Movie?) {
        if let movie = movie {
            titleLabel?.text = movie.title
            checkIfFav(title: movie.title)
            imageView.loadImageWithUrl(posterUrl: movie.posterUrl) { result in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                    print("Erro ao baixar imagem: \(error.reason)")
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
    private func checkIfFav(title: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjCont = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavMovie")
        let predicate = NSPredicate(format: "title == %@", "\(title)")
        fetchRequest.predicate = predicate
        do {
            let result = try managedObjCont.fetch(fetchRequest)
            for _ in result as! [NSManagedObject] {
                isFav = true
            }
        } catch {
            favButton.isEnabled = false
        }
        if isFav {
            favButton.isEnabled = true
            favButton.isSelected = true
            
        } else {
            favButton.isEnabled = true
            favButton.isSelected = false
        }
    }
    
    
    
}
