import Combine
import Design
import Kingfisher
import UIKit

public final class MovieCell: UICollectionViewCell {
  // MARK: UI

  private let backgroundImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.kf.indicatorType = .activity
    return imageView
  }()

  private let likeButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "heart"), for: .normal)

    button.imageView?.layer.shadowColor = UIColor.black.cgColor
    button.imageView?.layer.shadowRadius = 1.0
    button.imageView?.layer.shadowOpacity = 1.0
    button.imageView?.layer.shadowOffset = .zero // CGSize(width: 1, height: 1)
    button.imageView?.layer.masksToBounds = false

    button.tintColor = Asset.Colors.accent.color

    return button
  }()

  // MARK: Publishers

  private let _like = PassthroughSubject<Void, Never>()

  // MARK: Other Properties

  private let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: UIFont.systemFont(ofSize: 32).pointSize, weight: .regular, scale: .medium)
  private var cancellables = Set<AnyCancellable>()

  // MARK: Lifecycle

  override public init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func prepareForReuse() {
    super.prepareForReuse()
    likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    backgroundImageView.image = nil
    cancellables.removeAll()
  }

  // MARK: Methods

  private func setupUI() {
    contentView.addSubview(backgroundImageView)
    contentView.addSubview(likeButton)

    NSLayoutConstraint.activate(
      backgroundImageView.makeConstraintsToEdges(of: contentView) +
        [
          likeButton.topAnchor.constraint(equalTo: contentView.topAnchor),
          likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
          likeButton.heightAnchor.constraint(equalToConstant: 44),
          likeButton.widthAnchor.constraint(equalToConstant: 44),
        ]
    )

    contentView.layer.cornerRadius = 8
    contentView.layer.masksToBounds = true

    likeButton.addTarget(self, action: #selector(didTapLike), for: .primaryActionTriggered)
  }

  public func setup(viewModel: MovieViewModel, refresh: AnyPublisher<Void, Never>) {
    backgroundImageView.kf.setImage(with: viewModel.movie.posterUrl)

    let output = viewModel.transform(
      .init(
        like: _like
          .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)
          .eraseToAnyPublisher(),
        refresh: refresh
      )
    )

    output.like
      .map { [symbolConfiguration] liked in
        liked
          ? UIImage(systemName: "heart.fill", withConfiguration: symbolConfiguration)?.withRenderingMode(.alwaysTemplate)
          : UIImage(systemName: "heart", withConfiguration: symbolConfiguration)?.withRenderingMode(.alwaysTemplate)
      }
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] likeImage in
        self?.likeButton.setImage(likeImage, for: .normal)
      })
      .store(in: &cancellables)
  }

  @objc private func didTapLike() {
    _like.send(())
  }
}
