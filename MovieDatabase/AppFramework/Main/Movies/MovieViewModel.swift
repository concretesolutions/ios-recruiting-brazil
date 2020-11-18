public struct MovieViewModel: Identifiable, Hashable {
  public let id: Int
  public let title: String
  public let imageUrl: URL
  public let liked: Bool
}
