//
//  DetailsViewController.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 02/11/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
  
  var poster: UIImage!
  lazy var tableview: UITableView = {
    let table = UITableView()
    table.dataSource = self
    table.tableFooterView = UIView(frame: .zero)
    table.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    table.translatesAutoresizingMaskIntoConstraints = false
    return table
  }()
  lazy var posterImageView: UIImageView = {
    let imageview = UIImageView()
    imageview.image = poster
    imageview.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
    imageview.layer.borderWidth = 0.5
    imageview.translatesAutoresizingMaskIntoConstraints = false
    return imageview
  }()
  lazy var cellposterImage: UITableViewCell = {
    let cell = UITableViewCell()
    cell.addSubview(posterImageView)
    posterImageView.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 15).isActive = true
    posterImageView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 15).isActive = true
    posterImageView.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -15).isActive = true
    posterImageView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
    posterImageView.image = poster
    _ = posterImageView.getImageRatioBasedOnSize((posterImageView.image?.size)!)
    
    return cell
  }()
  var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = label.font.withSize(16)
    label.text = "Thor: Ragnarok"
    label.numberOfLines = 0
    label.sizeToFit()
    return label
  }()
  
  var likeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(#imageLiteral(resourceName: "favorite_full_icon.png"), for: .normal)
    return button
  }()
  lazy var cellTitle: UITableViewCell = {
    let cell = UITableViewCell()
    cell.addSubview(titleLabel)
    cell.addSubview(likeButton)
    
    titleLabel.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 15).isActive = true
    titleLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 15).isActive = true
    titleLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -15).isActive = true
    titleLabel.rightAnchor.constraint(equalTo: likeButton.leftAnchor, constant: -5).isActive = true
    likeButton.topAnchor.constraint(equalTo: cell.topAnchor, constant: 15).isActive = true
    likeButton.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -15).isActive = true
    likeButton.bottomAnchor.constraint(lessThanOrEqualTo: cell.bottomAnchor).isActive = true
    likeButton.widthAnchor.constraint(equalToConstant: (likeButton.image(for: .normal)?.size.height)!).isActive = true
    
    return cell
  }()
  var yearLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = label.font.withSize(16)
    label.text = "2008"
    label.numberOfLines = 0
    label.sizeToFit()
    return label
  }()
  lazy var cellDate: UITableViewCell = {
    let cell = UITableViewCell()
    cell.addSubview(yearLabel)
    yearLabel.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 15).isActive = true
    yearLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 15).isActive = true
    yearLabel.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -15).isActive = true
    yearLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -15).isActive = true
    return cell
  }()
  var genreLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.sizeToFit()
    label.numberOfLines = 0
    label.text = "ação, aventura"
    return label
  }()
  
  lazy var cellGenre: UITableViewCell = {
    let cell = UITableViewCell()
    cell.addSubview(genreLabel)
    genreLabel.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 15).isActive = true
    genreLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 15).isActive = true
    genreLabel.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -15).isActive = true
    genreLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -15).isActive = true
    return cell
  }()
  
  var overviewLabel: UILabel = {
    var label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.sizeToFit()
    label.numberOfLines = 0
    label.text = "ação, aventura ação, aventura ação, aventura ação, aventura ação, aventura ação, aventura ação, aventura ação, aventura ação, aventura ação, aventura ação, aventura ação, aventura ação, aventura ação, aventura ação, aventura ação, aventura ação, aventura ação, aventura ação, aventura ação, aventura "
    return label
  }()
  
  lazy var cellOverview: UITableViewCell = {
    let cell = UITableViewCell()
    cell.addSubview(overviewLabel)
    cell.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 15).isActive = true
    cell.topAnchor.constraint(equalTo: cell.topAnchor, constant: 15).isActive = true
    cell.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -15).isActive = true
    cell.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -15).isActive = true
    return cell
  }()
  
  override func loadView() {
    self.view = ContainerView(frame: UIScreen.main.bounds)
    view.backgroundColor = .white
    setupView()
  }
  
  func setupView() {
    addViews()
//    posterImageView.heightAnchor.constraint(equalToConstant: (posterImageView.image?.size.height)!).isActive = true
//    posterImageView.widthAnchor.constraint(equalToConstant: (posterImageView.image?.size.width)!).isActive = true
  }
  func addViews() {
//    view.addSubview(posterImageView)
    view.addSubview(tableview)
    addConstraints()
  }
  
  func addConstraints() {
    tableview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.numberOfLines = 0
    cell.textLabel?.sizeToFit()
    switch indexPath.row {
    case 0:
      return cellposterImage
    case 1:
      return cellTitle
    case 2:
      return cellDate
    case 3:
      return cellGenre
    default:
      return UITableViewCell()
    }
  }
  
  
}
