//
//  SplashViewController.swift
//  Movs
//
//  Created by Franclin Cabral on 1/19/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController, BaseController {
    
    var baseViewModel: BaseViewModelProtocol! {
        didSet {
            viewModel = (baseViewModel as! SplashViewModelProtocol)
        }
    }
    
    var viewModel: SplashViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getSession {
            print("Aew")
            ManagerCenter.shared.router.changeRoot(to: .tabbar)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //TODO: Do some kind of animation for the screen maybe... with some timeout...

}

extension SplashViewController: StoryboardItem {
    static func containerStoryboard() -> ApplicationStoryboard {
        return ApplicationStoryboard.splash
    }
}
