import Combine
import UIKit

final class FilterCell: UITableViewCell {
  private var cancellables = Set<AnyCancellable>()

  override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    accessoryType = .disclosureIndicator
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    cancellables = .init()
  }

  public func setup(title: String, detailValue: AnyPublisher<String, Never>) {
    textLabel?.text = title

    detailValue
      .sink(receiveValue: { [weak self] value in
        self?.detailTextLabel?.text = value
      })
      .store(in: &cancellables)
  }
}
