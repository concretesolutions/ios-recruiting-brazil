public struct RemoteConfiguration {
  public struct Images {
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

  public let images: Images

  public init(images: Images) {
    self.images = images
  }

  public func urlForSmallImage() -> URL {
    let size = images.posterSizes.count > 2
      ? images.posterSizes[2]
      : images.posterSizes.first ?? "w300"

    let url = images.baseUrl.appendingPathComponent(size)
    return url
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
