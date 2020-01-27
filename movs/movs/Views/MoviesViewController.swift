//
//  MoviesViewController.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit
import CEPCombine

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
    
    internal var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Localizable.movies
        self.navigationItem.largeTitleDisplayMode = .never
        self.definesPresentationContext = true
        
        self.setupCollectionView()
        self.getAPISettings()
        self.setNavigation()
        self.setRules()
        self.getGenres()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.download(page: self.page)
    }

    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillHideNotification, object: nil)
    }

}

extension MoviesViewController {
    internal func setupCollectionView() {
        self.collectionView.register(cell: MoviesCollectionViewCell.self)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.emptyTitle = "Um erro ocorreu. Por favor, tente novamente."
        self.collectionView.prefetchDataSource = self
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
    
    internal func getGenres() {
        guard let settings = APISettings.shared else { return }
        guard let url = settings.genre() else { return }
        
        URLSession.shared.genresTask(with: url, completionHandler: { genres, response, error in
            guard let genres = genres else { return }
            Genres.shared = genres
        }).resume()
    }
    
    internal func download(page: Int) {
        guard let settings = APISettings.shared else { return }
        guard let url = settings.popular(page: page) else { return }
        
        URLSession.shared.popularTask(with: url) { (popular, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    let alert = UIAlertController(title: Localizable.error, message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: Localizable.ok, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                guard let movies = popular else { return }
                self.page = movies.page + 1
                self.movies.append(contentsOf: movies.results)
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
    
    internal func setRules() {
        CBEventManager
            .getEvents(onType: MovieImageDownloadEvent.self)
            .stream
            .subscribe(completion: { event in
                let movies = self
                    .collectionView
                    .indexPathsForVisibleItems
                    .map({ indexPath in
                        (self.filteredMovie[indexPath.row], indexPath)
                    })
                
                guard let first = movies.first(where: { movie, _ in event.data.id == movie.id }) else { return }
                self.collectionView.reloadItems(at: [first.1])
            })
    }
    
    @objc internal func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height {
            var newContentInset: UIEdgeInsets = self.collectionView.contentInset
            newContentInset.bottom = keyboardHeight + 20
            self.collectionView.contentInset = newContentInset
        }
    }
    
    @objc internal func keyboardWillHide(notification: NSNotification) {
        self.collectionView.contentInset = .zero
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
        
        let movie = self.filteredMovie[indexPath.row]
        let detail = DetailMovieViewController()
        detail.hidesBottomBarWhenPushed = true
        detail.movie = movie
        self.navigationController?.pushViewController(detail, animated: true)
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

extension MoviesViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let last = indexPaths.last, last.row == (self.filteredMovie.count - 1) else { return }
        self.download(page: self.page)
    }
    
}
