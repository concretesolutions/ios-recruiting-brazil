import AppFramework
import Combine

public extension MovieViewModel {
  static func stub(
    movie: Movie = .stub(),
    transform _: (MovieViewModel.Input) -> MovieViewModel.Output = { _ in MovieViewModel.Output.mock() }
  ) -> MovieViewModel {
    MovieViewModel.default(movie: movie, repo: .mock())
  }
}

public extension MovieViewModel.Output {
  static func mock(
    like: AnyPublisher<Bool, Never> = Empty<Bool, Never>(completeImmediately: false).eraseToAnyPublisher()
  ) -> MovieViewModel.Output {
    MovieViewModel.Output(
      like: like
    )
  }
}
