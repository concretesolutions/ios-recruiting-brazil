//
//  MovieDetailViewController.swift
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
import SnapKit
import SDWebImage

protocol MovieDetailDisplayLogic: class {
    func displayMovie(viewModel: MovieDetail.ViewModel)
}

enum FavoriteViewState {
    case favourited, notFavourited
}

class MovieDetailViewController: UIViewController, MovieDetailDisplayLogic {
    var interactor: MovieDetailBusinessLogic?
    var router: (NSObjectProtocol & MovieDetailRoutingLogic & MovieDetailDataPassing)?
    
    var didFavorite : (() -> Void)?
    var didUnfavorite : (() -> Void)?
    var displayedMovie: MovieDetail.ViewModel
    
    var viewState: FavoriteViewState = .notFavourited {
        didSet {
            if viewState == .notFavourited {
                self.favoriteButton.setImage(#imageLiteral(resourceName: "favorite_gray_icon"), for: .normal)
            } else {
                self.favoriteButton.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
            }
        }
    }

    private var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()

    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(touchUpInsideButton), for: .touchUpInside)
        return button
    }()

    private lazy var titleView: UIStackView = {
        let view = UIStackView()
        view.alignment = UIStackView.Alignment.fill
        view.axis = .horizontal
        view.addArrangedSubview(self.titleLabel)
        view.addArrangedSubview(self.favoriteButton)
        return view
    }()

    private let releaseDateView: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()

    private let genresLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()

    private let overviewView: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.backgroundColor = .black
        return textView
    }()

    // MARK: Object lifecycle
    
    init(viewModel: MovieDetail.ViewModel) {
        self.displayedMovie = viewModel
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter()
        let router = MovieDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        displayMovie(viewModel: self.displayedMovie)
    }

    func displayMovie(viewModel: MovieDetail.ViewModel) {
        self.coverImageView.sd_setImage(with: URL(string: viewModel.movieImageURL)) { (image, _, _, _) in
            if image == nil {
                DispatchQueue.main.async {
                    self.coverImageView.image = #imageLiteral(resourceName: "placeholder")
                }
            }
        }
        self.overviewView.text = viewModel.overview
        self.titleLabel.text = viewModel.title
        self.genresLabel.text = viewModel.genres
        self.releaseDateView.text = viewModel.releaseDate
        self.viewState = viewModel.isFavorite ? .favourited : .notFavourited
    }
}

extension MovieDetailViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(self.verticalStack)
        verticalStack.addArrangedSubview(self.coverImageView)
        verticalStack.addArrangedSubview(self.titleView)
        verticalStack.addArrangedSubview(self.releaseDateView)
        verticalStack.addArrangedSubview(self.genresLabel)
        verticalStack.addArrangedSubview(self.overviewView)
    }

    func setupConstraints() {
        verticalStack.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).inset(20)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.coverImageView.snp.makeConstraints { (maker) in
            maker.height.equalTo(self.view.frame.height/2)
            maker.width.equalTo(verticalStack)
        }
        self.titleView.snp.makeConstraints { (maker) in
            maker.height.equalTo(50)
            maker.width.equalTo(verticalStack)
        }
        self.releaseDateView.snp.makeConstraints { (maker) in
            maker.height.equalTo(self.titleView)
            maker.width.equalTo(verticalStack)
        }
        self.genresLabel.snp.makeConstraints { (maker) in
            maker.height.equalTo(self.titleView)
            maker.width.equalTo(verticalStack)
        }
        self.overviewView.snp.makeConstraints { (maker) in
            maker.width.equalTo(verticalStack)
        }
        self.favoriteButton.snp.makeConstraints { (maker) in
            maker.height.equalTo(50)
            maker.width.equalTo(50)
        }
    }

    func setupAdditionalConfiguration() {
        view.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = .black
    }

}

extension MovieDetailViewController {
    @objc fileprivate func touchUpInsideButton() {
        if viewState == .favourited {
            viewState = .notFavourited
        } else {
            viewState = .favourited
        }
        interactor?.toggleFavoriteMovie()
    }
}
