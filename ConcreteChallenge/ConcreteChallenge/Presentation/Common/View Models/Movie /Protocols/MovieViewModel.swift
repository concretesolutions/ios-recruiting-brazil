//
//  MovieViewModel.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import GenericNetwork

/// A viewmodel that provides data to MoviesViews
protocol MovieViewModel: AnyObject {
    
    /// the movies atributtes that will be showed in the view
    var movieAtributtes: (title: String, description: String, release: String) { get }
    
    /// called when the image of the movie need to be replaced
    var needReplaceImage: ((_ image: UIImage) -> Void)? { get set }
    
    /// calledwhen the genres label value needs change
    var needReplaceGenres: ((_ genres: String) -> Void)? { get set }
    
    /// its a delegate that contains methods necessary to navigate. Its used by the coordinator.
    var navigator: MovieViewModelNavigator? { get set }
    
    /// the view calls the this to  say the viewmodel when it is been reused. So the viewModel can cancel and stop necessary things.
    func movieViewWasReused()

    func closeButtonWasTapped()
}

protocol MovieViewModelWithData: MovieViewModel {
    var movie: Movie { get }
}
