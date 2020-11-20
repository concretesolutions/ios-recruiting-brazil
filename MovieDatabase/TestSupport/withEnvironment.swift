import AppFramework
import TheMovieDatabaseApi

public func withEnvironment(
  _ env: Environment,
  body: @escaping () -> Void
) {
  let oldEnv = Env
  Env = env
  body()
  Env = oldEnv
}

public func withEnvironment(
  client: TMDClient = Env.client,
  body: @escaping () -> Void
) {
  let env = Environment(client: client)
  withEnvironment(env, body: body)
}
