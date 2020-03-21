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
    
    var headerContainerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var headerImageView: UIImageView = {
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
        if #available(iOS 11.0, *) {
            sv.contentInsetAdjustmentBehavior = .never
        }
        return sv
    }()
    
    var stackViewContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        view.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
//        view.widthAnchor.constraint(equalTo: self.stackView.widthAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 8).isActive = true
        view.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -8).isActive = true
        
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
        
        // COLORS
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = Colors.blueDark
       
        self.scrollView.delegate = self
        
        //ARRANGED VIEW
        headerContainerView.addSubview(headerImageView)
        scrollView.addSubview(headerContainerView)
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        //stackViewContainerView
        
        
        // CONSTRAINTS
        
        //SCROLLVIEW
        let scrollViewConstraints: [NSLayoutConstraint] = [
            scrollView.topAnchor.constraint(equalTo: self.topAnchorSafeArea),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchorSafeArea),
        ]
        
        //HEADER CONTAINER VIEW
        headerTopConstraint = headerContainerView.topAnchor.constraint(equalTo: self.topAnchorSafeArea)
        headerHeightConstraint = headerContainerView.heightAnchor.constraint(equalToConstant: 210)
        let headerContainerViewConstraints: [NSLayoutConstraint] = [
            headerTopConstraint,
            headerContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0),
            headerHeightConstraint
        ]
        
        
        //HEADER IMAGE VIEW
        let headerImageViewConstraints: [NSLayoutConstraint] = [
           headerImageView.topAnchor.constraint(equalTo: headerContainerView.topAnchor, constant: 16),
           headerImageView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
           headerImageView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
           headerImageView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor)
       ]
        
        // STACK VIEW
        let stackViewContraints: [NSLayoutConstraint] = [
            stackView.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: 16),
//            stackView.leadingAnchor.constraint(equalTo: self.headerContainerView.leadingAnchor, constant: 8),
//            stackView.trailingAnchor.constraint(equalTo: self.headerContainerView.trailingAnchor, constant: -8),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
//            stackView.heightAnchor.constraint(equalToConstant: 800)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(headerContainerViewConstraints)
        NSLayoutConstraint.activate(headerImageViewConstraints)
        NSLayoutConstraint.activate(stackViewContraints)
                
    }
}

//MARK: - ScrollView controller Parallex
extension DetailItemViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0.0 {
            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
        } else {
            let parallaxFactor: CGFloat = 0.25
            let offsetY = scrollView.contentOffset.y * parallaxFactor
            let minOffsetY: CGFloat = 8.0
            let availableOffset = min(offsetY, minOffsetY)
            let contentRectOffsetY = availableOffset / Constants.headerHeight
            headerTopConstraint?.constant = view.frame.origin.y
            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
            headerImageView.layer.contentsRect = CGRect(x: 0, y: -contentRectOffsetY, width: 1, height: 1)
        }
    }
}
