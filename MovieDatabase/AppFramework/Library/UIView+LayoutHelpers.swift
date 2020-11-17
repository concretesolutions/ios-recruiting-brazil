import UIKit

// MARK: Constraints
public extension UIView {
  func makeConstraintsToEdges(
    of superView: UIView,
    insetLeft: CGFloat = 0,
    insetTop: CGFloat = 0,
    insetRight: CGFloat = 0,
    insetBottom: CGFloat = 0
  ) -> [NSLayoutConstraint] {
    [
      leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: insetLeft),
      topAnchor.constraint(equalTo: superView.topAnchor, constant: insetTop),
      trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -insetRight),
      bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -insetBottom),
    ]
  }

  func makeConstraintsToEdges(
    of superView: UIView,
    inset: CGFloat
  ) -> [NSLayoutConstraint] {
    makeConstraintsToEdges(of: superView, insetLeft: inset, insetTop: inset, insetRight: inset, insetBottom: inset)
  }
}

// MARK: Padding
public extension UIView {
  func withPadding(left: CGFloat = 0, top: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> UIView {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(self)
    NSLayoutConstraint.activate(
      makeConstraintsToEdges(of: view, insetLeft: left, insetTop: top, insetRight: right, insetBottom: bottom)
    )
    return view
  }

  func withPadding(inset: CGFloat) -> UIView {
    withPadding(left: inset, top: inset, right: inset, bottom: inset)
  }
}
