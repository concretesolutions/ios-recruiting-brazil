//
//  FavoriteMoviesListViewModel.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 17/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import Foundation
import CoreData

class FavoriteMoviesListViewModel: NSObject {
    enum State {
        case empty, ready
    }

    private lazy var fetchedResultsController: NSFetchedResultsController<FavoriteMovie> = {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: CoreDataStore.context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        controller.delegate = self

        return controller
    }()

    var currentState: State

    var favoritesList: [FavoriteMovie] {
        return fetchedResultsController.fetchedObjects ?? []
    }

    var navigationTitle: String {
        return "Favoritados"
    }

    var didStateChange: ((State) -> Void)?
    var didDeleteItem: ((IndexPath) -> Void)?

    override init() {
        self.currentState = .empty

        super.init()
        performFetch()
    }

    func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }

        didStateChange?(.ready)
    }

    func favorite(at indexPath: IndexPath) -> FavoriteMovie {
        return fetchedResultsController.object(at: indexPath)
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension FavoriteMoviesListViewModel: NSFetchedResultsControllerDelegate {
    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange anObject: Any,
        at indexPath: IndexPath?,
        for type: NSFetchedResultsChangeType,
        newIndexPath: IndexPath?
    ) {
        if type == .delete, let indexPath = indexPath {
            didDeleteItem?(indexPath)

            if controller.fetchedObjects?.count == 0 {
                didStateChange?(.empty)
            }
        }
    }
}
