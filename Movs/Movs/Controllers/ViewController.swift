//
//  ViewController.swift
//  Movs
//
//  Created by Julio Brazil on 21/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
//    var movie: CodableMovie
//
//
//    var image: UIImageView {
//        let image = UIImageView(image: nil)
//
//        if let url = URL(string: TMDBManager.imageEndpoint + (movie.backdrop_path ?? "")) {
//            image.sd_setImage(with: url)
//        }
//
//        return image
//    }()
//    var titleLabel: UILabel {
//        let label = UILabel(frame: .zero)
//        return
//    }()
//    var yearLabel: UILabel {
//
//    }()
//    var generLabel: UILabel {
//
//    }()
//    var descripLabel: UILabel {
//
//    }()
//    var favoriteButton: UIButton {
//        //TODO: add/remove movie from favorites
//    }()
    
    init(presenting movie: CodableMovie) {
        super.init(nibName: nil, bundle: nil)
        
//        self.movie = movie
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}

//extension ViewController: CodeView {
//    func buildViewHierarchy() {
//        self.view.addSubview(image)
//        self.view.addSubview(titleLabel)
//        self.view.addSubview(favoriteButton)
//        self.view.addSubview(yearLabel)
//        self.view.addSubview(generLabel)
//        self.view.addSubview(descripLabel)
//    }
//
//    func setupConstraints() {
//        <#code#>
//    }
//
//    func setupAdditionalConfiguration() {
//        <#code#>
//    }
//}
