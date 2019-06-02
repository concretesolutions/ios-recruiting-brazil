//
//  MainService.swift
//  GPSMovies
//
//  Created by Gilson Santos on 02/06/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

//typealias criado devido a um problema de migração do Alamofire, pois ele possui um objeto de nome Result, conflitando com o Result da linguagem na sua versao 5.0
typealias ResultSwift = Result

import Foundation

class MainService {
    
    func getHost() -> String {
        return "https://api.themoviedb.org/3"
    }
    
    private func getApiKey() -> String {
        return "1ee0c432b44c77ea47291544531859a1"
    }
    
    func getParameters(in page: Int) -> [String: Any] {
        var parameter = Dictionary<String, Any>()
        parameter["api_key"] = self.getApiKey()
        parameter["language"] = "pt-BR"
        parameter["page"] = page
        return parameter
    }
}
