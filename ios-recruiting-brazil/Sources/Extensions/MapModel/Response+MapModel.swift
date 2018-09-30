//
//  Response+MapModel.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Mapper
import Moya

public extension Moya.Response {
    public func mapModel<Model: Mappable>() throws -> Model {
        return try self.mapModel(json: self.mapToJSON())
    }
    public func mapModel<Model: Mappable>() throws -> [Model] {
        let json = try self.mapToJSON()
        guard let jsonArray = json as? NSArray else {
            throw DataError.jsonParse(.invalid(json), self)
        }
        return try Array(jsonArray).map(self.mapModel)
    }
    
    private func mapToJSON() throws -> Any {
        do {
            return try self.mapJSON()
        } catch let error as MoyaError {
            throw DataError.fromMoya(error)
        } catch {
            throw DataError.underlying(error)
        }
    }
    
    private func mapModel<Model: Mappable>(json: Any) throws -> Model {
        guard let jsonDictionary = json as? NSDictionary else {
            throw DataError.jsonParse(.invalid(json), self)
        }
        
        do {
            let json = try Model(map: Mapper(JSON: jsonDictionary))
            return json
        } catch let error as MapperError {
            throw DataError.jsonParse(.fromModelMapper(error), self)
        } catch {
            throw DataError.underlying(error)
        }
    }
}
