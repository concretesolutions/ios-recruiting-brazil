public struct RemoteConfiguration {
  public let baseUrl: URL
  public let posterSizes: [String]

  public init(
    baseUrl: URL,
    posterSizes: [String]
  ) {
    self.baseUrl = baseUrl
    self.posterSizes = posterSizes
  }
}

public struct Genre {
  public let id: Int16
  public let name: String

  public init(
    id: Int16,
    name: String
  ) {
    self.id = id
    self.name = name
  }
}

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
