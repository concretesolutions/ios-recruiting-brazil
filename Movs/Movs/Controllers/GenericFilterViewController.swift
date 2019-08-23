//
//  GenericFilterViewController.swift
//  Movs
//
//  Created by Gustavo Caiafa on 22/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import UIKit
import Connectivity
import ObjectMapper

class GenericFilterViewController: UIViewController {

    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var dates = [Int]()
    var qtdeItens = 0
    var delegateDateFilterProtocol : didSelectDateFilterProtocol?
    var delegateGenreFilterProtocol : didSelectGenresFilterProtocol?
    var isDates = false
    fileprivate let connectivity: Connectivity = Connectivity()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(isDates){
            self.lblTitulo.text = "Dates"
            getTodayDateAppendTable()
        }
        else{
            self.lblTitulo.text = "Genres"
            if(Utils.Global.genresModel != nil && Utils.Global.genresModel?.Genres != nil){
                configuraGeneros()
            }
            else{
                verificaConexao()
            }
        }
    }

    @IBAction func BtVoltar(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // Gera a lista de anos a ser exibido para selecionar no filtro por data
    func getTodayDateAppendTable(){
        var year = 2019
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let formattedDateString = formatter.string(from: date)
        year = Int(formattedDateString) ?? 2019
        for i in (1900..<year + 1).reversed() {
            dates.append(i)
        }
        qtdeItens = dates.count
        tableView.reloadData()
    }
    
    func configuraGeneros(){
        qtdeItens = Utils.Global.genresModel?.Genres?.count ?? 0
        tableView.reloadData()
    }
    
    func verificaConexao(){
        connectivity.checkConnectivity { resultado in
            print("Resultado conexao: \(resultado.status)")
            self.getGenres(status: resultado.status)
        }
    }
    
    // Caso o Utils.Global.genresModel seja nulo ou vazio, fazemos a chamada na API para buscar os generos
    func getGenres(status : Connectivity.Status){
        //self.loadingView.isHidden = false
        let parametros = ["api_key" : "1724b8b1c0fd57af003ab0dace8bb4db",
                          "language" : "pt-BR"] as [String : AnyObject]
        Service.callMethodJson(metodo: .get, parametros: parametros, url: Service.LinksAPI.GetGenres, nomeCache: "Genres", status: status) { (response, error) in
            //self.loadingView.isHidden = true
            if(error == nil && response != nil){
                if let genresMap = Mapper<GenreResultModel>().map(JSONObject: response){
                    Utils.Global.genresModel = genresMap
                    self.configuraGeneros()
                }
                else{
                    showAlertaController(self, texto: "Algo errado aconteceu. Por favor tente novamente", titulo: "Atenção", dismiss: true)
                    print("Nao mapeou os generos")
                }
            }
            else{
                print("Erro getGenres : \(String(describing: error?.description))")
                showAlertaController(self, texto: "Algo errado aconteceu. Por favor tente novamente", titulo: "Atenção", dismiss: true)
            }
        }
    }
    
}

extension GenericFilterViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qtdeItens
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        if(isDates){
            cell.textLabel?.text = String(self.dates[indexPath.row])
        }
        else{
            cell.textLabel?.text = Utils.Global.genresModel?.Genres?[indexPath.row].Name
        }
        return cell
    }
    
    // Se o usuario tiver selecionado Data na tela de filtro, isDates = true
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(isDates){
            self.delegateDateFilterProtocol?.selectedDate(didSelect: true, date: dates[indexPath.row])
        }
        else{
            self.delegateGenreFilterProtocol?.selectedGenre(didSelect: true, genre: Utils.Global.genresModel?.Genres?[indexPath.row].Name)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
