//
//  MoviesViewController.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 27/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
  
  //  MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavBar()
    setupViewController()
    
//    SessionHelper.clearUserData()
    
  }
  
  //  MARK: Functions
  
  func setupNavBar() {
    self.navigationItem.title = "Movies"
    self.view.backgroundColor = Colors.colorBackground
    self.navigationController?.navigationBar.barStyle = .black
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
  }
  
  func setupViewController() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller: PopularMoviesViewController = storyboard.instantiateViewController(withIdentifier: "PopularMoviesViewController") as! PopularMoviesViewController
    
    addChild(controller)
    self.view.addSubview(controller.view)
    controller.view.frame = view.bounds
    controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    controller.didMove(toParent: self)
    
  }
}




