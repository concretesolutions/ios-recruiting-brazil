// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Global {
    internal enum Action {
      /// Ok
      internal static let ok = L10n.tr("Localizable", "global.action.ok")
    }

    internal enum Title {
      /// Error
      internal static let error = L10n.tr("Localizable", "global.title.error")
    }
  }

  internal enum Screen {
    internal enum Favorites {
      /// Favorites
      internal static let title = L10n.tr("Localizable", "screen.favorites.title")
      /// Unfavorite
      internal static let unfavorite = L10n.tr("Localizable", "screen.favorites.unfavorite")
      internal enum Filter {
        /// Date
        internal static let date = L10n.tr("Localizable", "screen.favorites.filter.date")
        /// Genres
        internal static let genres = L10n.tr("Localizable", "screen.favorites.filter.genres")
        /// Filter
        internal static let title = L10n.tr("Localizable", "screen.favorites.filter.title")
        internal enum Action {
          /// Apply
          internal static let apply = L10n.tr("Localizable", "screen.favorites.filter.action.apply")
          /// Clear
          internal static let clear = L10n.tr("Localizable", "screen.favorites.filter.action.clear")
        }

        internal enum InvalidYearError {
          /// The year should be greater than or equal to 1874
          internal static let greaterThan1874 = L10n.tr("Localizable", "screen.favorites.filter.invalid_year_error.greater_than_1874")
          /// Only numbers are allowed
          internal static let onlyNumbers = L10n.tr("Localizable", "screen.favorites.filter.invalid_year_error.only_numbers")
          /// Invalid year
          internal static let title = L10n.tr("Localizable", "screen.favorites.filter.invalid_year_error.title")
        }
      }
    }

    internal enum MovieDetails {
      /// Movie
      internal static let title = L10n.tr("Localizable", "screen.movie_details.title")
    }

    internal enum Movies {
      /// Your search returned 0 results
      internal static let emptyResultsMessage = L10n.tr("Localizable", "screen.movies.empty_results_message")
      /// An error ocurred, please try again
      internal static let errorMessage = L10n.tr("Localizable", "screen.movies.error_message")
      /// Movies
      internal static let title = L10n.tr("Localizable", "screen.movies.title")
    }
  }
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private enum BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
      return Bundle.module
    #else
      return Bundle(for: BundleToken.self)
    #endif
  }()
}

// swiftlint:enable convenience_type
