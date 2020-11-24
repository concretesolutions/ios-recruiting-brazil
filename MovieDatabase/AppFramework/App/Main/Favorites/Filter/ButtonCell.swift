import UIKit

final class ButtonCell: UITableViewCell {
  private let button = UIButton(type: .system)

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    contentView.addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      button.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
      button.topAnchor.constraint(equalTo: contentView.topAnchor),
      button.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
      button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      button.heightAnchor.constraint(equalToConstant: 44),
    ])
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setup(with title: String) {
    button.setTitle(title, for: .normal)
  }
}
