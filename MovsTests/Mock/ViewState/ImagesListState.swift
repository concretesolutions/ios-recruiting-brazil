//
//  ImagesListState.swift
//  MovsTests
//
//  Created by Joao Lucas on 19/10/20.
//

import Foundation
@testable import Movs

class ImagesListState {
    
    var success = false
    var loading = false
    var error = false
    
    func onSuccess(images: ImagesDTO) {
        success = true
    }
    
    func onLoading() {}
    
    func onError(message: HTTPError) {}
}
