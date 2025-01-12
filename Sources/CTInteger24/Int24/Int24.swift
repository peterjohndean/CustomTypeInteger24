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
public struct Int24:
    AdditiveArithmetic,
        BinaryInteger,
        Comparable,
        CustomStringConvertible,
        ExpressibleByFloatLiteral,
        ExpressibleByIntegerLiteral,
        FixedWidthInteger,
        Numeric,
    SignedInteger {
    // Place to hold our 24-bit value. We use the Swift.Int32 to help us out.
    // With our getter / setter
    internal var _value: Int32 // = 0
    public internal(set) var value: Int32 {
        get {
            // Ensure the returned Int32 is properly representing our value
//            return (_value & Int24.signedMaskInt != 0) ? (_value | ~Int24.maskInt) : _value
            // Optimized sign extension
            return (_value ^ Int24.signedMaskInt) - Int24.signedMaskInt
        }
        set {
            _value = newValue & Int24.maskInt
        }
    }
    
    // Raw 24 bit value.
    public var valueRaw: Int32 { _value }

    // TODO: These will need to eventually become public static var min: Self to be compliant.
    // Define our bitMasks
    @inline(__always) public static let maskInt: Int32 = 0x00FF_FFFF
    @inline(__always) public static let signedMaskInt: Int32 = 0x0080_0000
    
    // Define our min/max values
    @inline(__always) public static let minInt: Int32 = -8_388_608    // Min: 2^23
    @inline(__always) public static let maxInt: Int32 = 8_388_607     // Max: 2^23 - 1
    
    // Adherence to Protocol Standards
    @inline(__always) public static let isSigned: Bool = true         // Signed
    @inline(__always) public static let min: Int24 = Int24(minInt)    // Minimum value
    @inline(__always) public static let max: Int24 = Int24(maxInt)    // Maximum value
    @inline(__always) public static let bitWidth: Int = 24            // 24-bits
}
