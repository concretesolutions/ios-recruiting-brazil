import AppFramework

public extension MovieRepo {
  static func mock(
    get: @escaping (Int64) -> Movie? = { _ in nil },
    getAll: @escaping () -> [Movie] = { [] },
    create: @escaping (Movie) -> Movie? = { _ in nil },
    delete: @escaping (Movie) -> Bool = { _ in false }
  ) -> MovieRepo {
    MovieRepo(
      get: get,
      getAll: getAll,
      create: create,
      delete: delete
    )
  }
}
