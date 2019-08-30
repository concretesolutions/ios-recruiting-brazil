//
//  HomeViewControllerSpec.swift
//  MovieAppTests
//
//  Created by Mac Pro on 29/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Nimble_Snapshots

@testable import MovieApp

class HomeViewControllerSpec: QuickSpec {

    override func spec() {
        describe("Teste de layout esperado") {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let sut = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            
            let movie = MovieController()
           sut.controller = movie.getLocalMovie()!
            
            WindowHelper.showInTestWindow(viewController: sut)

                
            context("Espero que a tela de home carrega") {
                
                it("com lista de filmes") {
                    expect(sut).to(haveValidSnapshot())
                }
            }
        }
        
    }
}
