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

// MARK: Debugging for Int24
#if DEBUG
extension Int24 {
    public var hex: String {
        return _value.toFormattedHexString
    }
    public var bin: String {
        return _value.toFormattedBinaryString
    }
}
#endif

// MARK: Debugging for UInt24
#if DEBUG
extension UInt24 {
    public var hex: String {
        return _value.toFormattedHexString
    }
    public var bin: String {
        return _value.toFormattedBinaryString
    }
}
#endif
