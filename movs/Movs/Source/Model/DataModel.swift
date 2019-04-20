//
//  DataModel.swift
//  movs
//
//  Created by Lorien Moisyn on 19/04/19.
//  Copyright © 2019 Auspex. All rights reserved.
//

import Foundation
import RxSwift

class DataModel {
    
    static var sharedInstance = DataModel()
    
    var movies: [Movie] = []
    var genres: [Genre] = []
    var favoriteIds: Set<Int> = []
    var disposeBag = DisposeBag()
    
    func getGenres() {
        AlamoRemoteSource()
            .getGenres()
            .do(onSuccess: { (genres) in
                self.genres = genres
            })
            .asDriver(onErrorJustReturn: [])
            .drive()
            .disposed(by: disposeBag)
    }
    
    func getFavoritesFromDevice() {
        guard let ids = UserDefaults.standard.object(forKey: "favoriteIds") as? [Int] else { return }
        ids.forEach{ favoriteIds.insert($0) }
    }
    
    func saveFavoritesInDevice() {
        UserDefaults.standard.set(Array(favoriteIds), forKey: "favoriteIds")
    }
    
}
