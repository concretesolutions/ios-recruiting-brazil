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
  database: Database = Env.database,
  notificationCenter: NotificationCenter = Env.notificationCenter,
  body: @escaping () -> Void
) {
  let env = Environment(
    client: client,
    database: database,
    notificationCenter: notificationCenter
  )
  withEnvironment(env, body: body)
}
