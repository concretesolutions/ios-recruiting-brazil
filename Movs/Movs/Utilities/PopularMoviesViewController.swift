//
//  PopularMoviesViewController.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {

    //MARK: - Properties
    let collectionView = PopularMoviesCollectionView()
    var collectionViewDatasource: PopularMoviesCollectionViewDataSource?
    var collectionViewDelegate: PopularMoviesCollectionViewDelegateFlowLayout?
    
    let tmdbService = TMDBService()
    var movies = [ //teste
        Movie(id: 0, title: "Venom", genres: [Genre(id: 878, name: "Science Fiction")], overview: "When Eddie Brock acquires the powers of a symbiote, he will have to release his alter-ego \"Venom\" to save his life.", thumbFilePath: "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg"),
        Movie(id: 1, title: "Fantastic Beasts: The Crimes of Grindelwald", genres: [Genre(id: 18, name: "Drama"),Genre(id: 10751, name: "Family"),Genre(id: 14, name: "Fantasy")], overview: "Gellert Grindelwald has escaped imprisonment and has begun gathering followers to his cause—elevating wizards above all non-magical beings. The only one capable of putting a stop to him is the wizard he once called his closest friend, Albus Dumbledore. However, Dumbledore will need to seek help from the wizard who had thwarted Grindelwald once before, his former student Newt Scamander, who agrees to help, unaware of the dangers that lie ahead. Lines are drawn as love and loyalty are tested, even among the truest friends and family, in an increasingly divided wizarding world.", thumbFilePath: "/uyJgTzAsp3Za2TaPiZt2yaKYRIR.jpg"),
        Movie(id: 2, title: "The Seven Deadly Sins: Prisoners of the Sky", genres: [Genre(id: 28, name: "Action"),Genre(id: 12, name: "Adventure"),Genre(id: 14, name: "Fantasy"),Genre(id: 16, name: "Animation")], overview: "Traveling in search of the rare ingredient, “sky fish”  Meliodas and Hawk arrive at a palace that floats above the clouds. The people there are busy preparing a ceremony, meant to protect their home from a ferocious beast that awakens once every 3,000 years. But before the ritual is complete, the Six Knights of Black—a Demon Clan army—removes the seal on the beast, threatening the lives of everyone in the Sky Palace.", thumbFilePath: "/r6pPUVUKU5eIpYj4oEzidk5ZibB.jpg"),
        Movie(id: 3, title: "The Equalizer 2", genres: [Genre(id: 53, name: "Thriller"),Genre(id: 28, name: "Action"),Genre(id: 80, name: "Crime")], overview: "Robert McCall, who serves an unflinching justice for the exploited and oppressed, embarks on a relentless, globe-trotting quest for vengeance when a long-time girl friend is murdered.", thumbFilePath: "/cQvc9N6JiMVKqol3wcYrGshsIdZ.jpg")
    ]
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = collectionView
        
        getPopularMovies()
        
    }
    
    //MARK: - Setup
    func setupCollectionView(with movies: [Movie]) {
        collectionViewDatasource = PopularMoviesCollectionViewDataSource(movies: movies, collectionView: collectionView)
        collectionView.dataSource = collectionViewDatasource
        
        collectionViewDelegate = PopularMoviesCollectionViewDelegateFlowLayout(movies: movies)
        collectionView.delegate = collectionViewDelegate
        
        collectionView.reloadData()
    }
    
    //MARK: TMDB Service
    func getPopularMovies() {
        tmdbService.getPopularMovies(page: 1) { (result) in
            switch result {
            case .success(let movies):
                self.setupCollectionView(with: movies)
            case .error(let anError):
                print("Error: \(anError)")
            }
        }
    }
    
    
    
    
}
