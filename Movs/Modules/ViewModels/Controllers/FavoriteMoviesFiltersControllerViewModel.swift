//
//  FavoriteMoviesFiltersControllerViewModel.swift
//  Movs
//
//  Created by Gabriel D'Luca on 20/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import Combine

class FavoriteMoviesFiltersControllerViewModel {

    // MARK: - Data Sources
    
    private var years: [Int] = {
        let oldestDate = Date(timeIntervalSince1970: 21 * 60 * 60)
        let currentDate = Date(timeIntervalSinceNow: 0)
        
        let oldestYear = Calendar.current.component(.year, from: oldestDate)
        let currentYear = Calendar.current.component(.year, from: currentDate)

        return Array(oldestYear...currentYear)
    }()
    
    private var genresNames: [String] = [] {
        willSet {
            self.numberOfGenres = newValue.count
        }
        didSet {
            self.genresNames.sort(by: { $0 < $1 })
        }
    }
    
    // MARK: - Dependencies
    
    typealias Dependencies = HasStorageManager
    private let storageManager: StorageManager
    
    // MARK: - Properties
    
    unowned var coordinator: FavoriteMoviesFiltersCoordinator!
    
    // MARK: - Outputs
    
    public var numberOfYears: Int {
        return self.years.count
    }
    
    // MARK: - Publishers and Subscribers
    
    @Published var numberOfGenres: Int = 0
    private var subscribers: [AnyCancellable?] = []
    
    // MARK: - Initializers and Deinitializers
    
    init(dependencies: Dependencies) {
        self.storageManager = dependencies.storageManager
        self.bind(to: self.storageManager)
    }
    
    deinit {
        for subscriber in self.subscribers {
            subscriber?.cancel()
        }
    }
    
    // MARK: - Binding
    
    func bind(to storageManager: StorageManager) {
        self.subscribers.append(storageManager.$genres
            .sink(receiveValue: { genres in
                self.genresNames = genres.compactMap({ $0.name })
            })
        )
    }
}

// MARK: - UIPickerView

extension FavoriteMoviesFiltersControllerViewModel {
    func yearTitleForRow(at row: Int) -> String {
        return String(self.years[row])
    }
    
    func indexForItem(named itemName: String) -> Int? {
        let yearsAsString = self.years.map({ String($0) })
        return yearsAsString.firstIndex(of: itemName)
    }
}

// MARK: - UICollectionView

extension FavoriteMoviesFiltersControllerViewModel {
    func genreNameForItemAt(indexPath: IndexPath) -> String {
        return self.genresNames[indexPath.row]
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        return self.genresNames[indexPath.row].size(withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .bold)
        ])
    }
}
