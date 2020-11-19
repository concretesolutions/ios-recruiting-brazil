import TheMovieDatabaseApi

enum Constants {
  static let baseUrl = URL(string: "")!
  static let apiKey = ""
}

struct Environment {
  var client = TMDClient(
    baseUrl: Constants.baseUrl,
    middlewares: [
      .defaultHeadersMiddleware(),
      .authenticationMiddleware(apiKey: Constants.apiKey),
    ]
  )
}

#if DEBUG
  var Env = Environment()
#else
  let Env = Environment()
#endif
