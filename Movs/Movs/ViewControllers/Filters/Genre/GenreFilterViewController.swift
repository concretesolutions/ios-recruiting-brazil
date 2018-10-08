//
//  GenreFilterViewController.swift
//  Movs
//
//  Created by Dielson Sales on 08/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit
import RxSwift

class GenreFilterViewController: UITableViewController {

    enum Constants {
        static let cellIdentifier = "GenreCell"
    }

    private var genres = [String]()
    private let genresDataSource: GenresDataSource = GenresDataSourceImpl()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Genre"
        tableView.register(GenreFilterCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        requestGenres()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? GenreFilterCell {
            cell.textLabel?.text = genres[indexPath.row]
            return cell
        }
        fatalError("Cell not configured")
    }

    private func requestGenres() {
        genresDataSource.fetchGenres().map { (genres: [Genre]) -> [String] in
            return genres.map({ $0.name }) }
            .subscribe(onSuccess: { (genres: [String]) in
                self.genres = genres
                self.tableView.reloadData()
            }, onError: { (error: Error) in
                // TODO
            })
            .disposed(by: disposeBag)
    }
}
