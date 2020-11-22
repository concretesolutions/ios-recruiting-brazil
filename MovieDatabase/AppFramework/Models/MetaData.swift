public struct MetaData {
  public let configuration: RemoteConfiguration?
  public let genres: [Genre]?

  public init(
    configuration: RemoteConfiguration?,
    genres: [Genre]?
  ) {
    self.configuration = configuration
    self.genres = genres
  }
}
