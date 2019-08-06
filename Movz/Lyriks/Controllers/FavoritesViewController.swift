//
//  FavoritesViewController.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 01/08/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    var favoritesCollection = MainCollectionView(data: [])
    let backgroundImage = UIImageView(image: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewCoding()
        let array = favoritesCollection.convertToModel(movie: CoreDataAPI.favoritesMovies())
        favoritesCollection.data = array
        favoritesCollection.didSelect = {[weak self](model) in

            self?.goToDetail(movie:model.getMovie() )
            
        }

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataAPI.fetch()
        favoritesCollection.data = favoritesCollection.convertToModel(movie: CoreDataAPI.favoritesMovies())
        if favoritesCollection.data.count > 1 {
            self.favoritesCollection.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
        }
        
    }
    func goToDetail(movie:Movie){
        let detail = DetailViewController(movie: movie)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        self.navigationController!.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(detail, animated: false)
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
extension FavoritesViewController:ViewCoding{
    func buildViewHierarchy() {
         self.view.addSubview(backgroundImage)
        self.view.addSubview(favoritesCollection)
        
    }
    
    func setUpConstraints() {
        backgroundImage.fillSuperview()
        favoritesCollection.fillSuperview()
    }
    
    func additionalConfigs() {
        backgroundImage.image = UIImage(named: "black_background")
        backgroundImage.contentMode = .scaleAspectFill
    }
    
    
}
