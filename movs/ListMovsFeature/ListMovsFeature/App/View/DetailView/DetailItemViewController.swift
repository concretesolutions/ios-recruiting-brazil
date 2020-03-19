//
//  DetailItemViewController.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 17/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import AssertModule

import CommonsModule

open class DetailItemViewController: BaseViewController {
    var presenter: DetailItemMovsPresenter!
    
    var imageMovieImageView: UIImageView = {
        let img = UIImageView(image: Assets.Images.defaultImageMovs)
        img.contentMode = .scaleAspectFill
        img.backgroundColor = .black
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var informationDetailView: InformationDetailView = {
        let view = InformationDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    deinit {
        print("TESTE LIFECYCLE -- DetailItemViewController")
    }
}


//MARK: -lifecycle-
extension DetailItemViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.loadingView()
        self.setupView()
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

//MARK: -input of Presenter-
extension DetailItemViewController: DetailItemMovsView {
    
    func setTitle(_ title: String) {
        self.title = title
    }
}


//MARK: - aux func -
extension DetailItemViewController {
    private func setupView() {
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = Colors.blueDark
       
        self.view.addSubview(self.imageMovieImageView)
        self.view.addSubview(self.informationDetailView)
        NSLayoutConstraint.activate([
            imageMovieImageView.topAnchor.constraint(equalTo: self.topAnchorSafeArea, constant: 8),
            imageMovieImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageMovieImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.442857),
            imageMovieImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.89),//0.68
            
            informationDetailView.topAnchor.constraint(equalTo: self.imageMovieImageView.bottomAnchor, constant: 18),
            informationDetailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            informationDetailView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            informationDetailView.bottomAnchor.constraint(equalTo: self.bottomAnchorSafeArea, constant: -16),
        ])
        
        imageMovieImageView.clipsToBounds = true
    }
}
