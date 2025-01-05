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
#if DEBUG
extension FixedWidthInteger {
    /// Converts an Integer to a formatted binary (radix 2) string.
    public var toFormattedBinaryString: String {
        
        var chars = [Character]()
        for i in (0..<self.bitWidth).reversed() {
            chars.append(((self >> i) & 0x1 == 1) ? "1" : "0")
            if i % 4 == 0 && i != 0 {
                chars.append("_")
            }
        }
        
        return String(chars)
    }
    
    /// Converts an Integer to a formatted hexadecimal (radix 16) string.
    public var toFormattedHexString: String {
        
        let hexDigits: [Character] = Array("0123456789ABCDEF")
        var chars = [Character]()
        for i in (0..<self.bitWidth / 4).reversed() {
            let nibble = (self >> (i * 4)) & 0xF  // Shift and mask
            chars.append(hexDigits[Int(nibble)])
            if i % 4 == 0 && i != 0 {
                chars.append("_")
            }
        }
        
        return String(chars)
    }
}
#endif

@frozen
public struct Int24: AdditiveArithmetic, BinaryInteger, Comparable, CustomStringConvertible, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral, FixedWidthInteger, Numeric, SignedInteger {
    // Place to hold our 24-bit value. We use the Swift.Int32 to help us out.
    // With our getter / setter
    internal var _value: Int32 = 0
    public internal(set) var value: Int32 {
        get {
            // Ensure the returned Int32 is properly representing our value
            return (_value & Int24.signedMaskInt != 0) ? (_value | ~Int24.maskInt) : _value
        }
        set {
            _value = newValue & Int24.maskInt
        }
    }
    
    // Raw 24 bit value.
    public var valueRaw: Int32 { _value }
    
#if DEBUG
    public var hex: String {
        return _value.toFormattedHexString
    }
    public var bin: String {
        return _value.toFormattedBinaryString
    }
#endif
    
    // TODO: These will need to eventually become public static var min: Self to be compliant.
    // Define our bitMasks
    public static let maskInt: Int32 = 0x00FF_FFFF
    public static let signedMaskInt: Int32 = 0x0080_0000
    
    // Define our min/max values
    public static let minInt: Int32 = -8_388_608    // Min: 2^23
    public static let maxInt: Int32 = 8_388_607     // Max: 2^23 - 1
    
    // Adherence to Protocol Standards
    public static let isSigned: Bool = true         // Signed
    public static let min: Int24 = Int24(minInt)    // Minimum value
    public static let max: Int24 = Int24(maxInt)    // Maximum value
    public static let bitWidth: Int = 24            // 24-bits

}
