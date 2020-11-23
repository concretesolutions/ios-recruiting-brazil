public struct Filter<T> {
  private let predicate: (T) -> Bool

  public init(predicate: @escaping (T) -> Bool) {
    self.predicate = predicate
  }

  public func runFilter(_ ts: [T]) -> [T] {
    ts.filter(predicate)
  }

  public func contramap<U>(_ f: @escaping (U) -> T) -> Filter<U> {
    Filter<U> { u in
      self.predicate(f(u))
    }
  }
}

public enum Filters {
  public static func movieFilter(byTitle titleSearchString: String) -> Filter<Movie> {
    let strippedString = titleSearchString.trimmingCharacters(in: .whitespaces)
    let searchItems = strippedString.components(separatedBy: " ") as [String]
    let predicates = searchItems.map(comparisonPredicateForTitle)
    let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    return Filter<Movie> { movie in
      predicate.evaluate(with: movie.title)
    }
  }
}

private func comparisonPredicateForTitle(_ searchString: String) -> NSComparisonPredicate {
  let titleExpression = NSExpression(
    block: { value, _, _ in
      value!
    },
    arguments: nil
  )
  let searchStringExpression = NSExpression(forConstantValue: searchString)

  let titleSearchComparisonPredicate = NSComparisonPredicate(
    leftExpression: titleExpression,
    rightExpression: searchStringExpression,
    modifier: .direct,
    type: .contains,
    options: [.caseInsensitive, .diacriticInsensitive]
  )

  return titleSearchComparisonPredicate
}
