import Kingfisher
import UIKit

public final class MovieCell: UICollectionViewCell {
  private let backgroundImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.kf.indicatorType = .activity
    return imageView
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.numberOfLines = 2
    label.adjustsFontSizeToFitWidth = true
    return label
  }()

  private let likeButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "heart"), for: .normal)
    return button
  }()

  override public init(frame: CGRect) {
    super.init(frame: frame)
    let titleLabelContainer = titleLabel.withPadding(inset: 4)
    titleLabelContainer.backgroundColor = .systemGray
    let stackView = UIStackView(arrangedSubviews: [
      backgroundImageView,
      titleLabelContainer,
    ])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .fill

    contentView.addSubview(stackView)
    contentView.addSubview(likeButton)
    var constraints = stackView.makeConstraintsToEdges(of: contentView)
    constraints.append(contentsOf: [
      likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      likeButton.bottomAnchor.constraint(equalTo: titleLabelContainer.topAnchor),
      likeButton.heightAnchor.constraint(equalToConstant: 44),
      likeButton.widthAnchor.constraint(equalToConstant: 44),
    ])
    NSLayoutConstraint.activate(constraints)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func prepareForReuse() {
    super.prepareForReuse()
    likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    backgroundImageView.image = nil
    titleLabel.text = ""
  }

  public func setup(viewModel: MovieViewModel) {
    titleLabel.text = viewModel.title

    backgroundImageView.kf.setImage(with: viewModel.imageUrl)

    let likeImage = viewModel.liked
      ? UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
      : UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)

    likeButton.setImage(likeImage, for: .normal)
  }
}
