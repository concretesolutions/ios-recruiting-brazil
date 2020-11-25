import XCTest

final class FailingTest: XCTestCase {
  func testFailing() {
    XCTFail()
  }
}
