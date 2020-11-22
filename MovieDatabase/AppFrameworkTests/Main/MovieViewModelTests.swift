import AppFramework
import Combine
import CoreData
import TestSupport
import TheMovieDatabaseApi
import XCTest

private class MovieRepoSpy {
  lazy var movieRepo: MovieRepo = {
    MovieRepo.mock(
      get: { [weak self] id in
        self?.get.append(id)
        return self?.movie
      },
      create: { [weak self] _ in
        guard let self = self else { return nil }
        self.create += 1
        let movie = Movie(id: 1, title: "", year: "", genreIds: [], overview: "", posterUrl: TestConstants.exampleUrl)
        self.movie = movie
        return movie
      },
      delete: { [weak self] _ in
        self?.delete += 1
        self?.movie = nil
        return true
      }
    )
  }()

  var get: [Int64]
  var create: Int
  var delete: Int

  var movie: Movie?
  let database: Database

  public init(database: Database) {
    get = []
    create = 0
    delete = 0
    movie = nil
    self.database = database
  }
}

final class MovieViewModelTests: XCTestCase {
  var cancellables: Set<AnyCancellable>!
  var database: Database!

  override func setUpWithError() throws {
    database = Database(
      name: "Test",
      managedObjectModel: NSManagedObjectModel.mergedModel(from: [Bundle(for: MoviesViewController.self)])!
    )
    database.loadStore()
    cancellables = .init()
  }

  override func tearDownWithError() throws {
    cancellables = nil
    database = nil
  }

  func testMovieViewModel_LikeEvents_ShouldCreateAndDeleteMOMovies() throws {
    let spy = MovieRepoSpy(database: database)
    let movie = Movie(id: 1, title: "", year: "", genreIds: [], overview: "", posterUrl: TestConstants.exampleUrl)
    let viewModel = MovieViewModel.default(movie: movie, repo: spy.movieRepo)

    let like = PassthroughSubject<Void, Never>()
    let refresh = PassthroughSubject<Void, Never>()
    let output = viewModel
      .transform(
        .init(like: like.eraseToAnyPublisher(), refresh: refresh.eraseToAnyPublisher())
      )

    let valuesExpectation = expectation(description: "values")

    output.like
      .collect(6)
      .sink(receiveValue: { likes in
        XCTAssertEqual(
          [false, true, false, true, false, false],
          likes
        )
        valuesExpectation.fulfill()
      })
      .store(in: &cancellables)

    like.send(())
    like.send(())
    like.send(())
    like.send(())
    refresh.send(())

    waitForExpectations(timeout: 1.0, handler: nil)

    XCTAssertEqual(spy.get, [1, 1])
    XCTAssertEqual(spy.create, 2)
    XCTAssertEqual(spy.delete, 2)
  }
}
