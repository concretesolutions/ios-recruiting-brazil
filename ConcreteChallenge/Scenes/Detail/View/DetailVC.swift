//
//  DetailVC.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit
import os.log
import Kingfisher
import SnapKit

final class DetailVC: BaseViewController {
    
    // MARK: - Properties -
    var detailPresenter: DetailPresenter? {
        return presenter as? DetailPresenter
    }
    
    // MARK: View
    let detailTableView: UITableView = {
        let view = UITableView()
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.register(PosterDetailTableCell.self, forCellReuseIdentifier: PosterDetailTableCell.identifier)
        return view
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Methods -
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        
        detailTableView.dataSource = self
        detailTableView.delegate = self
    }
    
    override func addSubviews() {
        self.view.addSubview(detailTableView)
    }
    
    override func setupConstraints() {
        
        detailTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - TableView Data Source -
extension DetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // FIXME: Number of rows
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = detailTableView.dequeueReusableCell(withIdentifier: PosterDetailTableCell.identifier, for: indexPath) as? PosterDetailTableCell
//            let itemData = detailPresenter?.getItemData(item: indexPath.item)
        else {
            os_log("❌ - Unknown cell identifier %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
            fatalError("Unknown identifier")
        }
        
        // TODO: Implement favorite
//        cell.titleLabel.text = itemData.title
//        cell.filmImageView.kf.indicatorType = .activity
//        cell.filmImageView.kf.setImage(with: itemData.imageUrl)
        
        return cell
    }
}

extension DetailVC: UITableViewDelegate {
    
}
