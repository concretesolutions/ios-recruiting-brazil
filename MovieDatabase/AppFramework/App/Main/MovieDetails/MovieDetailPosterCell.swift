import UIKit

final class MovieDetailPosterCell: UITableViewCell {
  private let posterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.masksToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    contentView.addSubview(posterImageView)
    NSLayoutConstraint.activate(posterImageView.makeConstraintsToEdges(of: contentView))
  }

  func setup(with url: URL) {
    posterImageView.kf.setImage(with: url)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
