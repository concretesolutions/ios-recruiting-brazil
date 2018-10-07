//
//  RM_MovieViewController.swift
//  RMovie
//
//  Created by Renato Mori on 05/10/2018.
//  Copyright © 2018 Renato Mori. All rights reserved.
//

import UIKit

class RM_MovieViewController: UIViewController
,UITextFieldDelegate
{
    var movie : RM_Movie?;
    var genres : RM_HTTP_Genres?;
    
    @IBOutlet weak var navgation: UINavigationItem!
    @IBOutlet weak var imgPoster: UIImageView!
    
    @IBOutlet weak var lblVoteAverage: UILabel!
    @IBOutlet weak var lblLancamento: UILabel!
    @IBOutlet weak var lblGeneros: UITextField!
    @IBOutlet weak var lblDescricao: UITextView!
    
    @IBOutlet weak var btnFavorito: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        
        self.movie = appDelegate.selectedMovie;
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
        self.lblGeneros.text = self.listarGeneros()
        self.lblGeneros.delegate = self;
//Descrição
        self.lblDescricao.text = self.movie?.overview;

        self.updateBtnFavorito();
    }
    private func updateBtnFavorito(){
        if(Favorite.store.hasId(id: (self.movie?.id)!)){
            self.btnFavorito.image = UIImage(named: "favorite_full_icon")
        }else{
            self.btnFavorito.image = UIImage(named: "favorite_empty_icon");
        }
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

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false;
    }
    
    @IBAction func btnFavorito_onClick(_ sender: Any) {
        if(Favorite.store.hasId(id: (self.movie?.id!)!)){
            Favorite.store.removeItem(item:self.movie!);
        }else{
            Favorite.store.addItem(item: self.movie!);
        }
        updateBtnFavorito();
    }
    
}
