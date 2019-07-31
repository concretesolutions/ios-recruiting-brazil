//
//  FavoriteMoviesFilterController.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/29/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit
import RxSwift

final class FavoriteMoviesFilterController: UIViewController, StreamControllerProtocol {
    
    //MARK: - Variables -
    private var disposeBag = DisposeBag()
    private var presenter: FavoriteMoviesPresenterProtocol
    private var customView = FavoriteMoviesFilterView()
    
    //MARK: - Filter Variables -
    private var dates = BehaviorSubject<[String]>(value: [])
    private var genres = BehaviorSubject<[String]>(value: [])
    
    //MARK: - Constructors -
    init(presenter: FavoriteMoviesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override Methods -
    
    override func loadView() {
        super.loadView()
        
        self.view = customView
        setupLocalStreams()
        setupPresenterStreams()
        setupViewStreams()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.loadMoviesYear()
        self.presenter.loadMoviesGenres()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Methods -
    fileprivate func setupNavigationBar() {
        self.navigationItem.title = "Filters"
        self.navigationItem.hidesBackButton = true
    }
}

//MARK: - Configurações das Streams de dados locais de filtro -
extension FavoriteMoviesFilterController {
    func setupLocalStreams() {
        self.dates.bind(to: self.customView.datePicker.rx.itemTitles) { (row, element) in
            return element
        }.disposed(by: disposeBag)
        
        self.genres.bind(to: self.customView.genrePicker.rx.itemTitles) { (row, element) in
            return element
        }.disposed(by: disposeBag)
    }
}

//MARK: - Configurações das Streams do presenter -
extension FavoriteMoviesFilterController {
    func setupPresenterStreams() {
        self.presenter.loadMoviesYearStream.bind { [weak self] (years) in
            self?.dates.onNext(years.sorted())
        }.disposed(by: disposeBag)
        
        self.presenter.loadMoviesGenresStream.bind(to: self.genres).disposed(by: disposeBag)
    }
}

//MARK: - Configurações das Streams da view -
extension FavoriteMoviesFilterController {
    func setupViewStreams() {
        self.customView.datePicker.rx.itemSelected.bind { [weak self] (row, component) in
            guard let dates = try? self?.dates.value() else { return }
            self?.customView.dateTextField.text = dates[row]
        }.disposed(by: disposeBag)
        
        self.customView.genrePicker.rx.itemSelected.bind { [weak self] (row, component) in
            guard let genres = try? self?.genres.value() else { return }
            self?.customView.genreTextField.text = genres[row]
        }.disposed(by: disposeBag)
        
        self.customView.submitButton.rx.tap.bind { [weak self] (_) in
            self?.submitFilter()
        }.disposed(by: disposeBag)
        
        self.customView.cancelButton.rx.tap.bind { [weak self] (_) in
            self?.presenter.filterResults(with: "",
                                         and: "")
            self?.navigationController?.popViewController(animated: false)
        }.disposed(by: disposeBag)
        
        setupNavigationBar()
    }
    
    func submitFilter() {
        self.presenter.filterResults(with: self.customView.dateTextField.text!,
                                      and: self.customView.genreTextField.text!)
        self.navigationController?.popViewController(animated: true)
    }
}
