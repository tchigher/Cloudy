// Copyright (c) 2020 Nomad5. All rights reserved.

import Foundation
import GameController

/// Infix operator declaration
infix operator =~: ComparisonPrecedence

/// Convenience extension
extension GCControllerButtonInput {

    /// Compare for similarity
    static func =~(lhs: GCControllerButtonInput, rhs: GCControllerButtonInput) -> Bool {
        lhs.isPressed == rhs.isPressed &&
        lhs.isTouched == rhs.isTouched &&
        lhs.value =~ rhs.value
    }

    /// Convenience creator
    var controller: Controller.Button {
        Controller.Button(pressed: isPressed, touched: isTouched, value: value)
    }
}

/// Convenience extension
extension Float {

    /// Check for similarity
    static func =~(lhs: Float, rhs: Float) -> Bool {
        abs(lhs - rhs) < 0.001
    }
}

/// Convenience extension
extension GCExtendedGamepad {

    /// Hacked pulsing
    /// TODO find a proper solution
    private static var pulse: Bool = false

    /// Check all values for similarity
    static func =~(lhs: GCExtendedGamepad, rhs: GCExtendedGamepad) -> Bool {
        guard let lhsButtonOptions = lhs.buttonOptions,
              let lhsButtonHome = lhs.buttonHome,
              let lhsLeftThumbstickButton = lhs.leftThumbstickButton,
              let lhsRightThumbstickButton = lhs.rightThumbstickButton,
              let rhsButtonOptions = rhs.buttonOptions,
              let rhsButtonHome = rhs.buttonHome,
              let rhsLeftThumbstickButton = rhs.leftThumbstickButton,
              let rhsRightThumbstickButton = rhs.rightThumbstickButton,
              lhs.leftThumbstick.xAxis.value =~ rhs.leftThumbstick.xAxis.value,
              lhs.leftThumbstick.yAxis.value =~ rhs.leftThumbstick.yAxis.value,
              lhs.rightThumbstick.xAxis.value =~ rhs.rightThumbstick.xAxis.value,
              lhs.rightThumbstick.yAxis.value =~ rhs.rightThumbstick.yAxis.value,
              lhs.buttonA =~ rhs.buttonA,
              lhs.buttonB =~ rhs.buttonB,
              lhs.buttonX =~ rhs.buttonX,
              lhs.buttonY =~ rhs.buttonY,
              lhs.leftShoulder =~ rhs.leftShoulder,
              lhs.rightShoulder =~ rhs.rightShoulder,
              lhs.leftTrigger =~ rhs.leftTrigger,
              lhs.rightTrigger =~ rhs.rightTrigger,
              lhsButtonOptions =~ rhsButtonOptions,
              lhs.buttonMenu =~ rhs.buttonMenu,
              lhsLeftThumbstickButton =~ rhsLeftThumbstickButton,
              lhsRightThumbstickButton =~ rhsRightThumbstickButton,
              lhs.dpad.up =~ rhs.dpad.up,
              lhs.dpad.down =~ rhs.dpad.down,
              lhs.dpad.left =~ rhs.dpad.left,
              lhs.dpad.right =~ rhs.dpad.right,
              lhsButtonHome =~ rhsButtonHome else {
            return false
        }
        return true
    }

    /// Constant static id
    static var id: String {
        "Xbox Wireless Controller (STANDARD GAMEPAD Vendor: 045e Product: 02fd)"
    }

    /// Convert to json
    func toJson() -> String? {
        guard let buttonOptions = buttonOptions,
              let buttonHome = buttonHome,
              let leftThumbstickButton = leftThumbstickButton,
              let rightThumbstickButton = rightThumbstickButton else {
            return nil
        }
        GCExtendedGamepad.pulse = !GCExtendedGamepad.pulse
        return Controller(
                axes: [
                    leftThumbstick.xAxis.value,
                    -1.0 * leftThumbstick.yAxis.value,
                    rightThumbstick.xAxis.value,
                    -1.0 * rightThumbstick.yAxis.value
                ],
                buttons: [
                    /*  0 */ buttonA.controller,
                    /*  1 */ buttonB.controller,
                    /*  2 */ buttonX.controller,
                    /*  3 */ buttonY.controller,
                    /*  4 */ leftShoulder.controller,
                    /*  5 */ rightShoulder.controller,
                    /*  6 */ Controller.Button(pressed: leftTrigger.isPressed, touched: leftTrigger.isTouched, value: max(leftTrigger.value - 0.002, 0) + (GCExtendedGamepad.pulse ? 0.002 : 0)),
                    /*  7 */ rightTrigger.controller,
                    /*  8 */ buttonOptions.controller,
                    /*  9 */ buttonMenu.controller,
                    /* 10 */ leftThumbstickButton.controller,
                    /* 11 */ rightThumbstickButton.controller,
                    /* 12 */ dpad.up.controller,
                    /* 13 */ dpad.down.controller,
                    /* 14 */ dpad.left.controller,
                    /* 15 */ dpad.right.controller,
                    /* 16 */ buttonHome.controller,
                ])
                .jsonString
    }
}