//
//  GenresFeatureService.swift
//  GenresFeature
//
//  Created by Marcos Felipe Souza on 19/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation
import NetworkLayerModule
import CoreData


public typealias GenreModel = GenresListResponse.Genre

public protocol GenresFeatureServiceType: AnyObject {
    func fetchGenres(handle: @escaping (_ result: Result<[GenreModel], MtdbAPIError>) -> Void )
    func genre(by id: Int) -> GenreModel
}

open class GenresFeatureService {
    var base: BaseRequestAPI?
    public init() {}
}

extension GenresFeatureService: GenresFeatureServiceType {
    public func fetchGenres(handle: @escaping (Result<[GenreModel], MtdbAPIError>) -> Void) {
        self.lastUpdateCoreData()
        handle(.failure(.badRequest))
    }
    
    
    public func genre(by id: Int) -> GenreModel {
        print("Buscar Genrer by ID:")
        let genre = GenreModel(id: 1, name: "123123")
        return genre
    }
}

//MARK: - Business Logic
extension GenresFeatureService {
    
    
    private func lastUpdateCoreData() {
        let coreDataStack = CoreDataStack.shared
        let lastUpdateRequest: NSFetchRequest<LastUpdate> = LastUpdate.fetchRequest()
        DispatchQueue.main.async {
            var dateUpdate: Date? = nil
            do {
                let lastUpdate = try coreDataStack.managedContext.fetch(lastUpdateRequest)
                dateUpdate = lastUpdate.first?.genre
            } catch {
                dateUpdate = nil
            }
        }
    }
    
    
    
    private func callService(handle: @escaping (Result<[GenreModel], MtdbAPIError>) -> Void) {
        let api = GenresMovsAPI.normal
        
        self.base = BaseRequestAPI(api: api, completion: {  (result: Result<GenresListResponse, MtdbAPIError>) in
            switch result {
            case .success(let model):
                handle(.success(model.genres))
            case .failure(let error):
                handle(.failure(error))
            }
        })
    }
    
}
