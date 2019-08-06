//
//  DetailViewController.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 01/08/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var containerView:DetailView
    override func viewDidLoad() {
        
      
    
    }
    init(movie:Movie) {
        containerView = DetailView(movie: movie)
        super.init(nibName: nil, bundle: nil)
        initViewCoding()
        containerView.backButton.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        containerView.trailerButton.addTarget(self, action: #selector(self.fireTrailer), for: .touchUpInside)
        containerView.favoriteButton.addTarget(self, action: #selector(self.favoriteMovie), for: .touchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func fireTrailer(){
        MovieAPI.requestYoutube(id: String(containerView.detailModel.id))
        
    }
    @objc func favoriteMovie(){
        let favoriteButton = containerView.favoriteButton
        favoriteButton.isSelected = !favoriteButton.isSelected
        if(!favoriteButton.isSelected){
            CoreDataAPI.delete(id: containerView.detailModel.id)
        }else{
            let model = containerView.detailModel.getModel()
            
            CoreDataAPI.save(movie:model)
        }
        
    }
    
    
    @objc func backAction(){
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.popViewController(animated: false)
    }


}
extension DetailViewController:ViewCoding{
    func buildViewHierarchy() {
        self.view.addSubview(containerView)
    }
    
    func setUpConstraints() {
        containerView.fillSuperview()
    }
    
    func additionalConfigs() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = nil
    }
    
    
}



