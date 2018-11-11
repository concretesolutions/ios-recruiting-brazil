//
//  ServerManager.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 11/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import Foundation

class ServerManager {
    
    /**
     Teste call, retorna se usuario esta logado e uma mensagem caso esteja logdo
     - parameter handler: Função é executado depois que tudo ja foi feito e retorna o valor true quando logado e false quando deslogado
     */
//    public static func call(handler: @escaping ((String)->Void) ) {
//        guard let url = URL(string: ServerURLs.serverURL) else { return }
//        // Prepare request
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        // TASK
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            // Setup POST data
//            guard let data = data else { return }
//            do {
//                // Response Data
//                let decoder = JSONDecoder()
//                let serverData = try decoder.decode(ServerResponse.self, from: data)
//                //print("\(serverData.data!) || \(serverData.logged!)")
//                ServerLOGs.log(event: "Call", message: String(serverData.logged!))
//
//                // NAO LOGADO
//                if (serverData.logged! == false) {
//                    ParserUserDefaults.deleteCookies()
//                }
//
//                // Continue
//                DispatchQueue.main.async {
//                    handler(serverData.data!)
//                }
//            } catch let err {
//                print("Error", err)
//            }
//        }.resume()
//    }
    
    
}
