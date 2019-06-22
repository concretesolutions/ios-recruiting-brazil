//
//  DetailMovieViewController.swift
//  Movs
//
//  Created by Filipe Merli on 21/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit
import CoreData

class DetailMovieViewController: UIViewController, Alerts {

    //MARK: Properties
    private var viewModel: MoviesViewModel!
    public var movie: Movie!
    var genres = ""
    var isFav = false
    var favoriteMovie: NSManagedObject!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var categLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var descriptionTextLabel: UITextView!
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    //MARK: ViewController Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        configView()
    }
    
    func configView() {
        checkIfFav(id: movie.id)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        movieTitleLabel.text = movie.title
        yearLabel.text = movie.releaseDate
        categLabel.text = genres
        descriptionTextLabel.text = movie.overview
        if (movie.posterUrl == "") {
            moviePoster.image = #imageLiteral(resourceName: "placeholder")
        } else{
            moviePoster.loadImageWithUrl(posterUrl: movie.posterUrl) { result in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                    print("Erro ao baixar imagem: \(error.reason)")
                case .success(let response):
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.moviePoster.image = response.banner
                    }
                }
            }
        }
    }
    
    @IBAction func favoriteMovie(_ sender: AnyObject) {
        if isFav == false {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedObjCont = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "FavMovie", in: managedObjCont)
            let movieToSave = NSManagedObject(entity: entity!, insertInto: managedObjCont)
            movieToSave.setValue(movie.title, forKey: "title")
            movieToSave.setValue(movie.overview, forKey: "overview")
            movieToSave.setValue(movie.releaseDate, forKey: "year")
            movieToSave.setValue(movie.posterUrl, forKey: "posterUrl")
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavMovie")
            fetchRequest.includesPropertyValues = false
            do {
                try managedObjCont.save()
                self.favButton.isSelected = true
            } catch _ as NSError {
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                displayAlert(with: "Alerta" , message: "Erro ao salvar filme como favorito", actions: [action])
            }
        }
}

    private func checkIfFav(id: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjCont = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavMovie")
        let predicate = NSPredicate(format: "title == %@", "\(movie.title)")
        fetchRequest.predicate = predicate
        do {
            let result = try managedObjCont.fetch(fetchRequest)
            for _ in result as! [NSManagedObject] {
                isFav = true
            }
        } catch {
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            displayAlert(with: "Alerta", message: "Erro ao consultar lista de filmes favoritos", actions: [action])
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
