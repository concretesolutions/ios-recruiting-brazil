//
//  ViewController.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 29/10/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {
  
  var filteredTem = [String]()

  func updateSearchResults(for searchController: UISearchController) {
    filteredTem =  teste.filter { (team) -> Bool in
      if team.lowercased().range(of: searchController.searchBar.text!) != nil {
        return true
      }
      return false
    }

    
    print(filteredTem)
    
  }
  
  var teste: [String] = ["oi", "alo", "como vc está?", "nada bem"]
  

  convenience init(frame: CGRect) {
    self.init()
    self.view = ContainerView(frame: frame)
    let searchController = UISearchController(searchResultsController: nil)
    navigationItem.searchController = searchController
    navigationItem.searchController?.searchResultsUpdater = self
    navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
    navigationItem.searchController?.dimsBackgroundDuringPresentation = false
    definesPresentationContext = true
   

  }
  override func loadView() {
  
  
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view, typically from a nib.
  }

  

}

