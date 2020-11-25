import Combine

public struct PaginationSink<Value, Err: Swift.Error> {
  /// A `Publisher` that returns true if a first page request is being made.
  public let isRefreshing: AnyPublisher<Bool, Never>
  /// A `Publisher` that returns true if a request to the next page is being made.
  public let isLoadingNextPage: AnyPublisher<Bool, Never>
  /// An `Publisher` with a list of all the items loaded since the first page.
  public let values: AnyPublisher<[Value], Never>
  /// An `Observable` that triggers when an error occurs during the request. The sequence should never fail.
  public let error: AnyPublisher<Err, Never>

  private init(isRefreshing: AnyPublisher<Bool, Never>,
               isLoadingNextPage: AnyPublisher<Bool, Never>,
               values: AnyPublisher<[Value], Never>,
               error: AnyPublisher<Err, Never>)
  {
    self.isRefreshing = isRefreshing
    self.isLoadingNextPage = isLoadingNextPage
    self.values = values
    self.error = error
  }

  /// Creates a PaginationSink from UI triggers and request-related mappers
  ///
  /// - Generics:
  ///     - **Value**: The type of the item we're paginating, i.e. the model of a row in a table.
  ///     - **Envelope**: The Response / Container / Envelope type expected from the API call.
  ///     - **Error**: The `Error` type that can return from the API call.
  ///
  /// - Prameters:
  ///     - refreshTrigger: The publisher that will trigger the refresh, and the first request of all items.
  ///     - nextPageTrigger: The publisher that will trigger the fetch of the next page of items.
  ///     - valuesFromEnvelope: A function that unwraps the values from an `Envelope`.
  ///     - cursorFromEnvelope: A function that unwraps the page from an `Envelope`.
  ///     - requestFromEnvelope: A function that gets the page number and returns the result of the request as a `Publisher`.
  ///
  /// - Returns: An object with `Observable` sequences that reflects the current state of the pagination's feedback loop
  public static func make<Value: Equatable, Envelope, Err: Swift.Error>(
    refreshTrigger: AnyPublisher<Void, Never>,
    nextPageTrigger: AnyPublisher<Void, Never>,
    valuesFromEnvelope: @escaping (Envelope) -> [Value],
    cursorFromEnvelope: @escaping (Envelope) -> Int,
    requestFromCursor: @escaping (Int) -> AnyPublisher<Result<Envelope, Err>, Never>
  ) -> PaginationSink<Value, Err> {
    var cursor = 1

    let _isRefreshing = CurrentValueSubject<Bool, Never>(false)
    let _isLoadingNextPage = CurrentValueSubject<Bool, Never>(false)

    let _error = PassthroughSubject<Err, Never>()

    let values = refreshTrigger
      .map { _ -> AnyPublisher<[Value], Never> in
        cursor = 1

        return nextPageTrigger
          .prepend(())
          .map { _ -> AnyPublisher<Result<Envelope, Err>, Never> in
            // TODO: Track
            let activityToTrack = cursor == 1
              ? _isRefreshing
              : _isLoadingNextPage
            activityToTrack.send(true)
            return requestFromCursor(cursor)
              .map { value in
                activityToTrack.send(false)
                return value
              }
              .eraseToAnyPublisher()
          }
          .switchToLatest()
          .map { result -> [Value] in
            switch result {
            case let .success(envelope):
              let nextCursor = cursorFromEnvelope(envelope) + 1
              cursor = nextCursor
              return valuesFromEnvelope(envelope)
            case let .failure(error):
              _error.send(error)
              return [Value]()
            }
          }
          .filter { values in values.count > 0 }
          .scan([Value](), +)
          .eraseToAnyPublisher()
      }
      .switchToLatest()

    return PaginationSink<Value, Err>(
      isRefreshing: _isRefreshing.share().eraseToAnyPublisher(),
      isLoadingNextPage: _isLoadingNextPage.share().eraseToAnyPublisher(),
      values: values.share().eraseToAnyPublisher(),
      error: _error.share().eraseToAnyPublisher()
    )
  }
}
