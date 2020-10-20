//
//  DetailsServiceSpec.swift
//  MovsTests
//
//  Created by Joao Lucas on 19/10/20.
//

import Quick
import Nimble
@testable import Movs

class DetailsServiceSpec: QuickSpec {
    override func spec() {
        describe("DetailsService Spec") {
            
            var client: HTTPClientMock!
            var service: DetailsService!
            
            beforeEach {
                client = HTTPClientMock()
                service = DetailsService(client: client)
            }
            
            it("Verify get images list with success") {
                client.fileName = "images-movies"
                
                service.getImages(idMovie: 497582) { result in
                    switch result {
                    case .success(let images):
                        let values = images.posters
                        expect(values[0].file_path).to(equal("/riYInlsq2kf1AWoGm80JQW5dLKp.jpg"))
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            
        }
    }
}
