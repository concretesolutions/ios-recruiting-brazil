import TheMovieDatabaseApi

public struct Environment {
  public var client: TMDClient

  init() {
    client = TMDClient(
      session: URLSession.shared,
      baseUrl: Constants.baseUrl,
      middlewares: [
        .defaultHeadersMiddleware(),
        .authenticationMiddleware(apiKey: Constants.apiKey),
      ]
    )
  }

  public init(client: TMDClient) {
    self.client = client
  }
}

#if DEBUG
  public var Env = Environment()
#else
  public let Env = Environment()
#endif
