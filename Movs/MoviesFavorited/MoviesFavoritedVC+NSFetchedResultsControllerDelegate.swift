//
//  MoviesFavoritedVC+NSFetchedResultsControllerDelegate.swift
//  Movs
//
//  Created by Rafael Douglas on 21/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit
import CoreData

extension MoviesFavoritedVC: NSFetchedResultsControllerDelegate {
   
    // whenever any object is modified this method will be notified
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
       
        switch type {
            case .delete:
                if let indexPath = indexPath {
                    // Delete the row from the data source
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                break
            default:
                tableView.reloadData()
        }
    }
}
