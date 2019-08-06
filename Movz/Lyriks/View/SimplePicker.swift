//
//  SimplePicker.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 03/08/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit

class SimplePicker: UIPickerView {
    var data:[String]
    var selected = "None"
    
    override init(frame: CGRect) {
        self.data = []
        super.init(frame: frame)
        self.delegate = self
        self.dataSource = self
    }
    convenience init(data:[String]){
        self.init(frame:CGRect.zero)
        self.data = data
        self.data.insert("None", at: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
        Identify if scroll have a valid genre
    */
    func haveValue()->Bool{
        return !(selected == "None")
    }
    
}
extension SimplePicker:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }

    
}
extension SimplePicker:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //Customize font and color of picker label
        let pickerLabel = UILabel()

        let attributedString = NSAttributedString(string: data[row], attributes:Typography.description(Color.scarlet).attributes())
        pickerLabel.attributedText = attributedString

        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = data[row]
    }
}
