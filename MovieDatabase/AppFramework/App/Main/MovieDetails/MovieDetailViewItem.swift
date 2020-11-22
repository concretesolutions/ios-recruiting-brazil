import Foundation

public enum MovieDetailItem: Hashable {
  case poster(String)
  case title(MovieDetailTitleViewModel)
  case year(String)
  case genres([String])
  case overview(String)
}
