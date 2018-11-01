//
//  Utilities.swift
//  AppMovie
//
//  Created by Renan Alves on 28/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

struct Index {
    static func getIndexInArray(movie: MovieNowPlaying,at array: [MovieNowPlaying]) -> Int {
        for (index, _movie) in array.enumerated() {
            let _id = _movie.id
            let id = movie.id
            if  _id == id {
                return index
            }
        }
        return -1
    }
}

struct Activity {
    
    static func getActivityLoad(position: CGPoint, hidesWhenStopped: Bool,style: UIActivityIndicatorView.Style) -> UIActivityIndicatorView {
        
        let activity = UIActivityIndicatorView()
        
        activity.center = position
        activity.hidesWhenStopped = hidesWhenStopped
        activity.style = style
     
        return activity
    }
}

struct Load {
    
    static func getViewLoad(frame: CGRect,backGround: UIColor,tag: Int) -> UIView{
        let view = UIView(frame: frame)
        view.backgroundColor = .gray
        view.alpha = 0.5
        view.tag = 999
        return view
    }
}

struct Controller {
    
    static func createController(storyBoardName: String,controllerIdentifier: String) ->UIViewController {
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: controllerIdentifier)
        return controller
    }
}

enum PropertireMovie  {
    case adult, backdropPath, genre, id, language, originalTitle, overview, popularity, posterPath, releaseDate, title, video, voteAverage, voteCount
    
    var value: String {
        switch self {
        case  .adult:
            return "adult"
        case .backdropPath:
            return "backdrop_path"
        case .genre:
            return "genre_ids"
        case .id:
            return "id"
        case .language:
            return "language"
        case .originalTitle:
            return "original_title"
        case .overview:
            return "overview"
        case .popularity:
            return "popularity"
        case .posterPath:
            return "poster_path"
        case .releaseDate:
            return "release_date"
        case .title:
            return "title"
        case .video:
            return "video"
        case .voteAverage:
            return "vote_average"
        case .voteCount:
            return "vote_count"
        }
    }
}

enum Colors {
    case navigationController,backGroundCollectionViewCell, tabBarControler, unselectedItemTabaBar, selectedItemTabBar
    
    var value: UIColor {
        switch self {
        case .navigationController:
            return UIColor(red: 247/255, green: 212/255, blue: 114/255, alpha: 1)
        case .backGroundCollectionViewCell:
            return UIColor(red: 45/255, green: 49/255, blue: 71/255, alpha: 1)
        case .tabBarControler:
            return UIColor(red: 247/255, green: 212/255, blue: 114/255, alpha: 1)
        case .unselectedItemTabaBar:
            return UIColor(red: 163/255, green: 140/255, blue: 83/255, alpha: 1)
        case .selectedItemTabBar:
            return UIColor.black
        }
    }
}
