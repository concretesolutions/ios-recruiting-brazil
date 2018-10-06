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
    
    var movies : RM_HTTP_Movies?;
    var arrayYears : [String]?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initArrayYears();
        initYear(pck: self.pckAnoDe ,swt: self.swtAnoDe , year: movies?.yearMin);
        initYear(pck: self.pckAnoAte ,swt: self.swtAnoAte , year: movies?.yearMax);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // MARK: - Picker Views
    func   initArrayYears(){
        arrayYears = [String]();
        for i in 1970...2030 {
            arrayYears?.append(String(format:"%d", i));
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == pckAnoDe || pickerView == pckAnoAte){
            return (arrayYears?.count)!;
        }else if(pickerView == pckGenero){
            
        }
        return 0;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView == pckAnoDe || pickerView == pckAnoAte){
            return arrayYears![row];
        }else if(pickerView == pckGenero){
            
        }
        
        return "";
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func btnSalvar_onClick(_ sender: Any) {
        if(self.swtAnoDe.isOn){
            self.movies?.yearMin = 1970 + self.pckAnoDe.selectedRow(inComponent: 0);
        }else{
            self.movies?.yearMin = nil;
        }
        
        if(self.swtAnoAte.isOn){
            self.movies?.yearMax = 1970 + self.pckAnoAte.selectedRow(inComponent: 0);
        }else{
            self.movies?.yearMax = nil;
        }
        
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
}
