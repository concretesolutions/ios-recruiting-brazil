import TheMovieDatabaseApi

public struct Environment {
  public var client: TMDClient
  public var database: Database

  init() {
    client = TMDClient(
      session: URLSession.shared,
      baseUrl: Constants.baseUrl,
      middlewares: [
        .defaultHeadersMiddleware(),
        .authenticationMiddleware(apiKey: Constants.apiKey),
      ]
    )
    database = Database()
  }

  public init(
    client: TMDClient,
    database: Database
  ) {
    self.client = client
    self.database = database
  }
}

#if DEBUG
  public var Env = Environment()
#else
  public let Env = Environment()
#endif
