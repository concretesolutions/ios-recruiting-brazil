import TheMovieDatabaseApi

public struct Environment {
  public var client: TMDClient
  public var database: Database
  public var notificationCenter: NotificationCenter

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
    notificationCenter = .default
  }

  public init(
    client: TMDClient,
    database: Database,
    notificationCenter: NotificationCenter
  ) {
    self.client = client
    self.database = database
    self.notificationCenter = notificationCenter
  }
}

#if DEBUG
  public var Env = Environment()
#else
  public let Env = Environment()
#endif
