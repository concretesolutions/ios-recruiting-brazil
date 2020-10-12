//
//  MoviesListServiceSpec.swift
//  MovsTests
//
//  Created by Joao Lucas on 08/10/20.
//

import Quick
import Nimble
@testable import Movs

class MoviesListServiceSpec: QuickSpec {
    override func spec() {
        describe("MoviesListService Spec") {
            
            var client: HTTPClientMock!
            var service: MoviesListService!
            
            beforeEach {
                client = HTTPClientMock()
                service = MoviesListService(client: client)
            }
            
            it("Verify get movies list with success") {
                client.fileName = "popular-movies"
                
                service.getMoviesList { result in
                    switch result {
                    case .success(let movies):
                        let values = movies.results
                        expect(values[0].title).to(equal("Enola Holmes"))
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            
            it("Verify get genres with success") {
                client.fileName = "genres"
                
                service.getGenres { result in
                    switch result {
                    case .success(let genres):
                        let values = genres.genres
                        expect(values[0].name).to(equal("Action"))
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
