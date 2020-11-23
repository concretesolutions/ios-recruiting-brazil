import AppFramework
import Combine
import TestSupport
import XCTest

extension Movie {
  static func stub(
    id: Int64 = 0,
    title: String = "",
    year: String = "",
    genreIds: [Int16] = [],
    overview: String = "",
    posterUrl: URL = TestConstants.exampleUrl
  ) -> Movie {
    Movie(
      id: id,
      title: title,
      year: year,
      genreIds: genreIds,
      overview: overview,
      posterUrl: posterUrl
    )
  }
}

final class FilterTests: XCTestCase {
  func testFilterContramap() {
    let filter = Filter<String> { str in str.contains("a") }
      .contramap { (urlQueryItem: URLQueryItem) in
        urlQueryItem.name
      }

    let expected = filter.runFilter([
      URLQueryItem(name: "bbbb", value: ""),
      URLQueryItem(name: "bbbab", value: ""),
      URLQueryItem(name: "adsf", value: ""),
      URLQueryItem(name: "zzzz", value: ""),
    ])

    XCTAssertEqual(expected, [
      URLQueryItem(name: "bbbab", value: ""),
      URLQueryItem(name: "adsf", value: ""),
    ])
  }

  func testFilterMerge_WithAndStrategy() {
    let filterLessThenTen = Filter<Int> { i in i < 10 }
    let filterEven = Filter<Int> { i in i % 2 == 0 }
    let merged = filterLessThenTen.merge(with: filterEven, strategy: .and)

    let expected = merged.runFilter(Array(0 ... 15))

    XCTAssertEqual(expected, [
      0, 2, 4, 6, 8,
    ])
  }

  func testFilterMerge_WithOrStrategy() {
    let filterLessThenFive = Filter<Int> { i in i < 5 }
    let filterEven = Filter<Int> { i in i % 2 == 0 }
    let merged = filterLessThenFive.merge(with: filterEven, strategy: .or)

    let expected = merged.runFilter(Array(0 ... 10))

    XCTAssertEqual(expected, [
      0, 1, 2, 3, 4, 6, 8, 10,
    ])
  }

  func testMovieFilterByTitle() {
    let movies = [
      Movie.stub(id: 0, title: "123a4"),
      Movie.stub(id: 1, title: "12345"),
      Movie.stub(id: 2, title: "qwertya"),
      Movie.stub(id: 3, title: "zxcvbn"),
    ]

    let expected = Filters.movieFilter(byTitle: "a")
      .runFilter(movies)

    XCTAssertEqual(expected, [
      Movie.stub(id: 0, title: "123a4"),
      Movie.stub(id: 2, title: "qwertya"),
    ])
  }

  func testMovieFilterByYear() {
    let movies = [
      Movie.stub(id: 0, year: "2000"),
      Movie.stub(id: 1, year: "2001"),
      Movie.stub(id: 2, year: "2002"),
    ]

    let expected = Filters.movieFilter(byYear: "2002")
      .runFilter(movies)

    XCTAssertEqual(expected, [
      Movie.stub(id: 2, year: "2002"),
    ])
  }

  func testMovieFilterByGenreIds() {
    let movies = [
      Movie.stub(id: 0, genreIds: [0, 1, 2, 3, 4]),
      Movie.stub(id: 1, genreIds: [1, 3, 10]),
      Movie.stub(id: 2, genreIds: [0, 2, 4]),
      Movie.stub(id: 3, genreIds: [9, 8, 10]),
      Movie.stub(id: 4, genreIds: [11, 12, 13]),
    ]

    let expected = Filters.movieFilter(byGenreIds: [1, 12])
      .runFilter(movies)

    XCTAssertEqual(expected, [
      Movie.stub(id: 0, genreIds: [0, 1, 2, 3, 4]),
      Movie.stub(id: 1, genreIds: [1, 3, 10]),
      Movie.stub(id: 4, genreIds: [11, 12, 13]),
    ])
  }
}
