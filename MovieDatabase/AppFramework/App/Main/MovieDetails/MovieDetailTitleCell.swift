import Combine
import UIKit

public struct MovieDetailTitleViewModel: Hashable {
  public static func == (lhs: MovieDetailTitleViewModel, rhs: MovieDetailTitleViewModel) -> Bool {
    lhs.title == rhs.title
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(title)
  }

  public struct Input {
    public let like: AnyPublisher<Void, Never>

    public init(
      like: AnyPublisher<Void, Never>
    ) {
      self.like = like
    }
  }

  public struct Output {
    public let like: AnyPublisher<Bool, Never>

    public init(like: AnyPublisher<Bool, Never>) {
      self.like = like
    }
  }

  public let title: String
  public let transform: (Input) -> Output

  public init(
    title: String,
    transform: @escaping (Input) -> Output
  ) {
    self.title = title
    self.transform = transform
  }

  public static func `default`(
    movie: Movie,
    repo: MovieRepo = .default(moc: Env.database.moc)
  ) -> MovieDetailTitleViewModel {
    MovieDetailTitleViewModel(title: movie.title) { input in
      let initialLiked = repo.get(movie.id) != nil

      let like = input.like
        .scan(initialLiked) { acc, _ in !acc }
        .handleEvents(receiveOutput: { liked in
          if liked {
            _ = repo.create(movie)
          } else {
            _ = repo.delete(movie)
          }
        })
        .prepend(initialLiked)
        .share()

      return Output(
        like: like.eraseToAnyPublisher()
      )
    }
  }
}

final class MovieDetailTitleCell: UITableViewCell {
  private let _like = PassthroughSubject<Void, Never>()
  private var cancellables = Set<AnyCancellable>()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    return label
  }()

  private let likeButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "heart"), for: .normal)
    return button
  }()

  override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none

    likeButton.addTarget(self, action: #selector(didTapLike), for: .primaryActionTriggered)

    contentView.addSubview(titleLabel)
    contentView.addSubview(likeButton)
    likeButton.setContentCompressionResistancePriority(.required, for: .horizontal)

    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
      titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -8),

      likeButton.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
      likeButton.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
      likeButton.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
      likeButton.widthAnchor.constraint(equalToConstant: 44),
    ])
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func setup(with viewModel: MovieDetailTitleViewModel) {
    titleLabel.text = viewModel.title

    let output = viewModel.transform(
      .init(
        like: _like.eraseToAnyPublisher()
      )
    )

    output.like
      .map { liked in
        liked
          ? UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
          : UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
      }
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] likeImage in
        self?.likeButton.setImage(likeImage, for: .normal)
      })
      .store(in: &cancellables)
  }

  @objc public func didTapLike() {
    _like.send(())
  }
}
