// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Aceptar
  internal static let accept = L10n.tr("Localizable", "Accept")
  /// al agregar
  internal static let adding = L10n.tr("Localizable", "adding")
  /// Error
  internal static let error = L10n.tr("Localizable", "Error")
  /// Error %@ tu película como favorita
  internal static func errorYourMovieAsFavorite(_ p1: Any) -> String {
    return L10n.tr("Localizable", "Error %@ your movie as favorite", String(describing: p1))
  }
  /// al quitar
  internal static let removing = L10n.tr("Localizable", "removing")
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
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
