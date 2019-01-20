//
//  TabBarViewController.swift
//  Movs
//
//  Created by Franclin Cabral on 1/19/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, BaseController {
    var baseViewModel: BaseViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension TabBarViewController: StoryboardItem {
    static func containerStoryboard() -> ApplicationStoryboard {
        return ApplicationStoryboard.main
    }
}
