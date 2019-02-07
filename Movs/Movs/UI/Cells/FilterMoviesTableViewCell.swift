//
//  FilterMoviesTableViewCell.swift
//  Movs
//
//  Created by Brendoon Ryos on 06/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit
import Reusable
import SnapKit

/**
 The delegate of an AUPickerCell object must adopt this protocol and implement its methods to retrieve the currently selected values.
 */
protocol FilterPickerCellDelegate {
  /**
   Called by the picker view when the user selects a value.
   - Parameter cell: An object representing the table view cell that contains the picker view.
   - Parameter row: A zero-indexed number identifying a row of a component. Rows are numbered top-to-bottom. This value is ignored if the picker type is .date.
   - Parameter value: The value represented by the selected row. This is a string for .default, and a date for .date type pickers.
   */
  func filterPickerCell(_ cell: FilterMoviesTableViewCell, didPick row: Int, value: String)
}

class FilterMoviesTableViewCell: UITableViewCell, Reusable {
  
  /**
   The picker type determines whether a UIPickerView or a UIDatePicker is used to display and pick values.
   */
  public enum PickerType {
    /// A type that displays a UIPickerView to select from provided strings.
    case `default`
    /// A type that displays a UIDatePicker to select a date and/or time.
    case date
  }
  
  static func height() -> CGFloat {
    return 44
  }
  /// The label on the left side of the cell that typically displays an explanatory text.
  
  lazy var leftLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: FontNames.regular, size: 18)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  /// The label on the right side of the cell that displays the currently selected value in the picker view.
  lazy var rightLabel: UILabel = {
    let label = UILabel()
    label.textColor = ColorPalette.yellow
    label.font = UIFont(name: FontNames.medium, size: 18)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  private var rightLabelTextColor = UIColor.darkText
  
  private let separator: ColorLockedView = {
    let view = ColorLockedView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.lockedBackgroundColor = UIColor(white: 0, alpha: 0.1)
    return view
  }()
  private(set) var picker: UIView = UIPickerView()
  
  /// The current status of the cell's status. The picker view is visible while the cell is expanded and hidden when it is not. Set this property to the desired state and reload table view rows to expand or contract the cell.
  public var expanded = false
  
  private var leftLabelHeightConstraint: NSLayoutConstraint?
  private var rightLabelHeightConstraint: NSLayoutConstraint?
  private var separatorHeightConstraint: NSLayoutConstraint?
  
  /// The height of the cell when the it is not expanded. The default is 44.0.
  var unexpandedHeight: CGFloat = 44.0 {
    didSet {
      leftLabelHeightConstraint?.constant = unexpandedHeight
      rightLabelHeightConstraint?.constant = unexpandedHeight
    }
  }
  
  /// The height (thickness) of the separator line between the labels and the picker view when the cell is expanded. The default is 0.5.
  var separatorHeight: CGFloat = 0.5 {
    didSet {
      separatorHeightConstraint?.constant = separatorHeight
    }
  }
  
  /// An array of strings to be displayed by the picker view. This is ignored if picker type is not .default.
  var values = [String]()
  
  /// A class that receives notifications from an AUPickerCell instance. The class must implement the required protocol method "auPickerCell(_ cell: AUPickerCell, didPick row: Int, value: Any)"
  var delegate: FilterPickerCellDelegate?
  
  /**
   The currently selected row of string picker.
   
   Use this property to get and set the currently selected row. The default value is 0. Setting this property animates the picker by spinning the wheels to the new value; if you don't want any animation to occur when you set the row, use the setSelectedRow(_:animated:) method, passing false for the animated parameter. This is ignored if picker type is not .default.
   */
  var selectedRow: Int {
    get {
      return _selectedRow
    }
    set {
      setSelectedRow(newValue, animated: true)
    }
  }
  private var _selectedRow: Int = 0
  
  /// The height of table view cell. Height is calculated dynamically based on whether or not the cell is expanded.
  var height: CGFloat {
    let expandedHeight = unexpandedHeight + picker.bounds.height
    return expanded ? expandedHeight : unexpandedHeight
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    initialize()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initialize() {
    
    clipsToBounds = true
    
    picker = UIPickerView()
    (picker as! UIPickerView).delegate = self
    (picker as! UIPickerView).dataSource = self
    
    picker.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(leftLabel)
    contentView.addSubview(rightLabel)
    contentView.addSubview(separator)
    contentView.addSubview(picker)
    
    leftLabelHeightConstraint = leftLabel.heightAnchor.constraint(equalToConstant: unexpandedHeight)
    leftLabelHeightConstraint?.isActive = true
    leftLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    leftLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
    
    rightLabelHeightConstraint = rightLabel.heightAnchor.constraint(equalToConstant: unexpandedHeight)
    rightLabelHeightConstraint?.isActive = true
    rightLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    rightLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
    
    separatorHeightConstraint = separator.heightAnchor.constraint(equalToConstant: separatorHeight)
    separatorHeightConstraint?.isActive = true
    separator.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
    separator.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
    separator.topAnchor.constraint(equalTo: leftLabel.bottomAnchor).isActive = true
    
    picker.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
    picker.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
    picker.topAnchor.constraint(equalTo: separator.bottomAnchor).isActive = true
    
    picker.snp.makeConstraints { make in
      make.height.equalTo(3*unexpandedHeight)
    }
  }
  
  /**
   Expands or contracts the table cell depending on its current state. Call this method from the "tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)" delegate method to show or hide the picker view with an animation.
   - Parameter tableView: The UITableView object that contains the cell.
   */
  public func selectedInTableView(_ tableView: UITableView) {
    if !expanded {
      rightLabelTextColor = rightLabel.textColor
    }
    expanded = !expanded
    
    UIView.transition(with: rightLabel, duration: 0.25, options: .transitionCrossDissolve, animations: { [unowned self] in
      self.rightLabel.textColor = self.expanded ? self.tintColor : self.rightLabelTextColor
    })
    
    tableView.beginUpdates()
    tableView.endUpdates()
  }
  
  /**
   Sets the row to display in the picker view, with an option to animate the setting.
   - Parameter row: A zero indexed number representing the new row to display in the picker view.
   - Parameter animated: true to animate the setting of the new row, otherwise false. The animation rotates the wheels until the new row is shown under the highlight rectangle.
   */
  public func setSelectedRow(_ row: Int, animated: Bool) {
    guard let picker = picker as? UIPickerView else {
      return
    }
    _selectedRow = row
    picker.selectRow(row, inComponent: 0, animated: animated)
    rightLabel.text = values[row]
  }
}

extension FilterMoviesTableViewCell: UIPickerViewDelegate {
  
  public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return values[row]
  }
  
  public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    rightLabel.text = values[row]
    delegate?.filterPickerCell(self, didPick: row, value: values[row])
  }
}

extension FilterMoviesTableViewCell: UIPickerViewDataSource {
  
  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return values.count
  }
}

private class ColorLockedView: UIView {
  var lockedBackgroundColor:UIColor {
    set { super.backgroundColor = newValue }
    get { return super.backgroundColor! }
  }
  override var backgroundColor:UIColor? {
    set { }
    get { return super.backgroundColor }
  }
}
