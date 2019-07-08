//
//  FilterDetailMiddle.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 07/07/19.
//  Copyright © 2019 Gabriel Sória Souza. All rights reserved.
//

import Foundation

protocol FilterDetailMiddleDelegate: class {
    func startedLoadingGenres()
    func finishedLoadingGenres()
    func loadedGenresWithError()
}

enum ChosenFilter {
    case genre
    case date
}

class FilterDetailMiddle {
    
    weak var delegate: FilterDetailMiddleDelegate?
    var data = FilterDetailData()
    var filter: ChosenFilter = .date
    
    init(delegate: FilterDetailMiddleDelegate) {
        self.delegate = delegate
    }
    
    func requestDates() {
        delegate?.startedLoadingGenres()
        self.data.dates.removeAll()
        let period = 1920...2019
        period.forEach {
            self.data.dates.append($0)
        }
        self.delegate?.finishedLoadingGenres()
    }
    
    func requestGenres() {
        delegate?.startedLoadingGenres()
        self.data.genres.removeAll()
        RequestData.gerGenres(completion: { (genreWorker: GenreWorker) in
            DispatchQueue.main.async {
                self.data.genres.append(contentsOf: genreWorker.genres)
                self.delegate?.finishedLoadingGenres()
            }
        }) { (error) in
            DispatchQueue.main.async {
                self.delegate?.loadedGenresWithError()
            }
        }
    }
}

struct FilterDetailData {
    var dates: [Int] = []
    var genres: [Genres] = []
}
