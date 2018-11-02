//
//  DetailsViewController.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 02/11/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
  
  private var isLiked = false
  var poster: UIImage!
  var movie: PopularMovie!
  var genres = [Genre]()
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
    imageview.contentMode = .scaleAspectFit
    imageview.sizeToFit()
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
//    let size = posterImageView.getImageRatioBasedOnSize((posterImageView.image?.size)!)
//    posterImageView.frame.size = size
    
    return cell
  }()
  
  var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = label.font.withSize(16)
    label.numberOfLines = 0
    label.sizeToFit()
    return label
  }()
  
  lazy var likeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    if DefaultsMovie.shared.contains(id: movie.id) {
      button.setImage(UIImage(named: "favorite_full_icon.png"), for: .normal)
    } else {
      button.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
    }
    button.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
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
  
  var genreTitle: String = ""
  
  override func loadView() {
    self.view = ContainerView(frame: UIScreen.main.bounds)
    view.backgroundColor = .white
    setupView()
  }
  
  @objc func likeButtonAction() {
    isLiked = !DefaultsMovie.shared.contains(id: movie.id)
    if isLiked {
      likeButton.setImage(UIImage(named: "favorite_full_icon.png"), for: .normal)
      DefaultsMovie.shared.saveMoveId(movie.id)
    } else {
      likeButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
      DefaultsMovie.shared.deleteId(movie.id)
    }
  }
  
  func getGenres(completion: @escaping (Result<String?>) -> ()) {
    var text = ""
    Network.shared.requestGenres { (result) in
      switch result {
      case .success(let resultGenres):
        for genreId in self.movie.genre_ids! {
          _ = resultGenres?.genres.contains(where: { (genre) -> Bool in
            if genre.id == genreId {
              text.append("\(genre.name), ")
              return true
            }
            return false
          })
        }
        if !text.isEmpty {
          _ = text.popLast()
          _ = text.popLast()
        }
        completion(.success(text))
      case .failure(let error):
        print("error: \(error.localizedDescription)")
        completion(.failure(error))
      }
    }
  }
  
  func getDate(stringDate: String) -> DateComponents  {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd"
    dateFormat.locale = Locale(identifier: "pt_BR")
    let date = dateFormat.date(from: stringDate)
    let components = Calendar.current.dateComponents([.year], from: date!)
    return components
  }
  
  
  func setupView() {
    addViews()
  }
  func addViews() {
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
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.numberOfLines = 0
    cell.textLabel?.sizeToFit()
    switch indexPath.row {
    case 0:
      return cellposterImage
    case 1:
      titleLabel.text = movie.title
      return cellTitle
    case 2:
      cell.textLabel?.text = "\(getDate(stringDate: movie.release_date).year!)"
      return cell
    case 3:
      getGenres { (result) in
        switch result {
        case .success(let genreText):
          cell.textLabel?.text = genreText
        case.failure(let error):
          print("error: \(error.localizedDescription)")
        }
      }
      cell.textLabel?.text = "Ação, Aventura"
      return cell
    case 4:
      cell.textLabel?.font = cell.textLabel?.font.withSize(14)
      cell.textLabel?.text = movie.overview
      return cell
    default:
      return UITableViewCell()
    }
  }
  
  
}
