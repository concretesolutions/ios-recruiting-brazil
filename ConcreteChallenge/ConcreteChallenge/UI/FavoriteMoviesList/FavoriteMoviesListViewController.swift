//
//  FavoriteMoviesListViewController.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 14/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit
import CoreData

class FavoriteMoviesListViewController: UIViewController {

    private let favoriteMoviesListView = FavoriteMoviesListView()

    lazy var fetchedResultsController: NSFetchedResultsController<FavoriteMovie> = {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStore.context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self

        return controller
    }()

    override func loadView() {
        view = favoriteMoviesListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Favoritados"

        favoriteMoviesListView.tableView.delegate = self
        favoriteMoviesListView.tableView.dataSource = self

        loadFavorites()
        updateViewState()
    }

    private func loadFavorites() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }

    func updateViewState() {
        let nextViewState: FavoriteMoviesListView.State
        if fetchedResultsController.fetchedObjects?.count == 0 {
            nextViewState = .empty
        } else {
            nextViewState = .ready
        }

        favoriteMoviesListView.viewState = nextViewState
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FavoriteMoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as FavoriteMovieTableViewCell

        let favorite = fetchedResultsController.object(at: indexPath)
        cell.setup(favorite: favorite)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let favorite = fetchedResultsController.object(at: indexPath)
        let actionTitle = "Remover favorito"
        let unfavoriteAction = UIContextualAction(style: .destructive, title: actionTitle) { (_, _, completionHandler) in
            CoreDataStore.delete(favorite)
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [unfavoriteAction])

        return configuration
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension FavoriteMoviesListViewController: NSFetchedResultsControllerDelegate {
    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange anObject: Any,
        at indexPath: IndexPath?,
        for type: NSFetchedResultsChangeType,
        newIndexPath: IndexPath?
    ) {
        if type == .delete, let indexPath = indexPath {
            favoriteMoviesListView.tableView.deleteRows(at: [indexPath], with: .fade)
            updateViewState()
        }
    }
}
