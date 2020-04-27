//
//  MovieDetailsViewController.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 25/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit
import ReSwift


class MovieDetailsViewController: UIViewController {
    
    var movieId: Int?
    var movieDetails: MovieDetails?
    
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.backgroundColor = UIColor.clear
            navigationItem.largeTitleDisplayMode = .never
        }
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if let movieId = self.movieId {
            mainStore.dispatch(
                MovieThunk.fetchDetails(of: movieId)
            )
        }
    }

    func updateUI() {
        guard let movieDetails = self.movieDetails else { return }
        
        if let posterPath = movieDetails.posterPath {
            let url = URL(string: Constants.env.imageBaseUrl)?
                .appendingPathComponent("w500")
                .appendingPathComponent(posterPath)
            
            let bgImage = UIImageView(frame: view.bounds)
            bgImage.blurred(style: .dark)

            view.addSubview(bgImage)
            view.sendSubviewToBack(bgImage)
            bgImage.sd_setImage(
                with: url,
                placeholderImage: UIImage(named: "placeholder.png")
            )
        }
        
        titleLabel.text = movieDetails.title
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.backgroundColor = UIColor.clear
        }
        
        mainStore.subscribe(self) { $0.select(MovieDetailsViewModel.init) }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Restore the navigation bar to default
        let bgColor = UIColor(asset: .brand)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = false

        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.backgroundColor = bgColor
        }
        
        mainStore.unsubscribe(self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension MovieDetailsViewController: StoreSubscriber {

    func newState(state: MovieDetailsViewModel) {
        
        let shouldUpdate = movieDetails == nil || movieDetails != state.details
        
        if shouldUpdate {
            movieDetails = state.details
            updateUI()
        }
    }
}
