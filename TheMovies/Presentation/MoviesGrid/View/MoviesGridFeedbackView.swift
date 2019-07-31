//
//  MoviesGridFeedbackView.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/30/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//


import UIKit

final class MoviesGridFeedbackView: UIView {
    //MARK:- Views -
    
    private(set) var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sad_face")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .gray
        return view
    }()
    
    private(set) var message: UILabel = {
        let view = UILabel()
        view.textColor = .gray
        view.text = "No movies added"
        return view
    }()
    
    //MARK:- Constructors -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- Override Methods -
    override func didMoveToWindow() {
        super.didMoveToWindow()
        setupConstraints()
    }
    
    //MARK:- Methods -
    
    enum FeedbackType {
        case noMoviesAdded
        case noMoviesFounded
        case errorOccurred
    }
    
    
    /// Mostra a view com a característica do feedback escolhido
    ///
    /// - Parameter type: Tipo do Feedback
    func show(type: FeedbackType) {
        self.isHidden = false
        switch type {
        case .noMoviesFounded:
            imageView.image = UIImage(named: "search_icon")?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = .gray
            
            message.text = "No movies found"
            message.textColor = .gray
        case .noMoviesAdded:
            imageView.image = UIImage(named: "sad_face")?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = .gray
            
            message.text = "No movies added"
            message.textColor = .gray
        case .errorOccurred:
            imageView.image = UIImage(named: "dead_face")?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = .red
            
            message.text = "An error ocurred"
            message.textColor = .red
        }
    }
    
    fileprivate func setupUIElements() {
        // arrange subviews
        backgroundColor = .white
        
        self.isHidden = true
        self.addSubview(imageView)
        self.addSubview(message)
    }
    
    fileprivate func setupConstraints() {
        //        let guide = self.safeAreaLayoutGuide
        
        message.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.bottom.equalTo(message.snp.top).offset(-20)
            ConstraintMaker.width.height.equalTo(self.snp.width).dividedBy(4)
            ConstraintMaker.centerX.equalTo(message)
        }
    }
}


