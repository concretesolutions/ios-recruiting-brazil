//
//  FavoritosView.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 19/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import UIKit

class FavoritosView: UIViewController {
    
    @IBOutlet var tableView:UITableView?
    @IBOutlet var progress:UIActivityIndicatorView?
    
    var preferidos = Dictionary(uniqueKeysWithValues:  Singleton.shared.preferidos.map{ ($0.key, $0) })

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Favoritos"
        navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.yellow]
        
        self.progress?.startAnimating()
        
        self.tableView?.register(UINib.init(nibName: "FavoritosCell", bundle: nil), forCellReuseIdentifier: "FavoritosCell")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(preferidos.count != Singleton.shared.preferidos.count) {
            preferidos = Dictionary(uniqueKeysWithValues:  Singleton.shared.preferidos.map{ ($0.key, $0) })
        }
    }
    
}

extension FavoritosView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preferidos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView?.dequeueReusableCell(withIdentifier: "FavoritosCell")! // as! EventoCell     // Cast da célula para EventoCell
//        let linha = indexPath.row
//        let evento = EventosSingleton.shared.eventos![linha]
//
//        cell.tituloLb?.text = evento.denominacao
//        let formato = DateFormatter()
//        formato.dateFormat = "yyyy-MM-dd"
//
//        let novoFormato = DateFormatter()
//        novoFormato.dateFormat = "dd/MM"
//
//        if(evento.datainicio != "2018-10-21") {
//            let dataString:String = novoFormato.string(from: formato.date(from: evento.datainicio)!)
//            cell.dataLb?.text = dataString
//        } else  { cell.dataLb?.text = "21/10" }
//
//        let horaInicio = formatarData(valor: evento.horainicio, formatoAtual: "HH:mm:ss", formatoNovo: "HH:mm")
//        let horaFim = formatarData(valor: evento.horafim, formatoAtual: "HH:mm:ss", formatoNovo: "HH:mm")
//        cell.horarioLb?.text = "Horário: \(horaInicio) - \(horaFim)"
//
//
//        cell.imagem?.image = UIImage(named: "\(evento.denominacao[0].lowercased()).png")
        
        return cell
    }
    
}

//extension FavoritosView: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let linha = indexPath.row
//        let evento = EventosSingleton.shared.eventos![linha]
//
//        let vc = DetalhesEventoView(nibName: "DetalhesEventoView", bundle: nil)
//        vc.evento = evento
//        self.navigationController!.pushViewController(vc, animated: false)
//
//    }
//
//}

