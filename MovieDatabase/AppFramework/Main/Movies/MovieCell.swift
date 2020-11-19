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
    return label
  }()

  private let likeButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "heart"), for: .normal)
    return button
  }()

  override public init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .yellow

    let titleLabelContainer = titleLabel.withPadding(inset: 16)
    titleLabelContainer.backgroundColor = .systemGray
    let stackView = UIStackView(arrangedSubviews: [
      backgroundImageView,
      titleLabelContainer,
    ])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.backgroundColor = .red

    contentView.addSubview(stackView)
    NSLayoutConstraint.activate(
      stackView.makeConstraintsToEdges(of: contentView)
    )
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
