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
      //    let controller = ViewController()
      //    let navigation = UINavigationController(rootViewController: controller)
      let controller1 = MovieViewController()
      let controller2 = ViewController(frame: self.view.frame)
      controller2.view.backgroundColor = .red
      controller1.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 0)
      controller2.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
      
      controller1.title = "Movies"
      controller2.title = "Favorites"
      
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
