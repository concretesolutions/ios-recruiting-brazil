//
//  DetailViewController.swift
//  DesafioConcrete
//
//  Created by Luiz Otavio Processo on 30/11/19.
//  Copyright © 2019 Luiz Otavio Processo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailView:DetailView?
    var movieImg = UIImage()
    var movie:Results?
    
    init(result:Results) {
        super.init(nibName: nil, bundle: nil)
        self.movie = result
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView = DetailView(frame: self.view.frame)
        self.view = detailView
        fillContent()

    }
    
    func fillContent(){
        detailView?.poster.image = movieImg
        detailView?.movieName.text = movie?.original_title
        detailView?.movieCategory.text = " "
        detailView?.movieDescription.text = movie?.overview
        
        //adjust date labe from yyyy-mm-dd to only yyyy
        let releaseDate = movie?.release_date?.split(separator: "-")
        detailView?.movieYear.text = String(releaseDate![0])
        
        // transform int genre types to string genre types
        var count = 0
        for genre in Singleton.shared.genresArray{
            let lastIteration = movie!.genre_ids.count-1
            for id in movie!.genre_ids{
                if (id == genre.id){
                    if(lastIteration == count){
                        detailView?.movieCategory.text = (detailView?.movieCategory.text)!+"\(genre.name!)"
                        break
                    }else{
                        detailView?.movieCategory.text = (detailView?.movieCategory.text)!+"\(genre.name!), "
                        count += 1
                    }
                }
            }
        }
    }
}
