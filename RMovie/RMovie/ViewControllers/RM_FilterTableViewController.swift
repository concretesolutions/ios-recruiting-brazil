//
//  RM_FilterTableViewController.swift
//  RMovie
//
//  Created by Renato Mori on 06/10/2018.
//  Copyright © 2018 Renato Mori. All rights reserved.
//

import UIKit

class RM_FilterTableViewController: UITableViewController
    , UIPickerViewDataSource
    , UIPickerViewDelegate
{
    
    @IBOutlet weak var pckAnoDe: UIPickerView!;
    @IBOutlet weak var swtAnoDe: UISwitch!
    @IBOutlet weak var pckAnoAte: UIPickerView!
    @IBOutlet weak var swtAnoAte: UISwitch!
    
    @IBOutlet weak var pckGenero: UIPickerView!
    
    var moviesFilter : MovieFilter?;
    var genres : RM_HTTP_Genres?;
    
    var arrayYears : [String]?;
    var arrayGeneros : [String]?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        
        self.moviesFilter = appDelegate.moviesFilter;
        self.genres = appDelegate.genres;
        
        initArrayYears();
        initYear(pck: self.pckAnoDe ,swt: self.swtAnoDe , year: moviesFilter!.yearMin);
        initYear(pck: self.pckAnoAte ,swt: self.swtAnoAte , year: moviesFilter!.yearMax);
        
        initArrayGenero();
        initGeneros(pck: self.pckGenero,genero: self.moviesFilter!.genero);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK: - convert Genero
    func getGenero(id: NSInteger) -> String{
        return (self.genres?.genres[id])!;
    }
    
    
    func getGeneroId(genero: String) -> NSInteger?{
        for generoKey in (self.genres?.genres.keys)! {
            let value : String = (self.genres?.genres[generoKey])!;
            if(genero .elementsEqual(value)){
                return generoKey;
            }
        }
        return nil;
    }
    
    func getGeneroArrayIndex(genero: String) -> NSInteger?{
        var index = 0;
        for generoKey in (self.genres?.genres.keys)! {
            let value : String = (self.genres?.genres[generoKey])!;
            if(genero .elementsEqual(value)){
                return index;
            }
            index = index + 1;
        }
        return nil;
    }
    
    func getGeneroFromIndex(index: NSInteger) -> String{
        var i = index;
        for generoKey in (self.genres?.genres.keys)! {
            if(i > 0){
                i = i - 1;
                continue;
            }
            
            return (self.genres?.genres[generoKey])!;
        }
        return "";
    }
    
    // MARK: - Picker Views
    func   initArrayYears(){
        arrayYears = [String]();
        for i in 1970...2030 {
            arrayYears?.append(String(format:"%d", i));
        }
    }
    func initArrayGenero(){
        self.arrayGeneros = [String]();
        for generoKey in (self.genres?.genres.keys)! {
            let genero : String = (self.genres?.genres[generoKey])!;
            self.arrayGeneros?.append(genero);
        }
    }
    
    func initYear(pck:UIPickerView,swt: UISwitch, year : NSInteger?){
        pck.dataSource = self;
        pck.delegate = self;
        
        var index = 2018;
        swt.setOn( year != nil, animated: false);
        if(swt.isOn){
            index = year!;
        }
        
        pck.selectRow(index - 1970, inComponent: 0, animated: false);
    }
    
    func   initGeneros(pck: UIPickerView,genero: NSInteger?){
        pck.dataSource = self;
        pck.delegate = self;

        var index = self.genres?.genres.count;
        if(genero != nil){
            index = getGeneroArrayIndex(genero: getGenero(id: genero!))!;
        }
        pck.selectRow(index ?? 0, inComponent: 0, animated: false);
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == pckAnoDe || pickerView == pckAnoAte){
            return (arrayYears?.count)!;
        }else if(pickerView == pckGenero){
            return (genres?.genres.count)! + 1;
        }
        return 0;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView == pckAnoDe || pickerView == pckAnoAte){
            return arrayYears![row];
        }else if(pickerView == pckGenero){
            if(row == self.genres?.genres.count){
               return "Todos";
            }
            return getGeneroFromIndex(index: row);
        }
        
        return "";
    }
    
    
    
     // MARK: - Navigation
 
    @IBAction func btnSalvar_onClick(_ sender: Any) {
        if(self.swtAnoDe.isOn){
            self.moviesFilter!.yearMin = 1970 + self.pckAnoDe.selectedRow(inComponent: 0);
        }else{
            self.moviesFilter!.yearMin = nil;
        }
        
        if(self.swtAnoAte.isOn){
            self.moviesFilter!.yearMax = 1970 + self.pckAnoAte.selectedRow(inComponent: 0);
        }else{
            self.moviesFilter!.yearMax = nil;
        }
   
        let index = self.pckGenero.selectedRow(inComponent: 0);
        if(index == self.genres?.genres.count){
            self.moviesFilter?.genero = nil;
        }else{
            self.moviesFilter?.genero = self.getGeneroId(genero: self.getGeneroFromIndex(index:index));
        }
        
        self.moviesFilter?.applyFilters();
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
}
