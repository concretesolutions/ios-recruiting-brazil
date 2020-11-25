import Combine
import XCTest

func assertPublisherEvents<T: Equatable>(
  file: StaticString = #file,
  line: UInt = #line,
  publisher: AnyPublisher<T, Never>,
  trigger: @escaping () -> Void,
  assertions: [T]
) {
  var cancellables = Set<AnyCancellable>()

  let subject = PassthroughSubject<T, Never>()
  let completeExpectation = XCTestExpectation()
  let valueExpectation = XCTestExpectation()

  publisher.subscribe(subject)
    .store(in: &cancellables)

  var events = [T]()

  subject.collect()
    .receive(on: DispatchQueue.main)
    .sink(receiveCompletion: { _ in
      completeExpectation.fulfill()
    }, receiveValue: { allEvents in
      events = allEvents
      valueExpectation.fulfill()
    })
    .store(in: &cancellables)

  trigger()
  subject.send(completion: .finished)

  let waiter = XCTWaiter()
  waiter.wait(for: [completeExpectation, valueExpectation], timeout: 1.0)
  if waiter.fulfilledExpectations.count == 0 {
    XCTFail("Expectations were not fulfilled")
  }

  XCTAssertEqual(events, assertions, file: file, line: line)
}
