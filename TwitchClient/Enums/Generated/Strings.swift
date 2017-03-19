// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
enum L10n {
  /// Fetching games 👾
  case fetchingGames
  /// Fetching streams 🎬
  case fetchingStreams
  /// Twitch Top games
  case twitchTopGames
}
// swiftlint:enable type_body_length

extension L10n: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case .fetchingGames:
        return L10n.tr(key: "FetchingGames")
      case .fetchingStreams:
        return L10n.tr(key: "FetchingStreams")
      case .twitchTopGames:
        return L10n.tr(key: "TwitchTopGames")
    }
  }

  private static func tr(key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

func tr(_ key: L10n) -> String {
  return key.string
}

private final class BundleToken {}
