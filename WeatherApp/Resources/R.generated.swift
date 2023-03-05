//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import RswiftResources
import UIKit

private class BundleFinder {}
let R = _R(bundle: Bundle(for: BundleFinder.self))

struct _R {
  let bundle: Foundation.Bundle
  var color: color { .init(bundle: bundle) }
  var image: image { .init(bundle: bundle) }
  var info: info { .init(bundle: bundle) }
  var storyboard: storyboard { .init(bundle: bundle) }

  func color(bundle: Foundation.Bundle) -> color {
    .init(bundle: bundle)
  }
  func image(bundle: Foundation.Bundle) -> image {
    .init(bundle: bundle)
  }
  func info(bundle: Foundation.Bundle) -> info {
    .init(bundle: bundle)
  }
  func storyboard(bundle: Foundation.Bundle) -> storyboard {
    .init(bundle: bundle)
  }
  func validate() throws {
    try self.storyboard.validate()
  }

  struct project {
    let developmentRegion = "en"
  }

  /// This `_R.color` struct is generated, and contains static references to 3 colors.
  struct color {
    let bundle: Foundation.Bundle

    /// Color `AccentColor`.
    var accentColor: RswiftResources.ColorResource { .init(name: "AccentColor", path: [], bundle: bundle) }

    /// Color `mainColour1`.
    var mainColour1: RswiftResources.ColorResource { .init(name: "mainColour1", path: [], bundle: bundle) }

    /// Color `mainColour2`.
    var mainColour2: RswiftResources.ColorResource { .init(name: "mainColour2", path: [], bundle: bundle) }
  }

  /// This `_R.image` struct is generated, and contains static references to 25 images.
  struct image {
    let bundle: Foundation.Bundle

    /// Image `ic_back`.
    var ic_back: RswiftResources.ImageResource { .init(name: "ic_back", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_humidity`.
    var ic_humidity: RswiftResources.ImageResource { .init(name: "ic_humidity", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_my_location`.
    var ic_my_location: RswiftResources.ImageResource { .init(name: "ic_my_location", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_place`.
    var ic_place: RswiftResources.ImageResource { .init(name: "ic_place", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_search`.
    var ic_search: RswiftResources.ImageResource { .init(name: "ic_search", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_temp`.
    var ic_temp: RswiftResources.ImageResource { .init(name: "ic_temp", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_white_day_bright`.
    var ic_white_day_bright: RswiftResources.ImageResource { .init(name: "ic_white_day_bright", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_white_day_cloudy`.
    var ic_white_day_cloudy: RswiftResources.ImageResource { .init(name: "ic_white_day_cloudy", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_white_day_rain`.
    var ic_white_day_rain: RswiftResources.ImageResource { .init(name: "ic_white_day_rain", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_white_day_shower`.
    var ic_white_day_shower: RswiftResources.ImageResource { .init(name: "ic_white_day_shower", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_white_day_thunder`.
    var ic_white_day_thunder: RswiftResources.ImageResource { .init(name: "ic_white_day_thunder", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_white_night_bright`.
    var ic_white_night_bright: RswiftResources.ImageResource { .init(name: "ic_white_night_bright", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_white_night_cloudy`.
    var ic_white_night_cloudy: RswiftResources.ImageResource { .init(name: "ic_white_night_cloudy", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_white_night_rain`.
    var ic_white_night_rain: RswiftResources.ImageResource { .init(name: "ic_white_night_rain", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_white_night_shower`.
    var ic_white_night_shower: RswiftResources.ImageResource { .init(name: "ic_white_night_shower", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_white_night_thunder`.
    var ic_white_night_thunder: RswiftResources.ImageResource { .init(name: "ic_white_night_thunder", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_wind`.
    var ic_wind: RswiftResources.ImageResource { .init(name: "ic_wind", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `icon_wind_e`.
    var icon_wind_e: RswiftResources.ImageResource { .init(name: "icon_wind_e", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `icon_wind_n`.
    var icon_wind_n: RswiftResources.ImageResource { .init(name: "icon_wind_n", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `icon_wind_ne`.
    var icon_wind_ne: RswiftResources.ImageResource { .init(name: "icon_wind_ne", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `icon_wind_s`.
    var icon_wind_s: RswiftResources.ImageResource { .init(name: "icon_wind_s", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `icon_wind_se`.
    var icon_wind_se: RswiftResources.ImageResource { .init(name: "icon_wind_se", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `icon_wind_w`.
    var icon_wind_w: RswiftResources.ImageResource { .init(name: "icon_wind_w", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `icon_wind_wn`.
    var icon_wind_wn: RswiftResources.ImageResource { .init(name: "icon_wind_wn", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `icon_wind_ws`.
    var icon_wind_ws: RswiftResources.ImageResource { .init(name: "icon_wind_ws", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
  }

  /// This `_R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    let bundle: Foundation.Bundle
    var uiApplicationSceneManifest: uiApplicationSceneManifest { .init(bundle: bundle) }

    func uiApplicationSceneManifest(bundle: Foundation.Bundle) -> uiApplicationSceneManifest {
      .init(bundle: bundle)
    }

    struct uiApplicationSceneManifest {
      let bundle: Foundation.Bundle

      let uiApplicationSupportsMultipleScenes: Bool = false

      var _key: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest"], key: "_key") ?? "UIApplicationSceneManifest" }
      var uiSceneConfigurations: uiSceneConfigurations { .init(bundle: bundle) }

      func uiSceneConfigurations(bundle: Foundation.Bundle) -> uiSceneConfigurations {
        .init(bundle: bundle)
      }

      struct uiSceneConfigurations {
        let bundle: Foundation.Bundle
        var _key: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations"], key: "_key") ?? "UISceneConfigurations" }
        var uiWindowSceneSessionRoleApplication: uiWindowSceneSessionRoleApplication { .init(bundle: bundle) }

        func uiWindowSceneSessionRoleApplication(bundle: Foundation.Bundle) -> uiWindowSceneSessionRoleApplication {
          .init(bundle: bundle)
        }

        struct uiWindowSceneSessionRoleApplication {
          let bundle: Foundation.Bundle
          var defaultConfiguration: defaultConfiguration { .init(bundle: bundle) }

          func defaultConfiguration(bundle: Foundation.Bundle) -> defaultConfiguration {
            .init(bundle: bundle)
          }

          struct defaultConfiguration {
            let bundle: Foundation.Bundle
            var uiSceneConfigurationName: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneConfigurationName") ?? "Default Configuration" }
            var uiSceneDelegateClassName: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate" }
          }
        }
      }
    }
  }

  /// This `_R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    let bundle: Foundation.Bundle
    var launchScreen: launchScreen { .init(bundle: bundle) }

    func launchScreen(bundle: Foundation.Bundle) -> launchScreen {
      .init(bundle: bundle)
    }
    func validate() throws {
      try self.launchScreen.validate()
    }


    /// Storyboard `LaunchScreen`.
    struct launchScreen: RswiftResources.StoryboardReference, RswiftResources.InitialControllerContainer {
      typealias InitialController = UIKit.UIViewController

      let bundle: Foundation.Bundle

      let name = "LaunchScreen"
      func validate() throws {

      }
    }
  }
}