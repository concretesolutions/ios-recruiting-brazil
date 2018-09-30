//
//  MovieDetailService.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Moya
import RxSwift

final class MovieDetailService {
    
    // MARK: Private Variables
    private var provider: RequestProvider<MovieDetailTargetType>
    
    init(provider: RequestProvider<MovieDetailTargetType>) {
        self.provider = provider
    }
    
    func fetGender() -> Observable<[GenderModel]> {
        // this map is necessary becau the API not respecty the REST
        return self.provider
            .requestJSON(MovieDetailTargetType.genders)
            .map({ response -> [GenderModel] in
                do {
                    let json = try response.mapJSON()
                    guard let dic = json as? NSDictionary,
                    let genders = dic["genres"] as? NSArray else {
                        return []
                    }
                    return try Array(genders)
                        .map({ $0 as? NSDictionary })
                        .filter({ $0 != nil })
                        .map({ gender -> GenderModel in
                            return GenderModel(JSON: gender!)
                        })
                    
                } catch {
                    return []
                }
        })
    }
    
    func fentMovieInRealm(id: Int) -> MovieModel? {
        guard let movie = try? RealmWrapper.readFirst(RLMMovieModel.self,
                                                      filter: "id = \(id)") else {
            return nil
        }
        return MovieModel(RLMMovieModel: movie)
    }
    
    func removeMovie(id: Int) {
        _ = try? RealmWrapper.remove(RLMMovieModel.self, filter: "id = \(id)")
    }
    
    func save(movie: MovieModel) {
        _ = RealmWrapper.write(movie.asRealm())
    }
}

