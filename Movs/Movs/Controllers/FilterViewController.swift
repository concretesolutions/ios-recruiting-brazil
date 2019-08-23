//
//  FilterViewController.swift
//  Movs
//
//  Created by Gustavo Caiafa on 22/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, didSelectDateFilterProtocol, didSelectGenresFilterProtocol {
    
    // Delegate usado para mostrar na label o genero que foi selecionado na controller de GenericFilter
    func selectedGenre(didSelect: Bool, genre: String?) {
        if(didSelect){
            lblGenres.text = genre
        }
    }
    
    // Delegate usado para mostrar na label a data que foi selecionado na controller de GenericFilter
    func selectedDate(didSelect: Bool, date: Int?) {
        if(didSelect){
            lblDate.text = String(date!)
        }
    }
        
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var genresView: UIView!
    @IBOutlet weak var dateView: UIView!
    
    /*Variaveis responsaveis por mostrar o filtro que foi passado para a tela de Favorites
     Caso o usuario nao tenha limpado o filtro, quando ele voltar para essa controller, os mesmos aparecerao na tela
    */
    var filterDate = ""
    var filterGenre = ""
    var didfilterProtocol : didFilterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapDate = UITapGestureRecognizer(target: self, action: #selector(openDateFilterVC))
        self.dateView.addGestureRecognizer(tapDate)
        
        let tapGenres = UITapGestureRecognizer(target: self, action: #selector(openGenresFilterVC))
        self.genresView.addGestureRecognizer(tapGenres)
        self.lblDate.text = filterDate
        self.lblGenres.text = filterGenre
    }

    @IBAction func BtVoltar(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func BtApplyFilter(_ sender: UIButton) {
        if(lblGenres.text != "" || lblDate.text != ""){
            var genrefilter : String? = nil
            var datefilter : Int? = nil
            if(lblGenres.text != ""){
                genrefilter = lblGenres.text
            }
            if(lblDate.text != ""){
                datefilter = Int(lblDate.text!)
            }
            didfilterProtocol?.selectedFilters(date: datefilter, genre: genrefilter)
            dismiss(animated: true, completion: nil)
        }
        else{
            showAlertaController(self, texto: "Você precisa selecionar pelo menos um tipo!", titulo: "Seus filtros estão vazios", dismiss: false)
        }
    }
    
    @objc func openDateFilterVC(){
        let viewController = (self.storyboard?.instantiateViewController(withIdentifier: "GenericFilterViewController")) as! GenericFilterViewController
        viewController.modalPresentationStyle = .fullScreen
        viewController.delegateDateFilterProtocol = self
        viewController.isDates = true
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc func openGenresFilterVC(){
        let viewController = (self.storyboard?.instantiateViewController(withIdentifier: "GenericFilterViewController")) as! GenericFilterViewController
        viewController.modalPresentationStyle = .fullScreen
        viewController.delegateGenreFilterProtocol = self
        viewController.isDates = false
        self.present(viewController, animated: true, completion: nil)
    }
}
