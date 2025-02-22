//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map(Locale.init)
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 8 colors.
  struct color {
    /// Color `Felix1 Color`.
    static let felix1Color = Rswift.ColorResource(bundle: R.hostingBundle, name: "Felix1 Color")
    /// Color `Felix2 Color`.
    static let felix2Color = Rswift.ColorResource(bundle: R.hostingBundle, name: "Felix2 Color")
    /// Color `Lancing Color`.
    static let lancingColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "Lancing Color")
    /// Color `Primary Color`.
    static let primaryColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "Primary Color")
    /// Color `Primary Text Color`.
    static let primaryTextColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "Primary Text Color")
    /// Color `Secondary Text Color`.
    static let secondaryTextColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "Secondary Text Color")
    /// Color `Selection Color`.
    static let selectionColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "Selection Color")
    /// Color `Separator Color`.
    static let separatorColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "Separator Color")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "Felix1 Color", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func felix1Color(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.felix1Color, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "Felix2 Color", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func felix2Color(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.felix2Color, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "Lancing Color", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func lancingColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.lancingColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "Primary Color", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func primaryColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.primaryColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "Primary Text Color", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func primaryTextColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.primaryTextColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "Secondary Text Color", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func secondaryTextColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.secondaryTextColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "Selection Color", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func selectionColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.selectionColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "Separator Color", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func separatorColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.separatorColor, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `GoogleService-Info.plist`.
    static let googleServiceInfoPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "GoogleService-Info", pathExtension: "plist")

    /// `bundle.url(forResource: "GoogleService-Info", withExtension: "plist")`
    static func googleServiceInfoPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.googleServiceInfoPlist
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 13 images.
  struct image {
    /// Image `github-btn`.
    static let githubBtn = Rswift.ImageResource(bundle: R.hostingBundle, name: "github-btn")
    /// Image `github`.
    static let github = Rswift.ImageResource(bundle: R.hostingBundle, name: "github")
    /// Image `info`.
    static let info = Rswift.ImageResource(bundle: R.hostingBundle, name: "info")
    /// Image `logo`.
    static let logo = Rswift.ImageResource(bundle: R.hostingBundle, name: "logo")
    /// Image `map`.
    static let map = Rswift.ImageResource(bundle: R.hostingBundle, name: "map")
    /// Image `schedule`.
    static let schedule = Rswift.ImageResource(bundle: R.hostingBundle, name: "schedule")
    /// Image `speaker`.
    static let speaker = Rswift.ImageResource(bundle: R.hostingBundle, name: "speaker")
    /// Image `star_filled`.
    static let star_filled = Rswift.ImageResource(bundle: R.hostingBundle, name: "star_filled")
    /// Image `star`.
    static let star = Rswift.ImageResource(bundle: R.hostingBundle, name: "star")
    /// Image `twitter-btn`.
    static let twitterBtn = Rswift.ImageResource(bundle: R.hostingBundle, name: "twitter-btn")
    /// Image `twitter`.
    static let twitter = Rswift.ImageResource(bundle: R.hostingBundle, name: "twitter")
    /// Image `website-btn`.
    static let websiteBtn = Rswift.ImageResource(bundle: R.hostingBundle, name: "website-btn")
    /// Image `website`.
    static let website = Rswift.ImageResource(bundle: R.hostingBundle, name: "website")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "github", bundle: ..., traitCollection: ...)`
    static func github(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.github, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "github-btn", bundle: ..., traitCollection: ...)`
    static func githubBtn(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.githubBtn, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "info", bundle: ..., traitCollection: ...)`
    static func info(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.info, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "logo", bundle: ..., traitCollection: ...)`
    static func logo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.logo, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "map", bundle: ..., traitCollection: ...)`
    static func map(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.map, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "schedule", bundle: ..., traitCollection: ...)`
    static func schedule(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.schedule, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "speaker", bundle: ..., traitCollection: ...)`
    static func speaker(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.speaker, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "star", bundle: ..., traitCollection: ...)`
    static func star(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.star, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "star_filled", bundle: ..., traitCollection: ...)`
    static func star_filled(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.star_filled, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "twitter", bundle: ..., traitCollection: ...)`
    static func twitter(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.twitter, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "twitter-btn", bundle: ..., traitCollection: ...)`
    static func twitterBtn(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.twitterBtn, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "website", bundle: ..., traitCollection: ...)`
    static func website(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.website, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "website-btn", bundle: ..., traitCollection: ...)`
    static func websiteBtn(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.websiteBtn, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 6 nibs.
  struct nib {
    /// Nib `SessionTableViewCell`.
    static let sessionTableViewCell = _R.nib._SessionTableViewCell()
    /// Nib `SessionTableViewHeader`.
    static let sessionTableViewHeader = _R.nib._SessionTableViewHeader()
    /// Nib `SessionTableViewLegendCell`.
    static let sessionTableViewLegendCell = _R.nib._SessionTableViewLegendCell()
    /// Nib `SessionsDetailsViewController`.
    static let sessionsDetailsViewController = _R.nib._SessionsDetailsViewController()
    /// Nib `SpeakerTableViewCell`.
    static let speakerTableViewCell = _R.nib._SpeakerTableViewCell()
    /// Nib `SpeakersDetailsViewController`.
    static let speakersDetailsViewController = _R.nib._SpeakersDetailsViewController()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SessionTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.sessionTableViewCell) instead")
    static func sessionTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.sessionTableViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SessionTableViewHeader", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.sessionTableViewHeader) instead")
    static func sessionTableViewHeader(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.sessionTableViewHeader)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SessionTableViewLegendCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.sessionTableViewLegendCell) instead")
    static func sessionTableViewLegendCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.sessionTableViewLegendCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SessionsDetailsViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.sessionsDetailsViewController) instead")
    static func sessionsDetailsViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.sessionsDetailsViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SpeakerTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.speakerTableViewCell) instead")
    static func speakerTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.speakerTableViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SpeakersDetailsViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.speakersDetailsViewController) instead")
    static func speakersDetailsViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.speakersDetailsViewController)
    }
    #endif

    static func sessionTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SessionTableViewCell? {
      return R.nib.sessionTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SessionTableViewCell
    }

    static func sessionTableViewHeader(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SessionTableViewHeader? {
      return R.nib.sessionTableViewHeader.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SessionTableViewHeader
    }

    static func sessionTableViewLegendCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SessionTableViewLegendCell? {
      return R.nib.sessionTableViewLegendCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SessionTableViewLegendCell
    }

    static func sessionsDetailsViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.sessionsDetailsViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    static func speakerTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SpeakerTableViewCell? {
      return R.nib.speakerTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SpeakerTableViewCell
    }

    static func speakersDetailsViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.speakersDetailsViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 2 localization tables.
  struct string {
    /// This `R.string.infoPlist` struct is generated, and contains static references to 1 localization keys.
    struct infoPlist {
      /// en translation: To add a session to the calendar we need you to grant access to it
      ///
      /// Locales: en
      static let nsCalendarsUsageDescription = Rswift.StringResource(key: "NSCalendarsUsageDescription", tableName: "InfoPlist", bundle: R.hostingBundle, locales: ["en"], comment: nil)

      /// en translation: To add a session to the calendar we need you to grant access to it
      ///
      /// Locales: en
      static func nsCalendarsUsageDescription(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("NSCalendarsUsageDescription", tableName: "InfoPlist", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "InfoPlist", preferredLanguages: preferredLanguages) else {
          return "NSCalendarsUsageDescription"
        }

        return NSLocalizedString("NSCalendarsUsageDescription", tableName: "InfoPlist", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    /// This `R.string.localizable` struct is generated, and contains static references to 11 localization keys.
    struct localizable {
      /// en translation: Apple Maps
      ///
      /// Locales: en
      static let apple_maps = Rswift.StringResource(key: "apple_maps", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Code of Conduct
      ///
      /// Locales: en
      static let codeofconduct = Rswift.StringResource(key: "codeofconduct", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Contact Us
      ///
      /// Locales: en
      static let contact_us = Rswift.StringResource(key: "contact_us", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Dismiss
      ///
      /// Locales: en
      static let dismiss = Rswift.StringResource(key: "dismiss", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Google Maps
      ///
      /// Locales: en
      static let google_maps = Rswift.StringResource(key: "google_maps", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Locations
      ///
      /// Locales: en
      static let locations = Rswift.StringResource(key: "locations", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Mobile Era Team
      ///
      /// Locales: en
      static let mobileera_team = Rswift.StringResource(key: "mobileera_team", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Room
      ///
      /// Locales: en
      static let room = Rswift.StringResource(key: "room", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Schedule
      ///
      /// Locales: en
      static let schedule = Rswift.StringResource(key: "schedule", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Speakers
      ///
      /// Locales: en
      static let speakers = Rswift.StringResource(key: "speakers", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Sponsors
      ///
      /// Locales: en
      static let sponsors = Rswift.StringResource(key: "sponsors", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)

      /// en translation: Apple Maps
      ///
      /// Locales: en
      static func apple_maps(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("apple_maps", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "apple_maps"
        }

        return NSLocalizedString("apple_maps", bundle: bundle, comment: "")
      }

      /// en translation: Code of Conduct
      ///
      /// Locales: en
      static func codeofconduct(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("codeofconduct", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "codeofconduct"
        }

        return NSLocalizedString("codeofconduct", bundle: bundle, comment: "")
      }

      /// en translation: Contact Us
      ///
      /// Locales: en
      static func contact_us(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("contact_us", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "contact_us"
        }

        return NSLocalizedString("contact_us", bundle: bundle, comment: "")
      }

      /// en translation: Dismiss
      ///
      /// Locales: en
      static func dismiss(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("dismiss", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "dismiss"
        }

        return NSLocalizedString("dismiss", bundle: bundle, comment: "")
      }

      /// en translation: Google Maps
      ///
      /// Locales: en
      static func google_maps(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("google_maps", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "google_maps"
        }

        return NSLocalizedString("google_maps", bundle: bundle, comment: "")
      }

      /// en translation: Locations
      ///
      /// Locales: en
      static func locations(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("locations", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "locations"
        }

        return NSLocalizedString("locations", bundle: bundle, comment: "")
      }

      /// en translation: Mobile Era Team
      ///
      /// Locales: en
      static func mobileera_team(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("mobileera_team", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "mobileera_team"
        }

        return NSLocalizedString("mobileera_team", bundle: bundle, comment: "")
      }

      /// en translation: Room
      ///
      /// Locales: en
      static func room(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("room", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "room"
        }

        return NSLocalizedString("room", bundle: bundle, comment: "")
      }

      /// en translation: Schedule
      ///
      /// Locales: en
      static func schedule(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("schedule", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "schedule"
        }

        return NSLocalizedString("schedule", bundle: bundle, comment: "")
      }

      /// en translation: Speakers
      ///
      /// Locales: en
      static func speakers(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("speakers", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "speakers"
        }

        return NSLocalizedString("speakers", bundle: bundle, comment: "")
      }

      /// en translation: Sponsors
      ///
      /// Locales: en
      static func sponsors(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("sponsors", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "sponsors"
        }

        return NSLocalizedString("sponsors", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try nib.validate()
    #endif
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _SessionTableViewCell.validate()
      try _SpeakerTableViewCell.validate()
      try _SpeakersDetailsViewController.validate()
    }

    struct _SessionTableViewCell: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "SessionTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SessionTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SessionTableViewCell
      }

      static func validate() throws {
        if UIKit.UIImage(named: "star", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'star' is used in nib 'SessionTableViewCell', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "Primary Color", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'Primary Color' is used in storyboard 'SessionTableViewCell', but couldn't be loaded.") }
          if UIKit.UIColor(named: "Primary Text Color", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'Primary Text Color' is used in storyboard 'SessionTableViewCell', but couldn't be loaded.") }
          if UIKit.UIColor(named: "Secondary Text Color", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'Secondary Text Color' is used in storyboard 'SessionTableViewCell', but couldn't be loaded.") }
          if UIKit.UIColor(named: "Selection Color", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'Selection Color' is used in storyboard 'SessionTableViewCell', but couldn't be loaded.") }
          if UIKit.UIColor(named: "Separator Color", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'Separator Color' is used in storyboard 'SessionTableViewCell', but couldn't be loaded.") }
        }
      }

      fileprivate init() {}
    }

    struct _SessionTableViewHeader: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "SessionTableViewHeader"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SessionTableViewHeader? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SessionTableViewHeader
      }

      fileprivate init() {}
    }

    struct _SessionTableViewLegendCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "SessionTableViewLegendCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SessionTableViewLegendCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SessionTableViewLegendCell
      }

      fileprivate init() {}
    }

    struct _SessionsDetailsViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "SessionsDetailsViewController"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      fileprivate init() {}
    }

    struct _SpeakerTableViewCell: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "SpeakerTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SpeakerTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SpeakerTableViewCell
      }

      static func validate() throws {
        if UIKit.UIImage(named: "github", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'github' is used in nib 'SpeakerTableViewCell', but couldn't be loaded.") }
        if UIKit.UIImage(named: "twitter", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'twitter' is used in nib 'SpeakerTableViewCell', but couldn't be loaded.") }
        if UIKit.UIImage(named: "website", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'website' is used in nib 'SpeakerTableViewCell', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "Primary Color", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'Primary Color' is used in storyboard 'SpeakerTableViewCell', but couldn't be loaded.") }
          if UIKit.UIColor(named: "Primary Text Color", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'Primary Text Color' is used in storyboard 'SpeakerTableViewCell', but couldn't be loaded.") }
        }
      }

      fileprivate init() {}
    }

    struct _SpeakersDetailsViewController: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "SpeakersDetailsViewController"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      static func validate() throws {
        if UIKit.UIImage(named: "github-btn", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'github-btn' is used in nib 'SpeakersDetailsViewController', but couldn't be loaded.") }
        if UIKit.UIImage(named: "twitter-btn", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'twitter-btn' is used in nib 'SpeakersDetailsViewController', but couldn't be loaded.") }
        if UIKit.UIImage(named: "website-btn", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'website-btn' is used in nib 'SpeakersDetailsViewController', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "Primary Color", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'Primary Color' is used in storyboard 'SpeakersDetailsViewController', but couldn't be loaded.") }
          if UIKit.UIColor(named: "Primary Text Color", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'Primary Text Color' is used in storyboard 'SpeakersDetailsViewController', but couldn't be loaded.") }
          if UIKit.UIColor(named: "Secondary Text Color", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'Secondary Text Color' is used in storyboard 'SpeakersDetailsViewController', but couldn't be loaded.") }
        }
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if UIKit.UIImage(named: "logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'logo' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "Primary Color", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'Primary Color' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
