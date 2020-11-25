import AppFramework
import Combine
import TestSupport
import TheMovieDatabaseApi
import XCTest

final class SelectGenresViewModelTests: XCTestCase {
  func testDefaultSelectGenresViewModel() {
    assertSelectGenresViewModel(
      metadata: .stub(genres: [
        .stub(id: 0),
        .stub(id: 1),
      ]),
      commands: { input in
        input.selectedGenre.send(.stubNotSelected(id: 1))
        input.selectedGenre.send(.stubNotSelected(id: 0))
        input.selectedGenre.send(.stubSelected(id: 1))
        input.clear.send(())
      },
      assertions: [
        [.stubNotSelected(id: 0), .stubNotSelected(id: 1)],
        [.stubNotSelected(id: 0), .stubSelected(id: 1)],
        [.stubSelected(id: 0), .stubSelected(id: 1)],
        [.stubSelected(id: 0), .stubNotSelected(id: 1)],
        [.stubNotSelected(id: 0), .stubNotSelected(id: 1)],
      ]
    )
  }
}

private struct SelectGenresViewModelTestsInput {
  let clear = PassthroughSubject<Void, Never>()
  let selectedGenre = PassthroughSubject<GenreItem, Never>()
}

private func assertSelectGenresViewModel(
  file: StaticString = #file,
  line: UInt = #line,
  metadata: MetaData,
  commands: @escaping (SelectGenresViewModelTestsInput) -> Void,
  assertions: [[GenreItem]]
) {
  var cancellables = Set<AnyCancellable>()
  let metadata = CurrentValueSubject<MetaData, Never>(metadata)
  let currentSelectedGenres = CurrentValueSubject<Set<Genre>, Never>(.init())

  let viewModel = SelectGenresViewModel.default(
    metadata: metadata.eraseToAnyPublisher(),
    currentSelectedGenres: currentSelectedGenres
  )

  let input = SelectGenresViewModelTestsInput()

  let output = viewModel.transform(
    .init(
      clear: input.clear.eraseToAnyPublisher(),
      selectedGenre: input.selectedGenre.eraseToAnyPublisher()
    )
  )

  cancellables.formUnion(output.cancellables)

  assertPublisherEvents(
    file: file,
    line: line,
    publisher: output.values,
    trigger: {
      commands(input)
    },
    assertions: assertions
  )
}
