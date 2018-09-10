//
//  FavoritosViewController.swift
//  DesafioConcrete
//
//  Created by Matheus Henrique on 03/09/2018.
//  Copyright © 2018 Concrete.Matheus Henrique. All rights reserved.
//

import UIKit
import Firebase //Persistência de dados e cadastro de usuário
import TMDBSwift //Interface com o TMDB

class CelulaFavoritos: UITableViewCell{
    @IBOutlet weak var imageFavoritos: UIImageView!
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelAno: UILabel!
    @IBOutlet weak var buttonDesfavoritar: UIButton!
}//Fim da classe CelulaFavoritos

//MARK: ENUM Estado Tabela
enum EstadoTabela{
    case carregando
    case concluido([Filme])
    case semFavoritos
    case semResultado
    case retornoBusca([Int])
    case erro
    
    var dadosFilme : [Filme]{
        switch self  {
        case .concluido(let filmes):
            return filmes
        default:
            return []
        }//switch self
    }//var dadosFilme: [Filme]
    
    var indicesBusca : [Int]{
        switch self  {
        case .retornoBusca(let indiceFilme):
            return indiceFilme
        default:
            return []
        }//switch self
    }//var indicesBusca: [Int]
}//enum EstadoTabela

class FavoritosViewController: UIViewController{
    
    //Objetos de interface
    @IBOutlet weak var tabela: UITableView!
    @IBOutlet weak var barraPesquisa: UISearchBar!
    //Views retorno usuário
    @IBOutlet weak var activityIndicatorCarregando: UIActivityIndicatorView!
    @IBOutlet weak var carregandoView: UIView!
    @IBOutlet weak var semFavoritosView: UIView!
    @IBOutlet weak var erroView: UIView!
    @IBOutlet var semResultadoView: UIView!
    @IBOutlet weak var labelRetornoBusca: UILabel!
    //Variáveis
    var referenciaRealtime = Database.database().reference()
    var arrayIDFavoritos:[Int] = []
    var filmesFavoritos:[Filme] = []
    var modoPesquisa = false
    var tipoBusca = 0
    //Constantes
    let idUsuarioAtual = Auth.auth().currentUser?.uid
    
    //MARK: Handle do Enum DadosTabela
    //Inicializa como "carregando"
    var estadoTabela = EstadoTabela.carregando {
        didSet {
            setaRetornoUsuario()
            tabela.reloadData()
        }//didSet
    }// var estadoTabela = DadosTabela.carregando
    
    func setaRetornoUsuario() {
        switch estadoTabela{
        case .carregando:
            tabela.tableFooterView = carregandoView
        case .concluido:
            tabela.tableFooterView = nil
        case .retornoBusca:
            tabela.tableFooterView = nil
        case .semFavoritos:
            tabela.tableFooterView = semFavoritosView
        case .semResultado:
            tabela.tableFooterView = semResultadoView
        case .erro:
            tabela.tableFooterView = erroView
        }//switch estadoTabela
    }//func setFooterView()
    
    //MARK: Ciclo da View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Atualiza dados e tabela sempre que o usuário abrir a tela
        buscaFavoritos()
    }//func viewWillAppear
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Inicialização de variáveis e delegates
        barraPesquisa.delegate = self
        barraPesquisa.showsScopeBar = true
        barraPesquisa.scopeButtonTitles = ["Nome", "Ano Lançamento", "Gênero"]        
    }//func viewDidLoad()
    
    //MARK: Busca de dados
    func buscaFavoritos(){
        estadoTabela = .carregando
        
        arrayIDFavoritos.removeAll()//Remove resultados anteriores
        
        //Busca no Firebase
        referenciaRealtime.child("\(idUsuarioAtual ?? "nulo")/favoritos").observeSingleEvent(of: .value, with: { (snapshot) in
            
            for filme in snapshot.children.allObjects as! [DataSnapshot] {
                //Verifica se há favoritos
                if let idFilme = filme.value as? Int{
                    self.arrayIDFavoritos.append(idFilme)
                }//if let idFilme = filme.value
            }// for filme in snapshot.children.allObjects as! [DataSnapshot]
            
            //Verifica se há favoritos na conta
            if self.arrayIDFavoritos.isEmpty{
                self.estadoTabela = .semFavoritos
            }else{
                self.buscaFilmes()
            }//else arrayIDFavoritos.isEmpty
            
        }){ (error) in
            self.estadoTabela = .erro
            print(error.localizedDescription)//Retorno para o console
        }//error
    }//func buscaFavoritos
    
    func buscaFilmes(){
        
        filmesFavoritos.removeAll()
        
        for i in 0..<arrayIDFavoritos.count{
            MovieMDB.movie(movieID: arrayIDFavoritos[i], language: "pt-BR", completion: { retornoAPI, filmeEncontrado in
                //Se existe o determinado filme na base do TMDB
                if let filmeEncontrado = filmeEncontrado{
                    
                    let ano = String((filmeEncontrado.release_date?.prefix(4))!)
                    var stringGeneros = ""//Passado para o objeto
                    
                    //Busca a quantidade e valores correspondentes aos gêneros
                    let generosInteiro = filmeEncontrado.genres.count
                    for a in 0..<generosInteiro{
                        let nomeGenero = filmeEncontrado.genres[a].name!
                        stringGeneros+=nomeGenero
                    }//for
                    
                    let filme = Filme(id: filmeEncontrado.id, nome: filmeEncontrado.title, ano: ano, generosString: stringGeneros, caminhoImagem: filmeEncontrado.poster_path)
                    
                    self.filmesFavoritos.append(filme)
                    
                    //Atualiza a tabela a medida que os filmes são carregados
                    self.estadoTabela = .concluido(self.filmesFavoritos)
                }//if let filme = filme
            })// MovieMDB.movie
        }//for i in 0..<arrayIDFavoritos
        
    }//func buscaFilmes
    
    //MARK: Manipulação favoritos
    
    @IBAction func desfavoritar(_ sender: UIButton) {
        //Variáveis locais
        let indiceFilme = sender.tag
        
        //Remove referência do Firebase
        let referenciaDelecao = Database.database().reference().child("\(idUsuarioAtual ?? "nulo")/favoritos/").child("\(estadoTabela.dadosFilme[indiceFilme].id ?? 0)")
        referenciaDelecao.removeValue()
        
        //Atualiza a tabela com a alteração
        buscaFavoritos()        
    }//func desfavoritar
    
    //MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let linhaTabela = tabela.indexPathForSelectedRow?.row
        let viewDetalhes = segue.destination as? DetalhesViewController
        
        if segue.identifier == "segueDetalhesFilme"{
            if modoPesquisa{
                viewDetalhes?.filme = filmesFavoritos[estadoTabela.indicesBusca[linhaTabela!]]
            }else{
                viewDetalhes?.filme = filmesFavoritos[linhaTabela!]
            }//else !modoPesquisa
            viewDetalhes?.favorito = true
        }// if segue.identifier == "segueDetalhesFilme"
    }//prepare(for segue:)
    
}//Fim da classe

extension FavoritosViewController: UITableViewDataSource, UITableViewDelegate{
    //MARK: Table View Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        
        if modoPesquisa{
            return estadoTabela.indicesBusca.count
        }else{
            return estadoTabela.dadosFilme.count
        }//else !modoPesquisa
    }//numberOfRowsInSection
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Constantes locais
        let celula = tableView.dequeueReusableCell(withIdentifier: "CelulaFavoritos") as! CelulaFavoritos
        var indiceExibicao = indexPath.row
        let objFilme: Filme
        
        if modoPesquisa{
            //Se for modo de pesquisa, altera o índice guia de exibição
            indiceExibicao = estadoTabela.indicesBusca[indexPath.row]
        }//if modoPesquisa
        
        objFilme = filmesFavoritos[indiceExibicao]
        
        //Seta URL com tamanho definido por w154, de acordo com API TMDB
        let urlImagem = URL(string: "http://image.tmdb.org/t/p/w154\(objFilme.caminhoImagem!)")
        
        celula.imageFavoritos.sd_setImage(with: urlImagem, placeholderImage: #imageLiteral(resourceName: "carregandoPoster"), options: .highPriority, completed: nil)
        celula.labelNome.text = objFilme.nome
        celula.labelAno.text = objFilme.ano
        
        //Atribui referência para o botão de favorito
        celula.buttonDesfavoritar.tag = indexPath.row
        celula.buttonDesfavoritar.addTarget(self, action: #selector(desfavoritar(_:)), for: .touchUpInside)
        
        return celula
    }//cellForRowAt
}//extension UITableViewDataSource, delegate

extension FavoritosViewController: UISearchBarDelegate{
    //MARK: Delegate barra de pesquisa
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let textoPesquisa = self.barraPesquisa.text
        estadoTabela = .retornoBusca([])//Esvazia buscas anteriores
        
        
        //Verifica se o usuário inseriu texto na barra
        if textoPesquisa == nil || textoPesquisa == "" {
            self.modoPesquisa = false
            self.view.endEditing(true)//Avisa o delegate para esconder o teclado
            estadoTabela = .concluido(filmesFavoritos)//Atualiza a interface para o modo normal
        }//if barraPesquisa.text == nil || self.barraPesquisa.text == ""
        else{
            self.modoPesquisa = true
            
            var indicesBusca:[Int] = []
            
            //Armazena no vetor os índices de onde foram encontrados os nomes, anos ou gêneros
            switch tipoBusca{
            case 0:
                indicesBusca = self.filmesFavoritos.indices.filter{self.filmesFavoritos[$0].nome!.localizedCaseInsensitiveContains(textoPesquisa!)}
            case 1:
                indicesBusca = self.filmesFavoritos.indices.filter{self.filmesFavoritos[$0].ano!.localizedCaseInsensitiveContains(textoPesquisa!)}
            case 2:
                indicesBusca = self.filmesFavoritos.indices.filter{self.filmesFavoritos[$0].generosString!.localizedCaseInsensitiveContains(textoPesquisa!)}
            default: break
            }// switch tipoBusca
            
            if indicesBusca.isEmpty{ //Não obteve resultados
                self.estadoTabela = .semResultado
                labelRetornoBusca.text = "Sua busca por \"\(textoPesquisa ?? "")\" não obteve resultados"
            }//if self.arrayIndicesBusca.isEmpty
            else{
                self.estadoTabela = .retornoBusca(indicesBusca)
            }//else
        }//else
    }//func searchBar(_ searchBar: UISearchBar)
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            barraPesquisa.placeholder = "Pesquisar por nome"
            tipoBusca = 0
        case 1:
            barraPesquisa.placeholder = "Pesquisar por ano de lançamento"
            tipoBusca = 1
        case 2:
            barraPesquisa.placeholder = "Pesquisar por gênero"
            tipoBusca = 2
        default: break
        }//switch selectedScope
    }//selectedScopeButtonIndexDidChange
}//extension UISearchBarDelegate
