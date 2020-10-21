//
//  FilterYearController.swift
//  Movs
//
//  Created by Joao Lucas on 15/10/20.
//

import UIKit

protocol FilterByYearDelegate: class {
    func getYearSelected(year: String)
}

class FilterYearController: UITableViewController {
    
    private var yearList = [ResultMoviesDTO]()
    private var viewModel: FilterYearViewModel!
    
    private var yearSelected = [ResultMoviesDTO]()
    private var activityView: UIActivityIndicatorView?
    
    weak var delegate: FilterByYearDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupViewModel()
        setupFetchYears()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "filterYear")
    }
    
    private func setupViewModel() {
        viewModel = FilterYearViewModelFactory().create()
    }
    
    private func setupFetchYears() {
        viewModel.fetchYearsList()
            .successObserver(onSuccess)
            .loadingObserver(onLoading)
            .errorObserver(onError)
    }
    
    private func onSuccess(years: MoviesDTO) {
        yearList = years.results
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
        return yearList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterYear", for: indexPath)
        
        let years = yearList[indexPath.row]
        cell.textLabel?.text = Constants.getYear(movies: years)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let year = yearList[indexPath.row]
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        delegate.getYearSelected(year: Constants.getYear(movies: year))
        navigationController?.popViewController(animated: true)
    }
}
