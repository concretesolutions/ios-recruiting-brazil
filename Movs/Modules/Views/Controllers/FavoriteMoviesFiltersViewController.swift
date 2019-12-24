//
//  FavoriteMoviesFiltersViewController.swift
//  Movs
//
//  Created by Gabriel D'Luca on 19/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import Combine

class FavoriteMoviesFiltersViewController: UIViewController {
    
    // MARK: - Properties
    
    internal let viewModel: FavoriteMoviesFiltersControllerViewModel
    internal var screen = FavoriteMoviesFiltersViewScreen()
    internal var selectedGenres: Set<String> = Set()
    internal var selectedYear: String = "Any"
    
    // MARK: - Publishers and Subscribers
    
    var subscribers: [AnyCancellable?] = []
    
    // MARK: - Actions
    
    @objc func didPressFilter(_ sender: UIButton) {
        self.viewModel.coordinator.filters.genresNames = self.selectedGenres.isEmpty ? nil : self.selectedGenres
        self.viewModel.coordinator.filters.year = self.selectedYear == "Any" ? nil : Int(self.selectedYear) ?? 1970
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didPressReset(_ sender: UIButton) {
        self.selectedGenres = Set()
        self.selectedYear = "Any"
        
        let section = IndexSet(integer: 0)
        self.screen.genresCollection.reloadSections(section)
        self.screen.yearPicker.selectRow(self.viewModel.numberOfYears, inComponent: 0, animated: true)
    }
    
    // MARK: - Initializers and Deinitializers
    
    init(viewModel: FavoriteMoviesFiltersControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.screen.filterButton.addTarget(self, action: #selector(self.didPressFilter(_:)), for: .touchUpInside)
        self.screen.resetButton.addTarget(self, action: #selector(self.didPressReset(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController life cycle
    
    override func loadView() {
        super.loadView()
        self.view = self.screen
        
        self.selectedGenres = viewModel.coordinator.filters.genresNames == nil ? Set() : viewModel.coordinator.filters.genresNames
        self.selectedYear = viewModel.coordinator.filters.year == nil ? "Any" : String(viewModel.coordinator.filters.year)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(to: self.viewModel)
        
        self.screen.genresCollection.delegate = self
        self.screen.genresCollection.dataSource = self
        self.screen.yearPicker.delegate = self
        self.screen.yearPicker.dataSource = self
        
        let index = self.viewModel.indexForItem(named: self.selectedYear)
        if let firstIndex = index {
            self.screen.yearPicker.selectRow(firstIndex, inComponent: 0, animated: false)
        } else {
            self.screen.yearPicker.selectRow(self.viewModel.numberOfYears, inComponent: 0, animated: false)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel.coordinator?.finish()
    }
    
    // MARK: - Binding
    
    func bind(to viewModel: FavoriteMoviesFiltersControllerViewModel) {
        self.subscribers.append(viewModel.$numberOfGenres
            .sink(receiveValue: { _ in
                self.screen.genresCollection.reloadData()
            })
        )
    }
}
