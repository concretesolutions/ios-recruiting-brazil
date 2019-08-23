//
//  FavoritesViewController.swift
//  Movs
//
//  Created by Gustavo Caiafa on 21/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, didFilterProtocol {
    
    /* Se a data for nula, filtramos por genero, pois pelo menos um filtro é obrigatorio
     para chamar esse protocolo.
     Se a data nao for nula, verificamos se o genero também nao é, para filtrar por ambos
     No caso do filtro por ambos, apos aplicarmos o primeiro, verificamos se o vetor nao é vazio, se for, nao precisa filtrar
     Se genero for, filtramos apenas pela data
     Também alteramos a constraint do Filter para que ele apareça
     */
    func selectedFilters(date: Int?, genre: String?) {
        self.filteredByHeightConstraint.constant = 40
        if(date != nil){
            self.lblFilteredDate.isHidden = false
            self.lblFilteredDate.text = String(date!)
            filterByData(date: date!)
            if(QtdeFavorites > 0){
                if(genre != nil){
                    self.lblFilteredGenre.isHidden = false
                    self.lblFilteredGenre.text = genre!
                    filterByGenre(hasFilteredByDate: true, genre: genre!)
                }
                else{
                    self.lblFilteredGenre.isHidden = true
                }
            }
        }
        else{
            self.lblFilteredDate.isHidden = true
            filterByGenre(hasFilteredByDate: false, genre: genre!)
        }
    }
    
    @IBOutlet weak var buscaVaziaView: BuscaVaziaView!
    @IBOutlet weak var avisosView: UIView!
    @IBOutlet weak var cancelSearchBarView: UIView!
    @IBOutlet weak var loadingView: LoadingView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblFilteredDate: UILabel!
    @IBOutlet weak var lblFilteredGenre: UILabel!
    @IBOutlet weak var filteredByHeightConstraint: NSLayoutConstraint!
    
    /*
     Aqui usamos 4 vetores.
     O vetor original que contem TODOS os favoritos
     O vetor de filtrados, que é usado para a searchBar
     O vetor AfterFilter, que é usado para apos aplicacao dos filtros de genero e data
     O vetor ToShow, que é usado para receber as alteracoes aplicadas sobre os outros vetores e mostrar para o usuario
     */
    var favoritesFiltrados = [MoviesModelLocal]()
    var favoritesAfterFilter = [MoviesModelLocal]()
    var favoritesToShow = [MoviesModelLocal]()
    var QtdeFavorites = 0
    var filterDate = ""
    var filterGenre = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.cancelSearchBarView.addGestureRecognizer(tap)
        tableView.register(UINib(nibName: "FavoritesTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoritesTableViewCell")
        self.favoritesFiltrados = Utils.Global.favoritesModel ?? [MoviesModelLocal]()
        self.favoritesAfterFilter = self.favoritesFiltrados
        self.favoritesToShow = self.favoritesFiltrados
        self.QtdeFavorites = self.favoritesFiltrados.count
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(Utils.Global.hasFavoritesChangedInFavorites){
            getFavoritos()
            Utils.Global.hasFavoritesChangedInFavorites = false
        }
    }
    
    // MARK: - Esconde o teclado e a View invisivel que serve para cancelar a busca na searchbar
    @objc func dismissKeyboard(){
        self.cancelSearchBarView.isHidden = true
        self.view!.endEditing(true)
    }
    
    /* Já temos o array atualizado de favoritos da tela anterior. Entao apenas atualizamos nosso array local
     e damos reload na table
     */
    func getFavoritos(){
        self.loadingView.isHidden = false
        self.favoritesFiltrados = Utils.Global.favoritesModel ?? [MoviesModelLocal]()
        self.favoritesAfterFilter = self.favoritesFiltrados
        self.favoritesToShow = self.favoritesFiltrados
        self.QtdeFavorites = favoritesFiltrados.count
        self.tableView.reloadData()
        Utils.Global.hasFavoritesChangedInFavorites = false
        self.loadingView.isHidden = true
    }
    
    // Remove todos os filtros, fazendo com que os arrays recebam o array completo
    @IBAction func BtDeleteFilter(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.filteredByHeightConstraint.constant = 0
            self.view.layoutIfNeeded()
        }) { (animationComplete) in }
        self.favoritesFiltrados = Utils.Global.favoritesModel ?? [MoviesModelLocal]()
        self.favoritesToShow = self.favoritesFiltrados
        self.favoritesAfterFilter = self.favoritesFiltrados
        self.QtdeFavorites = favoritesFiltrados.count
        self.filterGenre = ""
        self.filterDate = ""
        self.searchBar.text = ""
        self.avisosView.isHidden = true
        self.tableView.reloadData()
    }
    
    // MARK: - Responsaveis pelo filtro
    
    /* Abre a controller responsavel por selecionar os filtros e passa os metodos delegados
        Para que ao selecionar os filtros, os mesmos sejam aplicados nessa controller
    */
    @IBAction func BtFiltrar(_ sender: UIButton) {
        let viewController = (self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController")) as! FilterViewController
        viewController.modalPresentationStyle = .fullScreen
        viewController.didfilterProtocol = self
        viewController.filterDate = self.filterDate
        viewController.filterGenre = self.filterGenre
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Funcao chamada pelo delegate do filtro da Data. Alteramos o array favoritesAfterFilter(responsavel apenas pelos filtros de genero e data) e também o favoritesToShow, que é sempre mostrado para o usuario.
    func filterByData(date: Int){
        if let favorites = Utils.Global.favoritesModel{
            filterDate = String(date)
            favoritesAfterFilter = favorites.filter({$0.Data == date})
            favoritesToShow = favoritesAfterFilter
            QtdeFavorites = favoritesAfterFilter.count
            verificaBuscaVazia(mensagem: date as AnyObject)
            tableView.reloadData()
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    /* Funcao chamada pelo delegate do filtro de genero.Alteramos o array favoritesAfterFilter(responsavel apenas pelos filtros de genero e data) e também o favoritesToShow, que é sempre mostrado para o usuario.
     Verifica se já filtramos por data, pois se sim, o .filter ocorre no array que já foi filtrado(favoritesAfterFilter) e nao em favorites(array original completo)
     */
    func filterByGenre(hasFilteredByDate : Bool,genre: String){
        filterGenre = genre
        if(hasFilteredByDate){
            favoritesAfterFilter = favoritesAfterFilter.filter({($0.Generos?.contains(genre))!})
            favoritesToShow = favoritesAfterFilter
            QtdeFavorites = favoritesAfterFilter.count
            verificaBuscaVazia(mensagem: genre as AnyObject)
            tableView.reloadData()
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        else{
            if let favorites = Utils.Global.favoritesModel{
                favoritesAfterFilter = favorites.filter({($0.Generos?.contains(genre))!})
                favoritesToShow = favoritesAfterFilter
                QtdeFavorites = favoritesAfterFilter.count
                verificaBuscaVazia(mensagem: genre as AnyObject)
                tableView.reloadData()
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    /* Caso a busca de algum dos filtros(data ou genero) resultar em vazia,
        mostramos a view responsavel pela imagem de Busca Vazia e mais o filtro que resultou nessa busca vazia
    */
    func verificaBuscaVazia(mensagem : AnyObject){
        if(QtdeFavorites == 0){
            self.buscaVaziaView.lblMsgErro.text = "Seu filtro por \(mensagem) não encontrou nenhum resultado!"
            self.avisosView.isHidden = false
        }
        else{
            self.avisosView.isHidden = true
        }
    }
    
}

extension FavoritesViewController : UISearchBarDelegate{
    
    // MARK: - Responsaveis pelo filtro da searchBar
    // Quando o texto muda, vai filtrando o array que ja foi filtrado pelos filtros de Genero ou Data
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        favoritesFiltrados = searchText.isEmpty ? favoritesAfterFilter : favoritesAfterFilter.filter { (filtrados) -> Bool in
            return filtrados.Titulo?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        favoritesToShow = favoritesFiltrados
        QtdeFavorites = favoritesFiltrados.count
        tableView.reloadData()
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
    
    // Quando clica no cancelar esconde a view invisivel e o teclado, apaga o texto e volta os filmes ao padrao
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
        self.cancelSearchBarView.isHidden = true
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        favoritesFiltrados = favoritesAfterFilter
        favoritesToShow = favoritesFiltrados
        QtdeFavorites = favoritesAfterFilter.count
        tableView.reloadData()
    }
    
}

extension FavoritesViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QtdeFavorites
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell
        cell.configuraCell(favoritesModel: favoritesToShow[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tamanhoHeight = UIScreen.main.bounds.height
        if(tamanhoHeight > 1000){
            return tamanhoHeight/4.5
        }
        else{
            return tamanhoHeight/3
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Unfavorite") { (action, indexPath) in
            self.removerFavorito(favoritoTarget: self.favoritesToShow[indexPath.row], indexPath: indexPath)
        }
        
        return [delete]
    }
    
    /* Remove o filme dos favoritos no banco, informa que a tela de Movies tem que atualizar
     Atualiza a variavel global de Favorites, adiciona o ID do filme deletado na Globals
     e deleta de todas as listas o filme que foi removido
     */
    func removerFavorito(favoritoTarget : MoviesModelLocal, indexPath : IndexPath){
        self.loadingView.isHidden = false
        if let movieid = favoritoTarget.MovieLocalId{
            if(Database.instance.deleteMovie(iid: movieid)){
                Utils.Global.deletedFavoritesId?.append(favoritoTarget.MovieIdApi ?? 0)
                Utils.Global.hasFavoritesBeenDeleted = true
                
                if let index = self.favoritesToShow.firstIndex(where: {$0 === favoritoTarget}){
                    self.favoritesToShow.remove(at: index)
                }
                
                if let index = self.favoritesAfterFilter.firstIndex(where: {$0 === favoritoTarget}){
                    self.favoritesAfterFilter.remove(at: index)
                }
                
                if let index = self.favoritesFiltrados.firstIndex(where: {$0 === favoritoTarget}){
                    self.favoritesFiltrados.remove(at: index)
                }
                
                if let index = Utils.Global.favoritesModel!.firstIndex(where: {$0 === favoritoTarget}){
                    Utils.Global.favoritesModel?.remove(at: index)
                }
                
                self.QtdeFavorites -= 1
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.endUpdates()
                showAlertaController(self, texto: "Filme removido com sucesso!", titulo: "", dismiss: false)
            }
            else{
                showAlertaController(self, texto: "Ocorreu um erro ao tentar remover esse filme. Por favor tente novamente", titulo: "Atenção", dismiss: false)
            }
        }
        else{
            showAlertaController(self, texto: "Ocorreu um erro ao tentar remover esse filme. Por favor tente novamente", titulo: "Atenção", dismiss: false)
        }
        self.loadingView.isHidden = true
    }
    
}
