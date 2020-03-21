//
//  DetailItemViewController.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 17/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import AssertModule
import NetworkLayerModule

import CommonsModule


enum DetailItemHandleState {
    case loading(Bool)
    case success(MovsItemViewData)
}


open class DetailItemViewController: BaseViewController {
    var presenter: DetailItemMovsPresenter!
    let nsLoadImage = NLLoadImage()
    
    var imageMovieImageView: UIImageView = {
        let img = UIImageView(image: Assets.Images.defaultImageMovs)
        img.contentMode = .scaleAspectFill
        img.backgroundColor = .clear
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = true
        sv.isScrollEnabled = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alwaysBounceVertical = true
        return sv
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
    
    var stateHandleUI: DetailItemHandleState? {
        didSet {
            self.performStateUI()
        }
    }
    
    
    private func performStateUI() {
        guard let stateHandleUI = self.stateHandleUI else { return }
        switch stateHandleUI {
        case .loading(let isLoading):
            print(isLoading)
            break
        case .success(let itemViewData):
            
            self.loadImage(with: itemViewData.imageMovieURLAbsolute)
            self.createRow(text: itemViewData.movieName, isHeader: true, isFavorite: itemViewData.isFavorite)
            self.createRow(text: itemViewData.movieName, isHeader: false)
            self.createRow(text: itemViewData.movieName, isHeader: false)
            self.createRow(text: itemViewData.movieName, isHeader: false)
            self.createRow(text: itemViewData.movieName, isHeader: false)
            self.createRow(text: itemViewData.overview, isHeader: false)
            break
        }
    }
    
    
    private func loadImage(with urlString: String) {
        
        //Load from cache
        if let image = ImageCache.shared.getImage(in: urlString) {
            self.setImage(with: image)
            return
        }
        
        self.nsLoadImage.loadImage(absoluteUrl: urlString) { [weak self] data in
            DispatchQueue.main.async {
                if let data = data,
                    let image = UIImage(data: data) {
                    ImageCache.shared.setImage(image, in: urlString)
                    
                    self?.setImage(with: image)
                } else {
                    self?.setImage(with: Assets.Images.defaultImageMovs!)
                    
                }
            }
        }
    }
    
    private func setImage(with image: UIImage) {
        UIView.transition(with: self.imageMovieImageView,
                            duration: 0.75,
                            options: .transitionCrossDissolve,
                            animations: {
                                self.imageMovieImageView.image = image
                                
        },completion: nil)
    }
    
    private func createRow(text: String, isHeader: Bool, isFavorite: Bool = false) {
        
        var view: InformationDetailView
        if isHeader {
            view = InformationDetailView(detailText: text,
                                             isHeader: true,
                                             isFavorite: isFavorite)
        } else {
            view = InformationDetailView(detailText: text, isHeader: false)
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.addArrangedSubview(view)
        view.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
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
    func showLoading() {
        self.stateHandleUI = .loading(true)
    }
    
    func hideLoading() {
        self.stateHandleUI = .loading(false)
    }
    
    func fillUp(with viewData: MovsItemViewData) {
        self.stateHandleUI = .success(viewData)
    }
        
    func setTitle(_ title: String) {
        self.title = title
    }
}


//MARK: - aux func -
extension DetailItemViewController {
    private func setupView() {
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = Colors.blueDark
       
        //self.view.addSubview(self.imageMovieImageView)
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.imageMovieImageView)
        self.scrollView.addSubview(self.stackView)
        
//        self.view.addSubview(self.stackView)
        
        NSLayoutConstraint.activate([
            
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchorSafeArea),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchorSafeArea),
            
            imageMovieImageView.topAnchor.constraint(equalTo: self.topAnchorSafeArea, constant: 8),
            imageMovieImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            imageMovieImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.442857),
            imageMovieImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 4),
            imageMovieImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -4),
            
//            scrollView.topAnchor.constraint(equalTo: self.imageMovieImageView.bottomAnchor, constant: 18),
//            scrollView.leadingAnchor.constraint(equalTo: self.imageMovieImageView.leadingAnchor, constant: 3),
//            scrollView.trailingAnchor.constraint(equalTo: self.imageMovieImageView.trailingAnchor, constant: -3),
//            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchorSafeArea, constant: -4),
            
            stackView.topAnchor.constraint(equalTo: self.imageMovieImageView.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: self.imageMovieImageView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.imageMovieImageView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        imageMovieImageView.clipsToBounds = true
    }
}
