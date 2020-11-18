import AppFramework
import Combine
import XCTest

struct TestError: Error, Equatable {}

class PaginationSinkTests: XCTestCase {
  var cancellables: Set<AnyCancellable>!

  override func setUpWithError() throws {
    cancellables = .init()
  }

  override func tearDownWithError() throws {
    cancellables = nil
  }

  func testPaginationSink_RefreshAfterNextPage_ShouldResetValuesAndCursor() throws {
    let _refresh = PassthroughSubject<Void, Never>()
    let _nextPage = PassthroughSubject<Void, Never>()

    let paginationSink = PaginationSink<Int, Never>.make(
      refreshTrigger: _refresh.share().eraseToAnyPublisher(),
      nextPageTrigger: _nextPage.share().eraseToAnyPublisher(),
      valuesFromEnvelope: { [$0] },
      cursorFromEnvelope: { $0 },
      requestFromCursor: { cursor in Future<Result<Int, Never>, Never>({ promise in promise(.success(.success(cursor))) }).eraseToAnyPublisher() }
    )

    let valuesExpectation = expectation(description: "value")

    paginationSink.values
      .collect(5)
      .sink(receiveValue: { values in
        XCTAssertEqual(values, [
          [1],
          [1, 2],
          [1],
          [1, 2],
          [1, 2, 3],
        ])
        valuesExpectation.fulfill()
      })
      .store(in: &cancellables)

    _refresh.send(())
    _nextPage.send(())
    _refresh.send(())
    _nextPage.send(())
    _nextPage.send(())

    waitForExpectations(timeout: 1.0, handler: nil)
  }

  func testPaginationSink_RequestFailure_ShouldSendAnError() throws {
    let _refresh = PassthroughSubject<Void, Never>()
    let _nextPage = PassthroughSubject<Void, Never>()

    let paginationSink = PaginationSink<Int, TestError>.make(
      refreshTrigger: _refresh.share().eraseToAnyPublisher(),
      nextPageTrigger: _nextPage.share().eraseToAnyPublisher(),
      valuesFromEnvelope: { envelope in [envelope] },
      cursorFromEnvelope: { cursor in cursor },
      requestFromCursor: { cursor -> AnyPublisher<Result<Int, TestError>, Never> in
        let result: Result<Int, TestError> = cursor > 4
          ? .failure(.init())
          : .success(cursor)

        return Future<Result<Int, TestError>, Never>({ promise in promise(.success(result)) }).eraseToAnyPublisher()
      }
    )

    let valuesExpectation = expectation(description: "value")
    let errorExpectation = expectation(description: "error")

    paginationSink.values
      .collect(4)
      .sink(receiveValue: { values in
        XCTAssertEqual(values, [
          [1],
          [1, 2],
          [1, 2, 3],
          [1, 2, 3, 4],
        ])
        valuesExpectation.fulfill()
      })
      .store(in: &cancellables)

    paginationSink.error
      .collect(2)
      .sink(receiveValue: { errors in
        XCTAssertEqual([
          TestError(),
          TestError(),
        ], errors)
        errorExpectation.fulfill()
      })
      .store(in: &cancellables)

    _refresh.send(())
    _nextPage.send(())
    _nextPage.send(())
    _nextPage.send(())
    _nextPage.send(())
    _nextPage.send(())

    waitForExpectations(timeout: 1.0, handler: nil)
  }

  func testPaginationSink_RequestFailure_ShouldNotSendValues() throws {
    let _refresh = PassthroughSubject<Void, Never>()
    let _nextPage = PassthroughSubject<Void, Never>()

    let paginationSink = PaginationSink<Int, TestError>.make(
      refreshTrigger: _refresh.share().eraseToAnyPublisher(),
      nextPageTrigger: _nextPage.share().eraseToAnyPublisher(),
      valuesFromEnvelope: { envelope in [envelope] },
      cursorFromEnvelope: { cursor in cursor },
      requestFromCursor: { _ -> AnyPublisher<Result<Int, TestError>, Never> in
        Future<Result<Int, TestError>, Never>({ promise in promise(.success(.failure(TestError()))) }).eraseToAnyPublisher()
      }
    )

    let errorExpectation = expectation(description: "error")

    paginationSink.values
      .sink(receiveValue: { _ in
        XCTFail()
      })
      .store(in: &cancellables)

    paginationSink.error
      .sink(receiveValue: { _ in
        errorExpectation.fulfill()
      })
      .store(in: &cancellables)

    _refresh.send(())

    waitForExpectations(timeout: 1.0, handler: nil)
  }
}
