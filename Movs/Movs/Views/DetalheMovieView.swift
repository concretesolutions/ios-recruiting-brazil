//
//  DetalheMovieView.swift
//  Movs
//
//  Created by Gustavo Caiafa on 16/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import UIKit
import SDWebImage
import Connectivity
import ObjectMapper

class DetalheMovieView: UIView {
    
    @IBOutlet var masterView: UIView!
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var imgFavorito: UIImageView!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var lblGenero: UILabel!
    @IBOutlet weak var lblDescricao: UILabel!
    var linkFotoImg : URL?
    var controller : UIViewController?
    var movieModel = MoviesModel()
    fileprivate let connectivity: Connectivity = Connectivity()
        
    required init?(coder aDecoder: NSCoder) { // para xib ou storyboard
        super.init(coder: aDecoder)
        configuracao()
    }
    
    override init(frame: CGRect) { // para inicializacao por codigo
        super.init(frame: frame)
        configuracao()
    }
    
    private func configuracao(){
        Bundle.main.loadNibNamed("DetalheMovieView", owner: self, options: nil)
        addSubview(masterView)
        masterView.frame = self.bounds
        masterView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    // MARK: - Faz a configuracao geral da Cell
    func configuraCell(movie: MoviesModel, controller : UIViewController){
        self.movieModel = movie
        
        if let titulo = movieModel.Titulo {
            self.lblTitulo.text = titulo
        }
        
        if let data = movieModel.Data{
            self.lblData.text = data
        }
        
        if let descricao = movieModel.Descricao {
            self.lblDescricao.text = descricao
        }
        
        if let linkFoto = movieModel.linkFoto, movieModel.linkFoto != nil && movieModel.linkFoto != ""{
            if let urlFoto = URL(string: "http://image.tmdb.org/t/p/w342\(linkFoto)"){
                self.imgFoto.sd_imageIndicator = SDWebImageProgressIndicator.default
                self.imgFoto.sd_setImage(with: urlFoto)
                let tapFullScreen = UITapGestureRecognizer(target: self, action: #selector(self.abrirFullScreen))
                tapFullScreen.cancelsTouchesInView = false
                self.imgFoto.addGestureRecognizer(tapFullScreen)
                self.imgFoto.isUserInteractionEnabled = true
                self.linkFotoImg = urlFoto
                self.controller = controller
            }
        }
        
        getGeneros()
        configuraBtFavorito()
    }
    
    // MARK: - Responsaveis pelas configuracoes dos generos
    
    /* Se por algum acaso a variavel global de generos estiver nula
       Entao por segurança faremos a chamada novamente na API para buscar os generos
     */
    func getGeneros(){
        if(Utils.Global.genresModel != nil && Utils.Global.genresModel?.Genres != nil){
            configuraGeneros()
        }
        else{
            verificaConexao()
        }
    }
    
    /*
     Verifica se o id do genero desse filme existe, se existir vamos filtrando o ID do genero e pegando
     o seu nome equivalente e adicionando no array de string de generos
     */
    func configuraGeneros(){
        if(movieModel.idGenero != nil){
            var generosString = [String]()
            for idGeneroLocal in movieModel.idGenero!{
                let resultado = Utils.Global.genresModel!.Genres!.filter { $0.GenreId == idGeneroLocal }
                let nomeGenero = resultado.first?.Name ?? "N/D"
                generosString.append(nomeGenero)
            }
            
            for generoLocal in generosString{
                lblGenero.text = lblGenero.text! +  generoLocal + ", "
            }
            if(lblGenero.text != ""){
                lblGenero.text?.removeLast(2)
            }
        }
        else{
            self.lblGenero.text = "N/D"
        }
    }
    
    // Caso o Utils.Global.genresModel seja nulo ou vazio, fazemos a chamada na API para buscar os generos
    func getGenres(status : Connectivity.Status, isFirstTime: Bool){
        //self.loadingView.isHidden = false
        let parametros = ["api_key" : "1724b8b1c0fd57af003ab0dace8bb4db",
                          "language" : "pt-BR"] as [String : AnyObject]
        Service.callMethodJson(controller!, metodo: .get, parametros: parametros, url: Service.LinksAPI.GetGenres, nomeCache: "Genres", status: status) { (response, error) in
            //self.loadingView.isHidden = true
            if(error == nil && response != nil){
                print(response!)
                if let genresMap = Mapper<GenreResultModel>().map(JSONObject: response){
                    Utils.Global.genresModel = genresMap
                    self.configuraGeneros()
                }
                else{
                    if(isFirstTime){
                        self.getGenres(status: status, isFirstTime: false)
                    }
                    else{
                        self.lblGenero.text = "N/D"
                    }
                    print("Nao mapeou os generos")
                }
            }
            else{
                if(isFirstTime){
                    self.getGenres(status: status, isFirstTime: false)
                }
                else{
                    self.lblGenero.text = "N/D"
                }
                print("Erro getGenres : \(String(describing: error?.description))")
            }
        }
    }
    
    // MARK: - Responsaveis pelas configuracoes dos favoritos

    // Configura o botao, alterando imagem e adicionando tap
    func configuraBtFavorito(){
        if(movieModel.isFavorito){
            self.imgFavorito.isUserInteractionEnabled = false
            self.imgFavorito.image = UIImage(named: "favorite_full_icon")
        }
        else{
            self.imgFavorito.isUserInteractionEnabled = true
            let tapAddFavorito = UITapGestureRecognizer(target: self, action: #selector(self.addFavorito))
            tapAddFavorito.cancelsTouchesInView = false
            self.imgFavorito.addGestureRecognizer(tapAddFavorito)
            self.imgFavorito.image = UIImage(named: "favorite_gray_icon")
        }
    }
    
    /* Adiciona o filme nos favoritos, salvando os generos como uma string concatenada
     E avisando atraves das variaveis globais que há adicao de um filme nos filmes favoritos
     */
    @objc func addFavorito(){
        var dataDate : Int? = nil
        if let dataToDate = self.movieModel.Data?.toDateYear(){
            dataDate = dataToDate
        }
        if(Database.instance.addMovie(movieidapi: self.movieModel.Id ?? 0,
                                      titulo: self.movieModel.Titulo ?? "N/D",
                                      descricao: self.movieModel.Descricao ?? "N/D",
                                      data: dataDate,
                                      linkfoto: self.movieModel.linkFoto ?? "N/D",
                                      generos: lblGenero.text ?? "N/D")){
            showAlertaController(self.controller!, texto: "Filme adicionado com sucesso aos favoritos!", titulo: "Atenção", dismiss: false)
            self.movieModel.isFavorito = true
            Utils.Global.hasFavoritesChangedInFavorites = true
            Utils.Global.hasFavoritesChangedInMovies = true
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                self.imgFavorito.image = UIImage(named: "favorite_full_icon")
                self.layoutIfNeeded()
            }) { (animationComplete) in }
            configuraBtFavorito()
        }
        else{
            showAlertaController(self.controller!, texto: "Algo errado aconteceu, por favor tente novamente!", titulo: "Atenção", dismiss: false)
            self.movieModel.isFavorito = false
            configuraBtFavorito()
        }
    }
    
    
    // Abre a imagem selecionada em fullscreen
    @objc private func abrirFullScreen(){
        let viewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FullScreenViewController")) as! FullScreenViewController
        viewController.linkFoto = linkFotoImg
        viewController.modalPresentationStyle = .overCurrentContext
        self.controller!.present(viewController, animated: true, completion: nil)
    }
    
    // Verifica internet e faz a chamada na API
    func verificaConexao(){
        connectivity.checkConnectivity { resultado in
            print("Resultado conexao: \(resultado.status)")
            self.getGenres(status: resultado.status, isFirstTime: true)
        }
    }
    
}
