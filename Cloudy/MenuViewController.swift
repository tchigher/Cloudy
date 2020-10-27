// Copyright (c) 2020 Nomad5. All rights reserved.

import Foundation
import UIKit

/// Container for address bar updates
struct AddressBarInfo {
    let url:          String?
    let canGoBack:    Bool
    let canGoForward: Bool
}

/// Abstraction for controlling the menu
protocol MenuController {
    func updateAddressBar(with info: AddressBarInfo)
    func show()
}

/// View controller to handle everything on the menu screen
/// (after pressed the menu button)
class MenuViewController: UIViewController {

    /// View references
    @IBOutlet weak var userAgentTextField: UITextField!
    @IBOutlet weak var manualUserAgent:    UISwitch!
    @IBOutlet weak var automaticUserAgent: UISwitch!
    @IBOutlet weak var addressBar:         UITextField!
    @IBOutlet weak var backButton:         UIButton!
    @IBOutlet weak var forwardButton:      UIButton!
    @IBOutlet weak var buttonGeforceNow:   UIImageView!
    @IBOutlet weak var buttonStadia:       UIImageView!

    /// The controller injected to control the web
    var webController: WebController?

    /// By default hide the status bar
    override var prefersStatusBarHidden: Bool {
        true
    }

    /// View is ready to be configured
    override func viewDidLoad() {
        super.viewDidLoad()
        // tap to close
        let tap = UITapGestureRecognizer(target: self, action: #selector(onOverlayClosePressed))
        view.addGestureRecognizer(tap)
        // tap for stadia button
        let tapStadia = UITapGestureRecognizer(target: self, action: #selector(onStadiaButtonPressed))
        buttonStadia.addGestureRecognizer(tapStadia)
        // tap for geforce now button
        let tapGeforceNow = UITapGestureRecognizer(target: self, action: #selector(onGeforceNowButtonPressed))
        buttonGeforceNow.addGestureRecognizer(tapGeforceNow)
        // init
        userAgentTextField.text = UserDefaults.standard.manualUserAgent
    }
}

/// Implementing controlling protocol
extension MenuViewController: MenuController {

    /// Update address bar elements
    func updateAddressBar(with info: AddressBarInfo) {
        addressBar.text = info.url
        backButton.isEnabled = info.canGoBack
        forwardButton.isEnabled = info.canGoForward
    }

    /// Fade in
    func show() {
        view.fadeIn()
    }
}

/// UI handling extension
extension MenuViewController {

    /// Hide menu and keyboard
    func hideMenu() {
        view.fadeOut()
        addressBar.resignFirstResponder()
    }

    /// Forward
    @IBAction func onForwardPressed(_ sender: Any) {
        webController?.executeNavigation(action: .forward)
        hideMenu()
    }

    /// Go backward
    @IBAction func onBackPressed(_ sender: Any) {
        webController?.executeNavigation(action: .backward)
        hideMenu()
    }

    /// Navigate to a url
    @IBAction func onGoPressed(_ sender: Any) {
        // early exit
        guard let address = addressBar.text else { return }
        webController?.navigateTo(address: address)
        hideMenu()
    }

    /// Reload current page
    @IBAction func onReloadPressed(_ sender: Any) {
        webController?.executeNavigation(action: .reload)
        hideMenu()
    }

    /// Clear address bar pressed
    @IBAction func onClearPressed(_ sender: Any) {
        addressBar.text = ""
        addressBar.becomeFirstResponder()
    }

    /// Delete cache pressed
    @IBAction func onDeleteCachePressed(_ sender: Any) {
        webController?.clearCache()
    }

    /// Automatic user agent changed
    @IBAction func onAutomaticUserAgentSwitchChanged(_ sender: Any) {
        manualUserAgent.setOn(!automaticUserAgent.isOn, animated: true)
        UserDefaults.standard.useManualUserAgent = true
    }

    /// Manual user agent changed
    @IBAction func onManualUserAgentSwitchChanged(_ sender: Any) {
        automaticUserAgent.setOn(!manualUserAgent.isOn, animated: true)
        UserDefaults.standard.useManualUserAgent = false
    }

    /// User agent value changed
    @IBAction func onUserAgentValueChanged(_ sender: Any) {
        UserDefaults.standard.manualUserAgent = userAgentTextField.text
    }

    /// Handle click outside of any element
    @objc func onOverlayClosePressed(_ sender: Any) {
        hideMenu()
    }

    /// Handle stadia shortcut
    @objc func onStadiaButtonPressed(_ sender: Any) {
        webController?.navigateTo(address: Navigator.Config.Url.googleStadia.absoluteString)
        hideMenu()
    }

    /// Handle nvidia shortcut
    @objc func onGeforceNowButtonPressed(_ sender: Any) {
        webController?.navigateTo(address: Navigator.Config.Url.geforceNow.absoluteString)
        hideMenu()
    }
}
