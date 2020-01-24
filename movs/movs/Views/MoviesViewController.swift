//
//  MoviesViewController.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    internal var movies = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Localizable.movies
        
        self.setupCollectionView()
        self.getAPISettings()
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
    }
    
    internal func getAPISettings() {
        if let fileURL = Bundle.main.url(forResource: "APISettings", withExtension: "plist") {
            do {
                let data = try Data.init(contentsOf: fileURL, options: .mappedIfSafe)
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
            guard let movies = popular else { return }
            self.movies = movies.results
        }.resume()
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as! MoviesCollectionViewCell
        cell.movie = self.movies[indexPath.row]
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
