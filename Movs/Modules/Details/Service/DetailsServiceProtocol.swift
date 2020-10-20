//
//  DetailsServiceProtocol.swift
//  Movs
//
//  Created by Joao Lucas on 19/10/20.
//

import Foundation

protocol DetailsServiceProtocol {
    func getImages(idMovie: Int, completion: @escaping (Result<ImagesDTO, HTTPError>) -> Void)
}
