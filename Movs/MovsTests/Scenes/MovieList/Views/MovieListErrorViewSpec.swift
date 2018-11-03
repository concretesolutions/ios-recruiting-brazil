//
//  MovieListErrorViewSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 29/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble
@testable import Movs

class MovieListErrorViewSpec: QuickSpec {
    
    override func spec() {
        describe("MovieListErrorView Spec") {
            
            var view: MovieListErrorView!
            
            context("init with coder") {
                it("should raise exception") {
                    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                    expect(MovieListErrorView(coder: archiver)).to(raiseException())
                }
            }
            
            context("init with frame", {
                beforeEach {
                    view = MovieListErrorView(frame: .zero)
                }
                
                it("should image be nil") {
                    expect(view.errorImage.image).to(beNil())
                }
                
                it("should text in label to not be nil") {
                    expect(view.errorLabel.text).toNot(beNil())
                }
            
                context("handle error of type error") {
                    beforeEach {
                        let viewError = MovieListErrorView.ViewError(movieTitle: "", errorType: .error)
                        view.setError(viewError: viewError)
                    }
                    
                    it("should have error message") {
                        expect(view.errorLabel.text).to(equal("Um erro ocorreu. Por favor, tente novamente."))
                    }
                    
                    it("should have error image") {
                        expect(view.errorImage.image).toNot(beNil())
                    }
                }
                
                context("handle error of type notFind") {
                    let title = "Movie"
                    
                    beforeEach {
                        let viewError = MovieListErrorView.ViewError(movieTitle: title, errorType: .notFind)
                        view.setError(viewError: viewError)
                    }
                    
                    it("should have error message") {
                        let message = "Sua busca por \"\(title)\" não resultou em nenhum resultado."
                        expect(view.errorLabel.text).to(equal(message))
                    }
                    
                    it("should have error image") {
                        expect(view.errorImage.image).toNot(beNil())
                    }
                }
                
            })
            
        }
    }
}

