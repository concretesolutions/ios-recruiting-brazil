//
//  FilterPopOVerViewController.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 03/11/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

protocol FilterPopOVerViewControllerDelegate{
    func applyFilter(filter:Filter)
}

class FilterPopOVerViewController: UIViewController {
    
    @IBOutlet var filterCollectionView: UICollectionView!
    
    let filterManager = FilterCollectionManager()
    
    var delegate:FilterPopOVerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterManager.delegate = self
        filterCollectionView.delegate = filterManager
        filterCollectionView.dataSource = filterManager
        
    }
    
    @IBAction func cancelFilter(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func applyFilter(_ sender: Any) {
        
        delegate?.applyFilter(filter: filterManager.filter)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}


//MARK:- FilterCollectionManagerDelegate
extension FilterPopOVerViewController:FilterCollectionManagerDelegate{
    
    func reloadCollectionData() {
        DispatchQueue.main.async {
            self.filterCollectionView.reloadData()
        }
    }
    
}
