// Copyright (c) 2020 Nomad5. All rights reserved.

import Foundation

/// Model class to map navigation based on url
class Navigator {

    /// Some global constants
    struct Config {
        static let stadiaWarning                  = "https://stadia.google.com/warning/"
        static let stadiaWarningRedirectReason    = "redirect_reasons=9"
        static let googleAccountsWarning          = "deniedsigninrejected"
        static let signInString                   = "signin"

        /// Mapping from a alias to a full url
        static let aliasMapping: [String: String] = [
            "stadia": Url.googleStadia.absoluteString,
            "gfn": Url.geforceNow.absoluteString,
        ]

        struct Url {
            static let googleStadia   = URL(string: "https://stadia.google.com")!
            static let googleAccounts = URL(string: "https://accounts.google.com")!
            static let geforceNow     = URL(string: "https://play.geforcenow.com")!
            static let nvidiaRoot     = URL(string: "https://www.nvidia.com")!
        }

        struct UserAgent {
            static let chromeDesktop = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36"
        }
    }

    /// The navigation that shall be executed
    struct Navigation {
        let userAgent:    String?
        let forwardToUrl: URL?
    }

    /// The manual fixed user agent override
    var manualUserAgent:    String? {
        UserDefaults.standard.manualUserAgent
    }

    /// Wrapper around user defaults saved user agent enabled / disabled flag
    var useManualUserAgent: Bool {
        UserDefaults.standard.useManualUserAgent ?? false
    }

    /// Map navigation address
    func getNavigation(for address: String?) -> Navigation {
        // early exit
        guard let requestedUrl = address else {
            return Navigation(userAgent: manualUserAgent, forwardToUrl: nil)
        }
        // map alias
        let navigationUrl = Config.aliasMapping[requestedUrl] ?? requestedUrl
        // no automatic navigation
        if useManualUserAgent {
            return Navigation(userAgent: manualUserAgent, forwardToUrl: nil)
        }
        // error happened with stadia, navigate to it directly
        if navigationUrl.starts(with: Config.stadiaWarning) &&
           navigationUrl.reversed().starts(with: Config.stadiaWarningRedirectReason.reversed()) {
            return Navigation(userAgent: Config.UserAgent.chromeDesktop, forwardToUrl: Config.Url.googleStadia)
        }
        // google account error occurred
        if navigationUrl.starts(with: Config.Url.googleAccounts.absoluteString) &&
           navigationUrl.contains(Config.googleAccountsWarning) {
            return Navigation(userAgent: nil, forwardToUrl: Config.Url.googleAccounts)
        }
        // regular google stadia
        if navigationUrl.isEqualTo(other: Config.Url.googleStadia.absoluteString) {
            return Navigation(userAgent: Config.UserAgent.chromeDesktop, forwardToUrl: nil)
        }
        // regular geforce now
        if navigationUrl.starts(with: Config.Url.geforceNow.absoluteString) ||
           navigationUrl.starts(with: Config.Url.nvidiaRoot.absoluteString) {
            return Navigation(userAgent: Config.UserAgent.chromeDesktop, forwardToUrl: nil)
        }
        // some problem with signing
        if navigationUrl.contains(Config.signInString) {
            return Navigation(userAgent: nil, forwardToUrl: nil)
        }
        return Navigation(userAgent: manualUserAgent, forwardToUrl: nil)
    }

}
