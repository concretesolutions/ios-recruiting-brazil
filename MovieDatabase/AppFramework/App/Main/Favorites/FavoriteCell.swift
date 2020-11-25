import UIKit

public final class FavoriteCell: UITableViewCell {
  private let posterImageView: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.kf.indicatorType = .activity
    iv.contentMode = .scaleAspectFill
    iv.layer.masksToBounds = true
    return iv
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 2
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    return label
  }()

  private let yearLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .body)
    return label
  }()

  private let bodyLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 3
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    return label
  }()

  override public init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(posterImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(yearLabel)
    contentView.addSubview(bodyLabel)

    yearLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    yearLabel.setContentHuggingPriority(.required, for: .horizontal)
    titleLabel.setContentHuggingPriority(.required, for: .vertical)

    NSLayoutConstraint.activate([
      posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      posterImageView.widthAnchor.constraint(equalToConstant: 100),

      titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
      titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),

      yearLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
      yearLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      yearLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

      bodyLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
      bodyLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor),
      bodyLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
      bodyLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
    ])
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func prepareForReuse() {
    super.prepareForReuse()
    posterImageView.image = nil
    titleLabel.text = nil
    yearLabel.text = nil
    bodyLabel.text = nil
  }

  public func setup(with movie: Movie) {
    posterImageView.kf.setImage(with: movie.posterUrl)
    titleLabel.text = movie.title
    yearLabel.text = movie.year
    bodyLabel.text = movie.overview
  }
}
