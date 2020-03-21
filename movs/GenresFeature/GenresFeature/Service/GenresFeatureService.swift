//
//  GenresFeatureService.swift
//  GenresFeature
//
//  Created by Marcos Felipe Souza on 19/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//


import NetworkLayerModule
import CoreData
import CommonsModule

public typealias GenreModel = GenresListResponse.Genre

public protocol GenresFeatureServiceType: AnyObject {
    func fetchGenres(handle: @escaping (_ result: Result<[GenreModel], MtdbAPIError>) -> Void )
    func genre(by ids: [Int], handle: @escaping (_ result: Result<[GenreModel], MtdbAPIError>) -> Void)
}

open class GenresFeatureService {
    private var base: BaseRequestAPI?
    internal var genresCoreData: GenresCoreDataType
    
    public init() {
        self.genresCoreData = GenresCoreData()
    }
    
    enum TypeRequestGenre {
        case coreData
        case request
    }    
    deinit {
        print("---- GenresFeatureService deinit --- ")
    }
}

extension GenresFeatureService: GenresFeatureServiceType {
    
    public func fetchGenres(handle: @escaping (Result<[GenreModel], MtdbAPIError>) -> Void) {        
        DispatchQueue.main.async {
            let typeRequest = self.typeRequest()
            self.fetchGenre(by: typeRequest, handle: handle)
        }
    }
    
    
    public func genre(by ids: [Int], handle: @escaping (_ result: Result<[GenreModel], MtdbAPIError>) -> Void) {
        let typeRequest = self.typeRequest()
        self.fetchGenre(by: typeRequest) { result in
            switch result {
            case .failure(let error):
                handle(.failure(error))
            case .success(let genres):
                let resultGenres = genres.filter { ids.contains($0.id) }
                handle(.success(resultGenres))
            }
        }
    }
}

//MARK: - Business Logic
extension GenresFeatureService {
    private func fetchGenre(by type: TypeRequestGenre,
                            handle: @escaping (Result<[GenreModel], MtdbAPIError>) -> Void) {
        switch type {
        case .coreData:
            let models = self.callCoreData()
            handle(.success(models))
            
        case .request:
            self.callService { result in
                switch result {
                case .success(let genres):
                    self.persist(genres)
                    handle(.success(genres))
                case .failure(let error):
                    handle(.failure(error))
                }
            }
        }
        
    }
    
    private func typeRequest() -> TypeRequestGenre {
        
        guard let lastUpdate = genresCoreData.lastDateUpdate() else {
            return .request
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss"
        //dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        guard let coreData = dateFormatter.date(from: dateFormatter.string(from: lastUpdate)),
            let today  = dateFormatter.date(from: dateFormatter.string(from: Date())) else {
                return .request
        }
        
        guard let differ = coreData.totalDistance(from: today, resultIn: .day) else {
            return .request
        }
        
        if differ > 0 {
            return .request
        }
        
        return .coreData
    }
    
    private func persist(_ genres: [GenreModel]) {
        DispatchQueue.main.async {
            self.genresCoreData.removeAllGenres()
            self.genresCoreData.persist(with: genres)
            self.genresCoreData.updateDate()
        }
    }
    
    private func callCoreData() -> [GenreModel] {
        let genres = self.genresCoreData.fetchGenres()
        var genresModel = [GenreModel]()
        genres.forEach { entity in
            let model = GenreModel(id: Int(entity.id), name: entity.value ?? "")
            genresModel.append(model)
        }
        return genresModel
    }
    
    private func callService(handle: @escaping (Result<[GenreModel], MtdbAPIError>) -> Void){
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
