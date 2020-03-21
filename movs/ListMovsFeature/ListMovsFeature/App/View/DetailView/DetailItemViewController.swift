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
    private let nsLoadImage = NLLoadImage()
    
    private var headerTopConstraint: NSLayoutConstraint!
    private var headerHeightConstraint: NSLayoutConstraint!
    
    struct Constants {
        static fileprivate let headerHeight: CGFloat = 410
    }
    
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var headerImageView: UIImageView = {
        let img = UIImageView(image: Assets.Images.defaultImageMovs)
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .clear
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isScrollEnabled = true
        
        sv.alwaysBounceVertical = true
        sv.bouncesZoom = true
        
        sv.showsVerticalScrollIndicator = true
//        sv.clipsToBounds = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
//            sv.contentInsetAdjustmentBehavior = .never
        }
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
    deinit {
        print("TESTE LIFECYCLE -- DetailItemViewController")
    }
}

//MARK: - private funcs -
extension DetailItemViewController {
    
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
        UIView.transition(with: self.headerImageView,
                            duration: 0.75,
                            options: .transitionCrossDissolve,
                            animations: {
                                self.headerImageView.image = image
                                
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
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            view.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 8),
            view.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -8),
        ])
                
        self.view.layoutIfNeeded()
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
        setupArrangedUIs()
        setupColors()
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: 1000)
        self.headerImageView.clipsToBounds = true
        
        setupConstraints()
    }
    
    private func setupColors() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = Colors.blueDark
    }
    
    private func setupArrangedUIs() {
        self.containerView.addSubview(headerImageView)
        self.containerView.addSubview(stackView)
        
        self.scrollView.addSubview(containerView)
        self.view.addSubview(scrollView)
    }
    
    private func setupConstraints(){
        //SCROLLVIEW
        let scrollViewConstraints: [NSLayoutConstraint] = [
            scrollView.topAnchor.constraint(equalTo: self.topAnchorSafeArea),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchorSafeArea),
        ]
        
        
        // CONTAINER
        let containerViewConstraints: [NSLayoutConstraint] = [
            containerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            containerView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            containerView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 1000),
        ]
        
        //HEADER IMAGE VIEW
        let headerImageViewConstraints: [NSLayoutConstraint] = [
            headerImageView.topAnchor.constraint(equalTo: self.topAnchorSafeArea),
            headerImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -10),
        ]
        
        // STACK VIEW
        let stackViewContraints: [NSLayoutConstraint] = [
            stackView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 350),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(containerViewConstraints)
        NSLayoutConstraint.activate(stackViewContraints)
        NSLayoutConstraint.activate(headerImageViewConstraints)
    }
}

