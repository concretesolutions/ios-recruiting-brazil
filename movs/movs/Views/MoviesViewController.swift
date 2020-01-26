//
//  MoviesViewController.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var collectionView: CollectionView!
    
    internal var movies = [Movie]() {
        willSet {
            self.filteredMovie = newValue
        }
    }
    
    internal var filteredMovie = [Movie]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Localizable.movies
        
        self.setupCollectionView()
        self.getAPISettings()
        self.setNavigation()
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.download()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }

}

extension MoviesViewController {
    internal func setupCollectionView() {
        self.collectionView.register(cell: MoviesCollectionViewCell.self)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.emptyTitle = "Um erro ocorreu. Por favor, tente novamente."
    }
    
    internal func getAPISettings() {
        if let fileURL = Bundle.main.url(forResource: "APISettings", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
                let decoder = PropertyListDecoder()
                let settings = try decoder.decode(APISettings.self, from: data)
                APISettings.shared = settings
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    internal func download() {
        guard let settings = APISettings.shared else { return }
        guard let url = settings.popular(page: 1) else { return }
        
        URLSession.shared.popularTask(with: url) { (popular, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    let alert = UIAlertController(title: Localizable.error, message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: Localizable.ok, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                guard let movies = popular else { return }
                self.movies = movies.results
            }
        }.resume()
    }
    
    internal func setNavigation() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as! MoviesCollectionViewCell
        cell.movie = self.filteredMovie[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let offset: CGFloat = 8
        let div: CGFloat = 2
        let width = collectionView.frame.size.width
        let newWidth = (width - (2 * offset)) / div
        return CGSize(width: newWidth, height: newWidth * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MoviesViewController: SearchBarDelegate {
    func completeItems() -> [Movie] {
        return self.movies
    }

    func filteredItems(items: [Movie]) {
        self.filteredMovie = items
    }

    func filter(text: String, item: Movie) -> Bool {
        return item.title.lowercased().contains(text.lowercased())
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if text.isEmpty {
            self.filteredItems(items: self.completeItems())
        }else{
            let items = self.completeItems().filter({ self.filter(text: text, item: $0) })
            self.filteredItems(items: items)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.filteredItems(items: self.completeItems())
    }
}
