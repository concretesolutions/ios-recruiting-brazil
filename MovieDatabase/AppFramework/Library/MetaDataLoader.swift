import Combine
import CoreData
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
    let config = _reloadConfig
      .map { _ in loadConfig() }
      .switchToLatest()

    let genres = _reloadGenres
      .map { _ in loadGenres() }
      .switchToLatest()

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
