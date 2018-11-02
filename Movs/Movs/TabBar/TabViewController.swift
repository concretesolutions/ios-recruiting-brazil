//
//  TabViewController.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 30/10/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

  
    override func viewDidLoad() {
        super.viewDidLoad()
      tabBar.barTintColor = UIColor.mango
      let controller1 = MovieViewController()
      let controller2 = Favorites()
      controller1.tabBarItem = UITabBarItem(title: "Filmes", image: #imageLiteral(resourceName: "list_icon.png").withRenderingMode(.alwaysOriginal), tag: 0)
      controller1.tabBarItem.selectedImage = #imageLiteral(resourceName: "list_icon.png")
      controller2.tabBarItem = UITabBarItem(title: "Favoritos", image: #imageLiteral(resourceName: "favorite_empty_icon.png").withRenderingMode(.alwaysOriginal), tag: 1)
      controller2.tabBarItem.selectedImage = #imageLiteral(resourceName: "favorite_empty_icon.png")
      controller1.title = "Filmes"
      controller2.title = "Favoritos"
      
      let navigation1 = UINavigationController(rootViewController: controller1)
      let navigation2 = UINavigationController(rootViewController: controller2)
      navigation2.navigationBar.prefersLargeTitles = true
//      navigation1.navigationBar.prefersLargeTitles = true
  
//      let searchController = UISearchController(searchResultsController: nil)
//      controller1.navigationItem.searchController = searchController
      viewControllers = [navigation1, navigation2]

        // Do any additional setup after loading the view.
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
