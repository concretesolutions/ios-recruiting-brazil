//
//  ViewController.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 28/07/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit
protocol UIUpdate{
    func fetchUI()
}
class ViewController: UIViewController {
    let mainCollection = MainCollectionView(data: [])
    let mainTable = MainTableView(data: [])
    let backgroundImage = UIImageView(image:nil)
    let segment:UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items : ["Colection","Table"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = Color.oldPaper
        return segmentedControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewCoding()
        refreshData()
         segment.addTarget(self, action: #selector(ViewController.indexChanged(_:)), for: .valueChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateImage), name: NSNotification.Name(rawValue: "FetchImage"), object: nil)
       
        mainCollection.didSelect = {[weak self](model) in
            self?.goToDetail(movie:model.getMovie())
           
        }
        mainTable.didSelect = {[weak self](model) in
            self?.goToDetail(movie:model.getMovie())
            
        }
        mainTable.paging = true
        mainCollection.paging = true

    }
    
    func refreshData(){
        MovieAPI.movieRequest(mode:Request.popular(mainCollection.pageCount),sort:Sort.desc(.voteAverage)){
            [weak self]movies,err  in
            if err != nil{
                return
            }
            guard let self = self else{
                return
            }
            self.mainTable.data = self.mainTable.convertToModel(movie:movies)
            self.mainCollection.data = self.mainCollection.convertToModel(movie:movies)
            
        }
    }
    func goToDetail(movie:Movie){
        let detail = DetailViewController(movie: movie)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        if let navController = self.navigationController {
            navController.view.layer.add(transition, forKey: kCATransition)
            navController.pushViewController(detail, animated: false)
        }
    }

    
    @objc func updateImage()
    {
        mainCollection.refreshImages()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            self.mainCollection.isHidden = false
            self.mainTable.isHidden = true
        case 1:
            self.mainCollection.isHidden = true
            self.mainTable.isHidden = false
        default:
            break
        }
    }



}
extension ViewController:ViewCoding{
    func buildViewHierarchy() {
      self.view.addSubview(backgroundImage)
        self.view.addSubview(mainCollection)
        self.view.addSubview(mainTable)
        self.navigationItem.titleView = segment
        
        
    }
    
    func setUpConstraints() {
        backgroundImage.fillSuperview()
        mainCollection.fillSuperview()
        mainTable.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor,padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))


    }
    
    func additionalConfigs() {
    self.mainTable.isHidden = true
        backgroundImage.image = UIImage(named: "black_background")
        backgroundImage.contentMode = .scaleAspectFill
    }

    
}



