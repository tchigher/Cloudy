# Cloudy

[![Cloudy Server](https://img.shields.io/discord/591914197219016707.svg?label=Discord&logo=Discord&colorB=7289da&style=for-the-badge)](https://discord.gg/ku8kvE)

A cloud gaming ready browser for iOS.

![](Media/cloudy.gif)

# Supported Features

- Right now opens stadia path automatically on first startup
- Supports Bluetooth gaming controllers
- Fullscreen support
- The following shortcuts in the address bar (just type in the following alias in order to get to the desired platform)
  - `stadia` -> opens stadia
  - `gfn` -> opens geforce now 
- If you want to go crazy, you can specify your custom user agent
- Reset all cookies and caches

# Features in development

- Fixing broken axis controls on geforce now
- The following shortcuts for the address bar
  - `boost` -> opens boosteroid
- Touch controls to imitate the mouse
- Keyboard input
- Virtual controller

# Support the development

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=79U6NVP3HMY68)

[![patreon](Media/becomePatreon.png)](https://www.patreon.com/bePatron?u=44456418)

# Ways to get the app on your device

## 1. Build it your own

Here is a quick guide on how to build the app on your own.

### Prerequisites
An Intel-based Mac running macOS Catalina 10.15.4 or later.

1. Install XCode https://apps.apple.com/de/app/xcode/id497799835?mt=12
2. Download Cloudy source code repostiory (visit https://github.com/mlostekk/Cloudy then look for a green `Code` button, hit it and select `Download ZIP`
3. Unzip the archive
4. Doubleclick `Cloudy.xcworkspace`, XCode 12 should open
5. Connect iOS device to your Mac, let it some time to be recognized
6. Select your device in XCode [`1`]
7. Go to `Cloudy` [`2`], select `Signing & Capabilities` [`3`]
8. Select your name inside `Team` [`4`] and change the `Bundle Identifier`[`4`] to something / whatever you like `com.your.favorite.villian`
9. Press run and wait until it pops up on your device
10. Have a lot of fun streaming games on iOS

![](Media/xcode.png)

## 2. Sideload an unsigned IPA

_to be written_