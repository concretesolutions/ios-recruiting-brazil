import AppFramework

public extension RemoteConfiguration {
  static func stub(
    baseUrl: URL = TestConstants.exampleUrl,
    posterSizes: [String] = []
  ) -> RemoteConfiguration {
    RemoteConfiguration(
      images: .init(
        baseUrl: baseUrl,
        posterSizes: posterSizes
      )
    )
  }
}

public extension MetaData {
  static func stub(configuration: RemoteConfiguration? = nil, genres: [Genre]? = nil) -> MetaData {
    MetaData(
      configuration: configuration,
      genres: genres
    )
  }
}
