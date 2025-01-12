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
public struct UInt24:
    AdditiveArithmetic,
        BinaryInteger,
        Comparable,
        CustomStringConvertible,
        ExpressibleByFloatLiteral,
        ExpressibleByIntegerLiteral,
        FixedWidthInteger,
        Numeric,
        UnsignedInteger {
    // Place to hold our 24-bit value. We use the Swift.Int32 to help us out.
    // With our getter / setter
    internal var _value: UInt32 //= 0
    public internal(set) var value: UInt32 {
        get {
            return self._value
        }
        set {
            self._value = newValue & UInt24.maskInt
        }
    }
    
    // Raw 24 bit value.
    public var valueRaw: UInt32 { _value }

    // TODO: These will need to eventually become public static var min: Self to be compliant.
    // Define our bitMasks
    @inline(__always) public static let maskInt: UInt32 = 0x00FF_FFFF
    
    // Define our min/max values
    @inline(__always) public static let minInt: UInt32 = 0            // 0
    @inline(__always) public static let maxInt: UInt32 = 16_777_215   // 2^24 - 1
    
    // Adherence to Protocol Standards
    @inline(__always) public static let isSigned: Bool = false        // Signed
    @inline(__always) public static let min: UInt24 = UInt24(minInt)  // Minimum value
    @inline(__always) public static let max: UInt24 = UInt24(maxInt)  // Maximum value
    @inline(__always) public static let bitWidth: Int = 24            // 24-bits
}
