//
//  FavoritesViewController.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 21/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
  
  //  MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavBar()
    setupViewController()
  }
  
  //  MARK: Functions
  
  func setupNavBar() {
    self.navigationItem.title = "Favorites"
    self.view.backgroundColor = Colors.colorBackground
    self.navigationController?.navigationBar.barStyle = .black
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    
    let button: UIButton = UIButton(type: .custom)
    button.setImage(UIImage(named: "filter"), for: UIControl.State.normal)
    button.addTarget(self, action: #selector(addFilter), for: UIControl.Event.touchUpInside)
    button.frame = CGRect(x: 0, y: 0, width: 30, height: 31)
    let barButton = UIBarButtonItem(customView: button)
    self.navigationItem.rightBarButtonItem = barButton
  }
  
  func setupViewController() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller: UIViewController = storyboard.instantiateViewController(withIdentifier: "FavoritesMoviesViewController") as! FavoritesMoviesViewController
    addChild(controller)
    self.view.addSubview(controller.view)
    controller.view.frame = view.bounds
    controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    controller.didMove(toParent: self)
  }
  
  @objc func addFilter() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller: UIViewController = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
    self.navigationController?.pushViewController(controller, animated: true)
  }
}

