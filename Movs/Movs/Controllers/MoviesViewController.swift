//
//  MoviesViewController.swift
//  Movs
//
//  Created by Gustavo Caiafa on 14/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import UIKit
import ObjectMapper
import Connectivity

class MoviesViewController: UIViewController {

    // Views de erro / avisos
    @IBOutlet weak var helperView: UIView!
    @IBOutlet weak var errorView: ErrorView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cancelSearchBarView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var qtdeTotalPages = 1
    var page = 1
    var qtdeMovies = 0
    var moviesResult = MoviesResultModel()
    var movies = [MoviesModel]()
    var moviesFiltrados = [MoviesModel]()
    var isLoadingMovies = false
    fileprivate let connectivity: Connectivity = Connectivity()

    // MARK: - Começo da controller
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "MoviesCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.cancelSearchBarView.addGestureRecognizer(tap)
        verificaConexao(shouldAdd: false)
    }
    
    /* Caso o usuario adicione ou remova algum favorito, teremos que recarregar essa pagina
       para que os filmes favoritados sejam mostrados corretamente aqui
    */
    override func viewWillAppear(_ animated: Bool) {
        if(Utils.Global.hasFavoritesChangedInMovies){
            configuraFavoritos()
            Utils.Global.hasFavoritesChangedInMovies = false
        }
        if(Utils.Global.hasFavoritesBeenDeleted){
            configuraFavoritosDeletados()
            Utils.Global.hasFavoritesBeenDeleted = false
        }
    }
    
    // MARK: - Esconde o teclado e a View invisivel que serve para cancelar a busca na searchbar
    @objc func dismissKeyboard(){
        self.cancelSearchBarView.isHidden = true
        self.view!.endEditing(true)
    }
    
    // MARK: - Responsaveis pela verificao de internet e chamada na API
    func verificaConexao(shouldAdd: Bool){
        self.loadingIndicator.startAnimating()
        connectivity.checkConnectivity { resultado in
            print("Resultado conexao: \(resultado.status)")
            self.getMovies(status: resultado.status, shouldAdd: shouldAdd)
        }
    }
    
    // Faz a chamada na API e chama a funcao responsavel por aplicar as alteracoes de filmes favoritos
    func getMovies(status: Connectivity.Status, shouldAdd: Bool){
        isLoadingMovies = true
        let parametros = ["api_key" : "1724b8b1c0fd57af003ab0dace8bb4db",
                          "language" : "pt-BR",
                          "page" : page] as [String : AnyObject]
        Service.callMethodJson(self, metodo: .get, parametros: parametros, url: Service.LinksAPI.GetPopularMovies, nomeCache: "Movies\(page)", status: status) { (response, error) in
            self.isLoadingMovies = false
            self.loadingIndicator.stopAnimating()
            if(error == nil && response != nil){
                self.mostraViewErro(esconder: true)
                if let moviesMap = Mapper<MoviesResultModel>().map(JSONObject: response){
                    self.moviesResult = moviesMap
                    if(shouldAdd){
                        if(moviesMap.Movies != nil){
                            self.movies = self.movies + moviesMap.Movies!
                            self.moviesFiltrados = self.movies
                            self.qtdeTotalPages = moviesMap.QtdePaginas ?? 0
                        }
                        else{
                            showAlertaController(self, texto: "Algo errado aconteceu. Por favor tente novamente", titulo: "Atenção", dismiss: false)
                        }
                    }
                    else{
                        self.movies = moviesMap.Movies ?? [MoviesModel()]
                        self.moviesFiltrados = self.movies
                    }
                    self.qtdeMovies = self.movies.count
                    self.configuraFavoritos()
                }
                else{
                    self.mostraViewErro(esconder: false)
                    print("Nao mapeou os filmes")
                }
            }
            else{
                self.mostraViewErro(esconder: false)
                self.errorView.btnRecarregar.addTarget(self, action: #selector(self.btnRefresh), for: .touchUpInside)
                print("Erro getMovies : \(String(describing: error?.description))")
            }
        }
    }
    
    
    /*
     Busca os filmes que foram deletados dos favoritos. Caso tenha filmes, corremos o array de filmes da API
     e verificamos se o ID do filme deletado existe nos filmes da api.
     Se existir, alteramos aquele filme para favorito = false para que a imagem seja alterada
     */
    func configuraFavoritosDeletados(){
        self.loadingIndicator.startAnimating()
        if(Utils.Global.deletedFavoritesId != nil){
            for favoritoDeletado in Utils.Global.deletedFavoritesId ?? [0]{
                if let resultadoBusca = moviesFiltrados.firstIndex(where: { $0.Id ?? 0 == favoritoDeletado }){
                    moviesFiltrados[resultadoBusca].isFavorito = false
                }
            }
            Utils.Global.deletedFavoritesId?.removeAll()
            collectionView.reloadData()
        }
        else{
            showAlertaController(self, texto: "Ocorreu um erro ao tentarmos atualizar seus filmes. Por favor tente novamente", titulo: "Atenção", dismiss: false)
        }
        self.loadingIndicator.stopAnimating()
    }
    
    
    /*
     Busca os filmes que foram favoritados.Caso tenha filmes no banco local, corremos o array de filmes da API
     e verificamos se o ID do filme favorito existe nos filmes da api.
     Se sim, significa que foi favoritado, entao alteramos o valor do isFavorito para true para
     que a imagem possa ser alterada para um coracao preenchido
     */
    func configuraFavoritos(){
        self.loadingIndicator.startAnimating()
        if let moviesFavoritos = Database.instance.getMovies(){
            Utils.Global.favoritesModel = moviesFavoritos
            for favoritoLocal in Utils.Global.favoritesModel!{
                if let resultadoBusca = moviesFiltrados.firstIndex(where: { $0.Id ?? 0 == favoritoLocal.MovieIdApi }){
                    moviesFiltrados[resultadoBusca].isFavorito = true
                }
            }
            self.qtdeMovies = moviesFiltrados.count
            collectionView.reloadData()
        }
        else{
            collectionView.reloadData()
        }
        self.loadingIndicator.stopAnimating()
    }
    
    // MARK: - Responsaveis por mostrar erros / buscas vazias
    func mostraViewErro(esconder : Bool){
        self.errorView.isHidden = esconder
        self.helperView.isHidden = esconder
    }
    
    /* Botao que só aparece caso de erro na chamada
     Esse botao dá refresh em tudo, chamando a API e configurando de acordo com os favoritos
     */
    @objc func btnRefresh(){
       verificaConexao(shouldAdd: false)
    }
    
}

extension MoviesViewController : UISearchBarDelegate{
    
    // MARK: - Responsaveis pelo filtro da searchBar
    // Quando o texto muda, vai filtrando pelo nome dos filmes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        moviesFiltrados = searchText.isEmpty ? movies : movies.filter { (filtrados) -> Bool in
            return filtrados.Titulo?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        qtdeMovies = moviesFiltrados.count
        collectionView.reloadData()
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in }
    }
    
    // Quando comeca a digitar, mostra ao botao de cancelar
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    // Quando vai comecar a editar, mostra uma view invisivel na tela toda que serve para dar dismiss no teclado da searchBar quando clicada
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.cancelSearchBarView.isHidden = false
        return true
    }
    
    // Quando clica no pesquisar esconde a view invisivel e o teclado
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.cancelSearchBarView.isHidden = true
        self.searchBar.resignFirstResponder()
    }
    
    // Quando clica no cancelar esconde a view invisivel e o teclado, apaga o texto e volta os filmes ao completo
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
        self.cancelSearchBarView.isHidden = true
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        moviesFiltrados = movies
        qtdeMovies = moviesFiltrados.count
        collectionView.reloadData()
    }
    
}

// MARK: - Responsaveis pela CollectionView
extension MoviesViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return qtdeMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
        cell.configuraCell(movie: moviesFiltrados[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = (self.storyboard?.instantiateViewController(withIdentifier: "DetalheMovieViewController")) as! DetalheMovieViewController
        viewController.movie = moviesFiltrados[indexPath.row]
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (configuraTamanhoCells())
    }
    
    /* Quando chega na penultima cell, verifica se esta na penultima cell, se nao é a ultima pagina
    E também se nao está filtrando na searchBar(comparando o texto da searchBar)
    */
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(qtdeMovies > 0){
            if(!isLoadingMovies && indexPath.row == qtdeMovies - 1 && page <= qtdeTotalPages && searchBar.text == "") {
                page += 1
                self.verificaConexao(shouldAdd: true)
            }
        }
    }
    
    func configuraTamanhoCells() -> CGSize{
        let tamanhoHeight = UIScreen.main.bounds.height
        if(tamanhoHeight > 1000){ // ipads e afins
            let tamanhoWidth = (UIScreen.main.bounds.size.width / 3) - 10 // width tela menos espaco
            return CGSize(width: tamanhoWidth, height: tamanhoWidth * 1.5 + 50)
        }
        else{
            let tamanhoWidth = (UIScreen.main.bounds.size.width / 2) - 5 // width tela menos espaco
            // Height: *1.5 da proporcao das imagens, +50 do tamanho da box
            return CGSize(width: tamanhoWidth, height: (tamanhoWidth * 1.5) + 50)
        }
        
        /*caso as imagens estivessem quadradas, poderia usar o tamanho da tela menos a safe area e a topView
         var tamanhoSafeAreaHeight = self.view.safeAreaLayoutGuide.layoutFrame.height // safe area
         let tamanhoTopViewHeight = self.topView.frame.height // height topView
         
         tamanhoSafeAreaHeight = tamanhoSafeAreaHeight - tamanhoTopViewHeight */
    }
    
}
