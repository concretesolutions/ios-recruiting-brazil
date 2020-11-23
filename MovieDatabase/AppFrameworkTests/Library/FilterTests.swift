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
  func testMovieFilter() {
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

  func testFilterContramap() {
    let filter = Filter<String>(predicate: { str in str.contains("a") })
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
}
