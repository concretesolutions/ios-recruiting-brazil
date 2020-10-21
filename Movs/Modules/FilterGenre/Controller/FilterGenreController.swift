//
//  FilterGenreController.swift
//  Movs
//
//  Created by Joao Lucas on 15/10/20.
//

import UIKit

protocol FilterByGenreDelegate: class {
    func getGenreSelected(genre: String)
}

class FilterGenreController: UITableViewController {
    
    private var genresList = [Genre]()
    private var viewModel: FilterGenreViewModel!
    private var activityView: UIActivityIndicatorView?
    
    weak var delegate: FilterByGenreDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupViewModel()
        setupFetchGenres()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    
    private func setupViewModel() {
        viewModel = FilterGenreViewModelFactory().create()
    }
    
    private func setupFetchGenres() {
        viewModel.fetchListGenres()
            .successObserver(onSuccess)
            .loadingObserver(onLoading)
            .errorObserver(onError)
    }
    
    private func onSuccess(genres: GenresDTO) {
        self.genresList = genres.genres
        tableView.reloadData()
        activityView?.stopAnimating()
    }
    
    private func onLoading() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    private func onError(message: HTTPError) {
        let errorView = ErrorView()
        self.view = errorView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genresList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let genre = genresList[indexPath.row]
        cell.textLabel?.text = genre.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let genre = genresList[indexPath.row]
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        delegate.getGenreSelected(genre: genre.name)
        navigationController?.popViewController(animated: true)
    }
}
