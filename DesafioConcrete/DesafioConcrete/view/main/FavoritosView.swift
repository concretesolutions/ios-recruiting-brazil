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
    
    var preferidos:Array<Movie> = Array(Singleton.shared.preferidos.values)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Favoritos"
        navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.yellow]
        
        self.tableView?.register(UINib.init(nibName: "FavoritosCell", bundle: nil), forCellReuseIdentifier: "FavoritosCell")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(Singleton.shared.updatePref) {
            Singleton.shared.updatePref = false
            preferidos = Array(Singleton.shared.preferidos.values)
            self.tableView?.reloadData()
        }
    }
    
}

extension FavoritosView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preferidos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView?.dequeueReusableCell(withIdentifier: "FavoritosCell")!  as! FavoritosCell     // Cast da célula para EventoCell
        cell.configure(with: preferidos[indexPath.row])
        return cell
    }
    
}

extension FavoritosView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = indexPath.row
        let movie = preferidos[item]
        
        let vc = DetalhesView(nibName: "DetalhesView", bundle: nil)
        vc.movie = movie
        self.navigationController!.pushViewController(vc, animated: false)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            tableView.beginUpdates()
            Singleton.shared.rmvFavoritos(id: preferidos[indexPath.row].id)
            preferidos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
            tableView.endUpdates()
        }
    }
}

