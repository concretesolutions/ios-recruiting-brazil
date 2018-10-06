//
//  RM_MovieViewController.swift
//  RMovie
//
//  Created by Renato Mori on 05/10/2018.
//  Copyright © 2018 Renato Mori. All rights reserved.
//

import UIKit

class RM_MovieViewController: UIViewController {
    var movie : RM_Movie?;
    var genres : RM_HTTP_Genres?;
    
    @IBOutlet weak var navgation: UINavigationItem!
    @IBOutlet weak var imgPoster: UIImageView!
    
    @IBOutlet weak var lblVoteAverage: UILabel!
    @IBOutlet weak var lblLancamento: UILabel!
    @IBOutlet weak var lblgeneros: UILabel!
    @IBOutlet weak var lblDescricao: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        
        self.movie = (appDelegate.movies?.getMovie(index: appDelegate.selectedIndex!))!;
        self.genres = appDelegate.genres;
        
//Titulo
        self.navgation.title = self.movie?.title
//Poster
        self.imgPoster.imageFromServerURL("https://image.tmdb.org/t/p/original\(String((movie?.poster_path)!))" , placeHolder: nil)
        
//Data de Lançamento
        let ano = String((self.movie?.release_date?.prefix(4))!)
        let mes = String((self.movie?.release_date?.prefix(7))!.suffix(2));
        let dia = String((self.movie?.release_date?.suffix(2))!);
        self.lblLancamento.text = "\(dia)/\(mes)/\(ano)";

//Popularidade
        self.lblVoteAverage.text = String(format:"%.1f", (self.movie?.vote_average)!);
        
//Generos
        self.lblgeneros.text = self.listarGeneros()
        
//Descrição
        self.lblDescricao.text = self.movie?.overview;
        self.lblDescricao.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func listarGeneros() -> String{
        var generos : String = "";
        for id in (self.movie?.genre_ids)! {
            let genero :String = (self.genres?.genres[id!])!;
            generos = "\(generos), \(genero)";
        }
        
        return String(generos.suffix(generos.count-2));
    }

}
