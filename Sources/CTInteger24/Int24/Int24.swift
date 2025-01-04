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
public struct Int24 {
    // Place to hold our 24-bit value. We use the Swift.Int32 to help us out.
    private var _value: Int32 = 0
    
    public internal(set) var value: Int32 {
        get {
            // Ensure the returned Int32 is properly representing our value
            return (self._value & Int24.bit24MaskSigned != 0) ? (self._value | ~Int24.bit24Mask) : self._value
        }
        set {
            self._value = newValue & Int24.bit24Mask
        }
    }
    
    // TODO: These will need to eventually become public static var min: Self to be compliant.
    // Define our bitMasks
    public static var bit24Mask: Int32 { 0x00FF_FFFF }
    public static var bit24MaskSigned: Int32 { 0x0080_0000 }
    
    // Define our min/max values
    public static var min: Int32 { -8_388_608 }     // 2^23
    public static var max: Int32 { 8_388_607 }      // 2^23 - 1

}
