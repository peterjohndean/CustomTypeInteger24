/*
 * This file is part of Swift Custom Type Integer 24 (Int24/UInt24).
 *
 * Copyright (C) 2025 Peter Dean
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

@frozen
public struct UInt24 {
    // Place to hold our 24-bit value. We use the Swift.UInt32 to help us out.
    private var _value: UInt32 = 0
    
    public internal(set) var value: UInt32 {
        get {
            return self._value
        }
        set {
            self._value = newValue & UInt24.bit24Mask
        }
    }
    
    // TODO: These will need to eventually become public static var min: Self to be compliant.
    // Define our bitMasks
    public static var bit24Mask: UInt32 { 0x00FF_FFFF }
    
    // Define our min/max values
    public static let minInt: UInt32 = 0            // 0
    public static let maxInt: UInt32 = 16_777_215   // 2^24 - 1

    // Default initialisers
    public init() {
        _value = 0
    }
    
    public init(_ value: Self) {
        _value = value._value
    }
}
