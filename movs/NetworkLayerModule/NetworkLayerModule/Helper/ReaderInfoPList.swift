//
//  ReaderInfoPList.swift
//  NetworkLayerModule
//
//  Created by Marcos Felipe Souza on 07/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

/// InfoPlist pode ler as informacoes no arquivo de .xcconfig para os ambientes (Environment).
struct ReaderInfoPlist {
    
    /**
     Retorna o valor da chave do .xcconfig
     
     - Parameters:
     - for: É a key onde pega o valor.
     
     - Throws: Caso não exista a chave mencionada, o error "Invalid or missing Info.plist key:".
     
     - Returns: Retorna um valor do parametro `for`.
     */
    static func value<T>(for key: String) -> T {
        let bundle = Bundle(identifier: "br.com.mfelipesp.NetworkLayerModule")!
        guard let value = bundle.infoDictionary?[key] as? T else {
            fatalError("Invalid or missing Info.plist key: \(key)")
        }
        return value
    }
}
