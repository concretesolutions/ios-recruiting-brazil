import UIKit

final class FilterCell: UITableViewCell {
  override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    accessoryType = .disclosureIndicator
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
