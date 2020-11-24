import Combine
import UIKit

final class FilterDateCell: UITableViewCell {
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = L10n.Screen.Favorites.Filter.date
    return label
  }()

  private let textField: UITextField = {
    let textField = UITextField()
    textField.textAlignment = .right
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.keyboardType = .numberPad
    textField.placeholder = "2019"
    return textField
  }()

  private let _text = CurrentValueSubject<String?, Never>("")
  private var cancellables = Set<AnyCancellable>()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none

    textField.delegate = self

    contentView.addSubview(titleLabel)
    contentView.addSubview(textField)

    let textFieldWidthConstraint = textField.widthAnchor.constraint(equalTo: contentView.widthAnchor)
    textFieldWidthConstraint.priority = .defaultLow
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
      titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),

      textField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
      textField.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
      textField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
      textField.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
      textFieldWidthConstraint,
    ])

    textField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    cancellables = .init()
  }

  func setup(subject: CurrentValueSubject<String?, Never>) {
    textField.text = subject.value
    _text
      .subscribe(subject)
      .store(in: &cancellables)
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    print(selected)
    if selected {
      textField.becomeFirstResponder()
    }
  }

  @objc private func textFieldValueChanged() {
    _text.send(textField.text)
  }
}

extension FilterDateCell: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn _: NSRange, replacementString string: String) -> Bool {
    guard !string.isEmpty else { return true }
    let textLength = textField.text?.count ?? 0
    guard textLength + string.count <= 4 else { return false }
    let allowedCharacters = Set((0 ... 9).map(String.init))
    return string
      .map { allowedCharacters.contains(String($0)) }
      .allSatisfy { $0 }
  }
}
