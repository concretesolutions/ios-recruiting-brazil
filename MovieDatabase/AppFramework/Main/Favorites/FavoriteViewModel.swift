public struct FavoriteViewModel: Identifiable, Hashable {
  public let id: Int64
  public let title: String
  public let overview: String

  public init(
    id: Int64,
    title: String,
    overview: String
  ) {
    self.id = id
    self.title = title
    self.overview = overview
  }
}
