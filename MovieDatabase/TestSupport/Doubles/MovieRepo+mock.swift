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

  static func inMemmoryMock(movies: [Movie]) -> MovieRepo {
    var movies = movies
    return .mock(
      get: { id in movies.first(where: { $0.id == id }) },
      getAll: { movies },
      create: { movie in
        movies.append(movie)
        return movie
      },
      delete: { movie in
        if let index = movies.firstIndex(of: movie) {
          movies.remove(at: index)
          return true
        } else {
          return false
        }
      }
    )
  }
}
