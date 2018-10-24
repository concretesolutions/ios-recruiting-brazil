//
//  MainScreenModels.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 23/10/18.
//  Copyright (c) 2018 Leonel Menezes. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Keys

enum MainScreen
{
    // MARK: Use cases
    
    enum Something
    {
        struct Request
        {
        }
        struct Response
        {
        }
        struct ViewModel
        {
        }
    }
    
    enum FetchPopularMuvies {
        struct Request {
            var index: Int = 1
            var apiKey : String
            var language: String
            init(index: Int, apiKey: String, language: String) {
                self.index = index
                self.apiKey = apiKey
                self.language = language
            }
            func url() -> String {
                return "https://api.themoviedb.org/3/movie/popular?api_key=\(ConcretoFilmesKeys().tHE_MOVIE_DB_V3_KEY)&language=\(Locale.preferredLanguages[0] as String)&page=\(index)"
            }
        }
        
        struct Response {
            
        }
    }
}

