import AppFramework

public extension MOMovieRepo {
  static func mock(
    get: @escaping (Int) -> MOMovie? = { _ in nil },
    getAll: @escaping () -> [MOMovie] = { [] },
    create: @escaping ((inout MOMovie) -> Void) -> MOMovie? = { _ in nil },
    delete: @escaping (MOMovie) -> Bool = { _ in false }
  ) -> MOMovieRepo {
    MOMovieRepo(
      get: get,
      getAll: getAll,
      create: create,
      delete: delete
    )
  }
}
