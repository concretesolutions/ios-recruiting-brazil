//
//  DetalhesView.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 19/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import UIKit

class DetalhesView: UIViewController {
    
    @IBOutlet var imgView: UIImageView?
    @IBOutlet var favoriteBT:UIButton?
    @IBOutlet var progress:UIActivityIndicatorView?
    
    @IBOutlet var titleLb: UILabel?
    @IBOutlet var anoLb: UILabel?
    @IBOutlet var generosLb: UILabel?
    @IBOutlet var sinopseTv: UITextView?
    
    var movie:Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.progress?.startAnimating()
        self.navigationController?.navigationBar.tintColor = UIColor.yellow
        
        if let m = movie {
            let url = Endpoints.shared.imageBaseUrl + "w780" + m.backdropPath
            imgView?.load(url: url) {
                self.progress?.isHidden = true
            }
            
            titleLb?.text = m.title
            anoLb?.text = formatarData(valor: m.releaseDate, formatoAtual: "yyyy-MM-dd", formatoNovo: "yyyy")
            generosLb?.text = listGenres(genreIds: m.genreIds)
            sinopseTv?.text = m.overview
            
            if(Singleton.shared.isFavorite(id: m.id)) {
                favoriteBT?.isSelected = true
                favoriteBT?.setImage(UIImage(named: "favorite_full_icon.png"), for: .normal)
            } else {
                favoriteBT?.isSelected = false
                favoriteBT?.setImage(UIImage(named: "favorite_gray_icon.png"), for: .normal)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let m = movie {
            if(Singleton.shared.isFavorite(id: m.id)) {
                favoriteBT?.isSelected = true
                favoriteBT?.setImage(UIImage(named: "favorite_full_icon.png"), for: .normal)
            } else {
                favoriteBT?.isSelected = false
                favoriteBT?.setImage(UIImage(named: "favorite_gray_icon.png"), for: .normal)
            }
        }
    }
    
    func listGenres(genreIds: Array<Int>) -> String{
        var texto = ""
        for id in genreIds {
            texto += (Singleton.shared.genres[id]?.name)! + ", "
        }
        return String(texto.dropLast(2))
    }
    
    @IBAction func favoritar() {
        if Singleton.shared.isFavorite(id: (movie?.id)!) {
            favoriteBT?.isSelected = false
            favoriteBT?.setImage(UIImage(named: "favorite_gray_icon.png"), for: .normal)
            Singleton.shared.rmvFavoritos(id: (movie?.id)!)
        } else {
            favoriteBT?.isSelected = true
            favoriteBT?.setImage(UIImage(named: "favorite_full_icon.png"), for: .normal)
            Singleton.shared.addFavoritos(movie: movie!)
        }
    }

}
