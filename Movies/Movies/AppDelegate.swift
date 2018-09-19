//
//  AppDelegate.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private func customizeNavBarAppearance(){
        let navigationBarAppearance = UINavigationBar.appearance()
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        
        navigationBarAppearance.tintColor    = .white
        navigationBarAppearance.barTintColor = .appColor
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.white
        ]
    
        barButtonItemAppearance.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor:UIColor.white
            ], for: .normal
        )
        
        navigationBarAppearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.white
        ]
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        customizeNavBarAppearance()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}





//
//
////
////  DetailMovieViewController.swift
////  Movies
////
////  Created by Jonathan Martins on 18/09/18.
////  Copyright © 2018 Jonathan Martins. All rights reserved.
////
//
//import UIKit
//import JonAlert
//
//class DetailMovieViewController: UIViewController {
//
//    var movie:Movie!{
//        didSet{
//            setMovieInfo()
//        }
//    }
//
//    private unowned var detailMovieView: DetailMovieView{ return self.view as! DetailMovieView }
//
//    private unowned var movieGenre:UILabel      { return detailMovieView.movieGenre   }
//    private unowned var movieOverview:UILabel   { return detailMovieView.movieOverview }
//    private unowned var movieTitle:UILabel      { return detailMovieView.movieName     }
//    private unowned var movieRelease:UILabel    { return detailMovieView.movieDate     }
//    private unowned var moviePoster:UIImageView { return detailMovieView.poster        }
//
//    override func loadView() {
//        self.view = DetailMovieView()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setTranslucentNavigationBar()
//        setFilterButton()
//
//        requestMovieDetail()
//    }
//
//    /// Makes the NavigationBar translucent
//    private func setTranslucentNavigationBar(){
//        self.navigationController?.navigationBar.isTranslucent          = true
//        self.navigationController?.navigationBar.barTintColor           = .clear
//        self.navigationController?.navigationBar.backgroundColor        = .clear
//        self.navigationItem.searchController?.searchBar.backgroundColor = .clear
//
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//    }
//
//    /// Adds the favorite button to the Controller
//    private func setFilterButton(){
//        let isFavorite = false
//        let favorite = UIBarButtonItem(image: UIImage(named: isFavorite ? "icon_favorite_over":"icon_favorite"), style: .plain, target: self, action: #selector(favoriteAction))
//        self.navigationItem.rightBarButtonItem = favorite
//    }
//
//    @objc private func favoriteAction(){
//
//    }
//
//    /// Sets the movie information
//    private func setMovieInfo(){
//
//        /// Setsthe movie poster
//        if let url = movie.poster{
//            moviePoster.load(url)
//        }
//
//        /// Sets the movie's name
//        movieTitle.text = movie.title
//
//        /// Sets the movies's date
//        movieRelease.text = movie.releaseDate.formatDate(fromPattern: "yyyy-mm-dd", toPattern: "d MMMM yyyy")
//
//        /// Sets the overview of the movie
//        movieOverview.text = movie.overview
//
//        /// Sets the genres of the movie
//        if let genres = movie.genres, genres.count > 0{
//            movieGenre.text = genres.map{"\($0.name!)"}.joined(separator: ", ")
//        }
//    }
//
//    /// Makes the request for the movie detail
//    private func requestMovieDetail(){
//        RequestMovie().detail(of: movie).responseJSON { response in
//            if let data = response.data{
//                if let movie = try? JSONDecoder().decode(Movie.self, from: data){
//                    self.movie = movie
//                }
//            }
//            else{
//                JonAlert.showError(message: "Not possible to load this movie")
//            }
//        }
//    }
//}

