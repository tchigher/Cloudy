// Copyright (c) 2020 Nomad5. All rights reserved.

import Foundation
import GameController

extension GCExtendedGamepad {

    /// Constant static id
    static var id: String {
        "Xbox Wireless Controller (STANDARD GAMEPAD Vendor: 045e Product: 02fd)"
    }

    var pressedKeys: String? {
        guard let buttonOptions = buttonOptions,
              let buttonHome = buttonHome,
              let leftThumbstickButton = leftThumbstickButton,
              let rightThumbstickButton = rightThumbstickButton else {
            return "error"
        }
        var pressedString = ""
        if abs(leftThumbstick.xAxis.value) > 0.01 { pressedString += "leftThumbstick.xAxis: \(leftThumbstick.xAxis.value), " }
        if abs(leftThumbstick.yAxis.value) > 0.01 { pressedString += "leftThumbstick.yAxis: \(leftThumbstick.yAxis.value), " }
        if abs(leftThumbstickButton.value) > 0.01 { pressedString += "leftThumbstickButton: \(leftThumbstickButton.value), " }
        if abs(rightThumbstick.xAxis.value) > 0.01 { pressedString += "rightThumbstick.xAxis: \(rightThumbstick.xAxis.value), " }
        if abs(rightThumbstick.yAxis.value) > 0.01 { pressedString += "rightThumbstick.xAxis: \(rightThumbstick.yAxis.value), " }
        if abs(rightThumbstickButton.value) > 0.01 { pressedString += "rightThumbstickButton.value: \(rightThumbstickButton.value), " }
        return !pressedString.isEmpty ? pressedString : nil
    }

    func toJson() -> String? {
        guard let buttonOptions = buttonOptions,
              let buttonHome = buttonHome,
              let leftThumbstickButton = leftThumbstickButton,
              let rightThumbstickButton = rightThumbstickButton else {
            return nil
        }
        return Controller(
                axes: [
                    Double(leftThumbstick.xAxis.value),
                    Double(-1.0 * leftThumbstick.yAxis.value),
                    Double(rightThumbstick.xAxis.value),
                    Double(-1.0 * rightThumbstick.yAxis.value)
                ],
                buttons: [
                    Controller.Button(pressed: buttonA.isPressed, value: Double(abs(buttonA.value))),
                    Controller.Button(pressed: buttonB.isPressed, value: Double(abs(buttonB.value))),
                    Controller.Button(pressed: buttonX.isPressed, value: Double(abs(buttonX.value))),
                    Controller.Button(pressed: buttonY.isPressed, value: Double(abs(buttonY.value))),
                    Controller.Button(pressed: leftShoulder.isPressed, value: Double(abs(leftShoulder.value))),
                    Controller.Button(pressed: rightShoulder.isPressed, value: Double(abs(rightShoulder.value))),
                    Controller.Button(pressed: leftTrigger.isPressed, value: Double(abs(leftTrigger.value))),
                    Controller.Button(pressed: rightTrigger.isPressed, value: Double(abs(rightTrigger.value))),
                    Controller.Button(pressed: buttonOptions.isPressed, value: Double(abs(buttonOptions.value))),
                    Controller.Button(pressed: buttonMenu.isPressed, value: Double(abs(buttonMenu.value))),
                    Controller.Button(pressed: leftThumbstickButton.isPressed, value: Double(abs(leftThumbstickButton.value))),
                    Controller.Button(pressed: rightThumbstickButton.isPressed, value: Double(abs(rightThumbstickButton.value))),
                    Controller.Button(pressed: dpad.up.isPressed, value: Double(abs(dpad.up.value))),
                    Controller.Button(pressed: dpad.down.isPressed, value: Double(abs(dpad.down.value))),
                    Controller.Button(pressed: dpad.left.isPressed, value: Double(abs(dpad.left.value))),
                    Controller.Button(pressed: dpad.right.isPressed, value: Double(abs(dpad.right.value))),
                    Controller.Button(pressed: buttonHome.isPressed, value: Double(abs(buttonHome.value))),
                ])
                .jsonString
    }
}