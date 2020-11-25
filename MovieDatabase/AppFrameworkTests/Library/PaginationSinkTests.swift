import AppFramework
import Combine
import Foundation
import XCTest

class PaginationSinkTests: XCTestCase {
  func testPaginationSink_NextPageTwice() throws {
    assertPaginationSink(
      valuesFromEnvelope: { [$0] },
      cursorFromEnvelope: { $0 },
      requestFromCursor: { cursor in
        Future<Result<Int, Never>, Never>({ promise in
          promise(.success(.success(cursor)))

        }).eraseToAnyPublisher()
      },
      actions: { input in
        input.refresh.send(())
        input.nextPage.send(())
        input.nextPage.send(())
      },
      assertions: [
        .isRefreshing(false),
        .isLoadingNextPage(false),
        .isRefreshing(true),
        .isRefreshing(false),
        .values([1]),
        .isLoadingNextPage(true),
        .isLoadingNextPage(false),
        .values([1, 2]),
        .isLoadingNextPage(true),
        .isLoadingNextPage(false),
        .values([1, 2, 3]),
      ]
    )
  }

  func testPaginationSink_NextPageErroring() throws {
    assertPaginationSink(
      valuesFromEnvelope: { envelope in [envelope] },
      cursorFromEnvelope: { cursor in cursor },
      requestFromCursor: { cursor -> AnyPublisher<Result<Int, TestError>, Never> in
        let result: Result<Int, TestError> = cursor > 1
          ? .failure(.init())
          : .success(cursor)

        return Future<Result<Int, TestError>, Never>({ promise in promise(.success(result)) }).eraseToAnyPublisher()
      },
      actions: { input in
        input.refresh.send(())
        input.nextPage.send(())
        input.nextPage.send(())
      },
      assertions: [
        .isRefreshing(false),
        .isLoadingNextPage(false),
        .isRefreshing(true),
        .isRefreshing(false),
        .values([1]),
        .isLoadingNextPage(true),
        .isLoadingNextPage(false),
        .error(TestError()),
        .isLoadingNextPage(true),
        .isLoadingNextPage(false),
        .error(TestError()),
      ]
    )
  }
}

private struct TestError: Error, Equatable {}

private struct PaginationSinkInput {
  let refresh = PassthroughSubject<Void, Never>()
  let nextPage = PassthroughSubject<Void, Never>()
}

private enum PaginationSinkEvent<Value: Equatable, Err: Swift.Error>: Equatable {
  static func == (lhs: PaginationSinkEvent<Value, Err>, rhs: PaginationSinkEvent<Value, Err>) -> Bool {
    switch (lhs, rhs) {
    case let (.isRefreshing(l), .isRefreshing(r)): return l == r
    case let (.isLoadingNextPage(l), .isLoadingNextPage(r)): return l == r
    case let (.values(l), .values(r)): return l == r
    case let (.error(l), .error(r)): return l.localizedDescription == r.localizedDescription
    default: return false
    }
  }

  case isRefreshing(Bool)
  case isLoadingNextPage(Bool)
  case values([Value])
  case error(Err)
}

private func assertPaginationSink<Value: Equatable, Err: Error, Envelope>(
  file: StaticString = #file,
  line: UInt = #line,
  valuesFromEnvelope: @escaping (Envelope) -> [Value],
  cursorFromEnvelope: @escaping (Envelope) -> Int,
  requestFromCursor: @escaping (Int) -> AnyPublisher<Result<Envelope, Err>, Never>,
  actions: @escaping (PaginationSinkInput) -> Void,
  assertions: [PaginationSinkEvent<Value, Err>]
) {
  let input = PaginationSinkInput()
  let paginationSink = PaginationSink<Int, Err>.make(
    refreshTrigger: input.refresh.eraseToAnyPublisher(),
    nextPageTrigger: input.nextPage.eraseToAnyPublisher(),
    valuesFromEnvelope: valuesFromEnvelope,
    cursorFromEnvelope: cursorFromEnvelope,
    requestFromCursor: requestFromCursor
  )

  let publisher = Publishers.Merge4(
    paginationSink.isRefreshing.map(PaginationSinkEvent<Value, Err>.isRefreshing),
    paginationSink.isLoadingNextPage.map(PaginationSinkEvent<Value, Err>.isLoadingNextPage),
    paginationSink.values.map(PaginationSinkEvent<Value, Err>.values),
    paginationSink.error.map(PaginationSinkEvent<Value, Err>.error)
  )
  .eraseToAnyPublisher()

  assertPublisherEvents(
    file: file,
    line: line,
    publisher: publisher,
    trigger: { actions(input) },
    assertions: assertions
  )
}
