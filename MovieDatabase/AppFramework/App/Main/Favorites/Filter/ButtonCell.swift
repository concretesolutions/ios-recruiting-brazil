import Combine
import UIKit

final class ButtonCell: UITableViewCell {
  private let _buttonTap = PassthroughSubject<Void, Never>()
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
//      button.heightAnchor.constraint(equalToConstant: 44),
    ])

    button.addTarget(self, action: #selector(didTapButton), for: .primaryActionTriggered)
  }

  private var cancellables = Set<AnyCancellable>()

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    cancellables = .init()
  }

  func setup(with title: String, subject: PassthroughSubject<Void, Never>) {
    button.setTitle(title, for: .normal)

    _buttonTap
      .subscribe(subject)
      .store(in: &cancellables)
  }

  @objc private func didTapButton() {
    _buttonTap.send(())
  }
}
