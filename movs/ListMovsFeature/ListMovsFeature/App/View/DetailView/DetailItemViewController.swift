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
    
    var image: UIImageView = {
        let img = UIImageView(image: Assets.Images.defaultImageMovs)
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red//Colors.yellowLight.withAlphaComponent(0.5)
        return view
    }()
    
    var informationDataSource: BaseTableViewDataSource!
    var informationsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .blue
        return tableView
    }()
    
    var nameAndFavoriteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    var detailLabel: UILabel = {
        let label = UILabel()
        label.font = FontAssets.avenirTextCell
        label.text = "A vida é uma caixa de surpresa"
        label.textColor = Colors.blueDark
        return label
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
        
        
        self.informationDataSource = BaseTableViewDataSource(in: self.informationsTableView,
                                                             list: ["test", "alouca", "gow"],
                                                             identifierCell: "reuseCell")
        
        self.informationsTableView.dataSource = self.informationDataSource
        
        
        self.setupView()
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.informationsTableView.reloadData()
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
       
        self.view.addSubview(self.image)
        self.view.addSubview(self.informationsTableView)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchorSafeArea, constant: 130),
            image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            image.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.142857),
            image.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.68),
            
            informationsTableView.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: -8),
            informationsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            informationsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            informationsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 8),
        ])
    }
}
