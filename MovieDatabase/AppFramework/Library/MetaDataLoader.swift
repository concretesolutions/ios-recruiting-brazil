import Combine
import CoreData
import os.log
import TheMovieDatabaseApi

private func loadConfig() -> AnyPublisher<Result<RemoteConfiguration, ErrorResponse>, Never> {
  Env.client.configuration()
    .map { result in
      result
        .map { config in
          RemoteConfiguration(
            baseUrl: config.secureBaseUrl,
            posterSizes: config.posterSizes
          )
        }
    }
    .eraseToAnyPublisher()
}

private func loadGenres() -> AnyPublisher<Result<[Genre], ErrorResponse>, Never> {
  Env.client.genres()
    .map { result in
      result.map { response in
        response.genres.map { genre in Genre(id: genre.id, name: genre.name) }
      }
    }
    .eraseToAnyPublisher()
}

public class MetaDataLoader {
  private let _reloadConfig = PassthroughSubject<Void, Never>()
  private let _reloadGenres = PassthroughSubject<Void, Never>()
  public let metaData: AnyPublisher<MetaData, Never>

  public init() {
    let genreRepo = MOGenreRepo.default(moc: Env.database.moc)
    let currentSavedGenres = genreRepo.getAll()

    let config = _reloadConfig
      .map { _ in loadConfig() }
      .switchToLatest()

    let genres = _reloadGenres
      .map { _ in loadGenres() }
      .switchToLatest()
      .handleEvents(receiveOutput: { result in
        if case let .success(genres) = result, genres.count > 0 {
          let currentSavedIds = Set(currentSavedGenres.map(\.id))
          let fromServerIds = Set(genres.map(\.id))
          let changes = currentSavedIds
            .symmetricDifference(fromServerIds)
            .intersection(currentSavedIds)

          if changes.count == 0 { return }

          genres
            .filter { changes.contains($0.id) }
            .forEach { genre in
              let moGenre = MOGenre(context: Env.database.moc)
              moGenre.id = genre.id
              moGenre.name = genre.name
            }

          if genres.count == 0 { return }

          do {
            try Env.database.moc.save()
            os_log("Saved MOGenres from server", log: generalLog, type: .debug)
          } catch {
            os_log("Failed to save MOGenres, reason: %s", log: generalLog, type: .error, error.localizedDescription)
          }
        }
      })
      .map { result -> Result<[Genre], ErrorResponse> in
        if case .failure = result {
          let genres = genreRepo.getAll()
            .map { genre in Genre(id: genre.id, name: genre.name) }
          return .success(genres)
        }

        return result
      }

    metaData = Publishers.CombineLatest(config, genres)
      .map { configResult, genresResult -> MetaData in
        var genres: [Genre]?
        var configuration: RemoteConfiguration?

        if case let .success(config) = configResult {
          configuration = config
        }

        if case let .success(gen) = genresResult {
          genres = gen
        }

        return MetaData(
          configuration: configuration,
          genres: genres
        )
      }
      .share()
      .eraseToAnyPublisher()
  }

  public func reloadMetaData() {
    reloadRemoteConfiguration()
    reloadGenre()
  }

  public func reloadRemoteConfiguration() {
    _reloadConfig.send(())
  }

  public func reloadGenre() {
    _reloadGenres.send(())
  }
}
