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
    
    var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [])
        sv.alignment = .top
        sv.distribution = .fill
        sv.spacing = 20
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private func createRow(text: String, isHeader: Bool) {
        
        var view: InformationDetailView
        if isHeader {
            view = InformationDetailView(detailText: text,
                                             isHeader: true,
                                             isFavorite: presenter.itemViewData.isFavorite)
        } else {
            view = InformationDetailView(detailText: text, isHeader: false)
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.addArrangedSubview(view)
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.widthAnchor.constraint(equalTo: self.stackView.widthAnchor).isActive = true
    }
    
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
        self.view.addSubview(self.stackView)
        
        NSLayoutConstraint.activate([
            imageMovieImageView.topAnchor.constraint(equalTo: self.topAnchorSafeArea, constant: 8),
            imageMovieImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageMovieImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.442857),
            imageMovieImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.89),
            
            stackView.topAnchor.constraint(equalTo: self.imageMovieImageView.bottomAnchor, constant: 18),
            stackView.leadingAnchor.constraint(equalTo: self.imageMovieImageView.leadingAnchor, constant: 3),
            stackView.trailingAnchor.constraint(equalTo: self.imageMovieImageView.trailingAnchor, constant: -3),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchorSafeArea, constant: -8),
        ])
        imageMovieImageView.clipsToBounds = true
        
        
        
        
        
        self.createRow(text: self.presenter.itemViewData.movieName, isHeader: true)
        self.createRow(text: self.presenter.itemViewData.movieName, isHeader: false)
        self.createRow(text: self.presenter.itemViewData.movieName, isHeader: false)
    }
}
