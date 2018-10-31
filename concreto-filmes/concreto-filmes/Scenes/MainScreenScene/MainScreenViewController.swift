//
//  MainScreenViewController.swift
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
import SnapKit
import RealmSwift

enum AppStatus {
    case resetFetch
    case fetchingMore
    case finish
    case emptyList
}

protocol MainScreenDisplayLogic: class {
    func display(movies: [MainScreen.ViewModel.MovieViewModel])
    func displayAlert(title: String, message: String)
}

class MainScreenViewController: UICollectionViewController, MainScreenDisplayLogic {
    var interactor: MainScreenBusinessLogic?
    var router: (NSObjectProtocol & MainScreenRoutingLogic & MainScreenDataPassing)?

    let movieCellID = "movieCellID"
    var displayedMovies: [MainScreen.ViewModel.MovieViewModel] = []
    internal var isFiltering = false

    var applicationStatus: AppStatus = .resetFetch {
        didSet {
            switch self.applicationStatus {
            case .resetFetch:
                DispatchQueue.main.async {
                    self.activityIndicator.startAnimating()
                    self.emptyListLabel.isHidden = true
                }
            case .finish:
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.emptyListLabel.isHidden = true
                }
            case .fetchingMore:
                self.beginBatchFetch()
                DispatchQueue.main.async {
                    self.emptyListLabel.isHidden = true
                }
            case .emptyList:
                DispatchQueue.main.async {
                    self.emptyListLabel.isHidden = false
                }
            }
        }
    }

    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let emptyListLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Desculpe, não pudemos achar nada...\nVocê pode tentar apertar o botão de busca caso não tenha feito."
        label.numberOfLines = 3
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()

    private let leftBarButton: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = #imageLiteral(resourceName: "MOV")
        btn.tintColor = .black
        return btn
    }()

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.layer.borderColor = UIColor.gray.cgColor
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.fetchPopularMovies(shouldResetMovies: true)
        interactor?.initialFetch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactor?.presentCurrentMovies(isFiltering: self.isFiltering)
    }

    // MARK: Object lifecycle

    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = MainScreenInteractor()
        let presenter = MainScreenPresenter()
        let router = MainScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    func display(movies: [MainScreen.ViewModel.MovieViewModel]) {
        self.displayedMovies = movies
        self.applicationStatus = .finish
        if movies.isEmpty {
            self.applicationStatus = .emptyList
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tentar novamente", style: .default, handler: { (_) in
            self.interactor?.fetchPopularMovies(shouldResetMovies: self.applicationStatus == .resetFetch)
        }))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
            self.applicationStatus = .finish
        }))
        self.present(alert, animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.endEditing(true)
    }

    // MARK: - Scroll View

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height && applicationStatus != .fetchingMore && applicationStatus != .resetFetch {
            self.applicationStatus = .fetchingMore
        }
    }

    func beginBatchFetch() {
        if isFiltering {
            interactor?.fetchQueriedMovies(text: self.searchBar.text ?? "", shouldResetMovies: false)
        } else {
            interactor?.fetchPopularMovies(shouldResetMovies: false)
        }
    }
}

extension MainScreenViewController: CodeView {
    func buildViewHierarchy() {
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.titleView = searchBar
        view.addSubview(self.activityIndicator)
        view.addSubview(self.emptyListLabel)
    }

    func setupConstraints() {
        self.activityIndicator.snp.makeConstraints { (maker) in
            maker.center.equalTo(self.view)
        }
        self.emptyListLabel.snp.makeConstraints { (maker) in
            maker.center.equalTo(view)
            maker.left.equalTo(view).offset(20)
            maker.right.equalTo(view).inset(20)
        }
    }

    func setupAdditionalConfiguration() {
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.barTintColor = AppColors.mainYellow.color
        collectionView.register(MainScreenMovieCell.self, forCellWithReuseIdentifier: self.movieCellID)
        self.activityIndicator.startAnimating()
        self.navigationController?.navigationBar.isTranslucent = false
    }
}
