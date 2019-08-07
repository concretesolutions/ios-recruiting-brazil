//
//  MainTabBarController.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    var presenter:ViewToMainPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        MainRouter.setModule(self)
      
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

extension MainTabBarController: PresenterToMainViewProtocol {
    func returnMainMenu(menuList: [MainMenu]) {
        
    }
}
