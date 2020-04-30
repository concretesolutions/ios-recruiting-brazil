//
//  FilterItemTableViewCell.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 28/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

protocol FilterItemDelegate {
    func valueChange(for itemIdentifier: String, to value: String)
}

class FilterItemTableViewCell: UITableViewCell {

    fileprivate let pickerView = ToolbarPickerView()
    public var delegate: FilterItemDelegate?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var textField: UITextField!

    private var commitedValue = ""

    var options: [String] = []
    var itemIdentifier: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupPicker()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(title: String, value: String, options: [String], as itemIdentifier: String) {
        self.itemIdentifier = itemIdentifier
        self.options = options
        self.titleLabel.text = title

        self.commitedValue = value
        self.textField.text = value
        self.valueLabel.text = value
    }
}

extension FilterItemTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    private func setupPicker() {

        self.textField.inputView = self.pickerView
        self.textField.inputAccessoryView = self.pickerView.toolbar

        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self

        self.pickerView.reloadAllComponents()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.valueLabel.text = options[row]
    }
}

extension FilterItemTableViewCell: ToolbarPickerViewDelegate {

    func didTapDone() {
        let row = self.pickerView.selectedRow(inComponent: 0)
        self.pickerView.selectRow(row, inComponent: 0, animated: false)
        commitedValue = options[row]
        self.textField.text = commitedValue
        self.valueLabel.text = commitedValue
        delegate?.valueChange(for: itemIdentifier, to: commitedValue)
        self.textField.resignFirstResponder()
    }

    func didTapCancel() {
        self.valueLabel.text = commitedValue
        self.valueLabel.text = commitedValue
        self.textField.resignFirstResponder()
    }
}
