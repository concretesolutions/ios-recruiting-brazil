import Combine
import os.log
import UIKit

public class FilterCoordinator {
  private let navigationController: UINavigationController
  private let metadata: AnyPublisher<MetaData, Never>
  private let genresFilter: CurrentValueSubject<Set<Genre>, Never>
  private let dateFilter: CurrentValueSubject<String?, Never>
  private var cancellables = Set<AnyCancellable>()

  private let _finished = PassthroughSubject<Void, Never>()
  public lazy var finished: AnyPublisher<Void, Never> = _finished.eraseToAnyPublisher()

  public init(
    navigationController: UINavigationController,
    metadata: AnyPublisher<MetaData, Never>,
    genresFilter: CurrentValueSubject<Set<Genre>, Never>,
    dateFilter: CurrentValueSubject<String?, Never>
  ) {
    self.navigationController = navigationController
    self.metadata = metadata
    self.genresFilter = genresFilter
    self.dateFilter = dateFilter
    os_log("[FilterCoordinator] init", log: generalLog, type: .debug)
  }

  public func start() {
    let currentSelectedGenres = CurrentValueSubject<Set<Genre>, Never>(genresFilter.value)

    let viewController = FilterViewController(
      viewModel: .default(
        currentSelectedGenres: currentSelectedGenres,
        dateFilter: dateFilter,
        genresFilter: genresFilter
      )
    )

    viewController.presentGenres
      .sink(receiveValue: { [weak self] in
        guard let self = self else { return }
        self.goToSelectGenres(currentSelectedGenres: currentSelectedGenres)
      })
      .store(in: &cancellables)

    viewController.finished
      .subscribe(_finished)
      .store(in: &cancellables)

    navigationController.pushViewController(viewController, animated: true)
  }

  private func goToSelectGenres(currentSelectedGenres: CurrentValueSubject<Set<Genre>, Never>) {
    let viewController = SelectGenresViewController(
      viewModel: .default(
        metadata: metadata,
        currentSelectedGenres: currentSelectedGenres
      )
    )
    navigationController.pushViewController(viewController, animated: true)
  }

  deinit {
    os_log("[FilterCoordinator] deinit", log: generalLog, type: .debug)
  }
}
