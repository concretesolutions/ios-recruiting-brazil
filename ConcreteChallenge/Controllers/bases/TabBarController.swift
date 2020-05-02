//
//  TabBarController.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 16/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

enum Storyboards: String {
    case movies
    case favorites
}

class TabBarController: UITabBarController {

    func setupTab(_ storyboard: Storyboards, backgroundColor: UIColor) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! BaseTabViewController

        controller.setupTab()

        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let movies = setupTab(.movies, backgroundColor: .yellow)
        let favorites = setupTab(.favorites, backgroundColor: .black)

        viewControllers = [movies, favorites]

        tabBar.barTintColor = UIColor(asset: .brand)
        tabBar.isTranslucent = false
        tabBar.tintColor = .black

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.delegate!.window!!.bringSubviewToFront((UIApplication.shared.delegate!.window!!.subviews[0]))
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
