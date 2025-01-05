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

extension UInt24: FixedWidthInteger, UnsignedInteger {
    
    public static var max: UInt24 { Self(maxInt) }
    public static var min: UInt24 { Self(minInt) }
    public static var bitWidth: Int { 24 }
    
    public init(_truncatingBits bits: UInt) {
        self.init(truncatingIfNeeded: bits)
    }
    
    public func addingReportingOverflow(_ rhs: Self) -> (partialValue: Self, overflow: Bool) {
        let result = self.value + rhs.value
        guard result >= Self.minInt && result <= Self.maxInt else {
            return (Self(0), true)  // Overflow
        }
        return (Self(result), false)
    }
    
    public func subtractingReportingOverflow(_ rhs: Self) -> (partialValue: Self, overflow: Bool) {
        let result = self.value - rhs.value
        guard result >= Self.minInt && result <= Self.maxInt else {
            return (Self(0), true)  // Overflow
        }
        return (Self(result), false)
    }
    
    public func multipliedReportingOverflow(by rhs: Self) -> (partialValue: Self, overflow: Bool) {
        let fullResult = self.value * rhs.value
        let truncatedResult = fullResult & Self.maskInt
        let overflow = fullResult > Self.maxInt
        return (Self(truncatedResult), overflow)
    }
    
    public func dividedReportingOverflow(by rhs: Self) -> (partialValue: Self, overflow: Bool) {
        guard rhs != 0 else {
            return (Self(0), true)  // Division by zero
        }
        let result = self.value / rhs.value
        guard result >= Self.minInt && result <= Self.maxInt else {
            return (Self(0), true)  // Overflow
        }
        return (Self(result), false)
    }
    
    public func remainderReportingOverflow(dividingBy rhs: Self) -> (partialValue: Self, overflow: Bool) {
        guard rhs != 0 else {
            return (Self(0), true)  // Division by zero
        }
        let result = self.value % rhs.value
        return (Self(result), false)  // No overflow for remainder
    }
    
    public func dividingFullWidth(_ dividend: (high: Self, low: Self.Magnitude)) -> (quotient: Self, remainder: Self) {
        let fullValue = (UInt64(dividend.high.value) << 32) | UInt64(dividend.low)
        let divisor = UInt64(self.value)
        
        let quotient = fullValue / divisor
        let remainder = fullValue % divisor
        
        guard quotient >= Self.minInt && quotient <= Self.maxInt else {
            fatalError("Overflow occurred during full-width division")
        }
        
        return (Self(quotient), Self(remainder))
    }

    public var nonzeroBitCount: Int {
        return self._value.nonzeroBitCount
    }

    public var leadingZeroBitCount: Int {
        return self._value.leadingZeroBitCount - 8
    }

    public var byteSwapped: Self {
        let byte1 = UInt8(self._value & 0xFF)
        let byte2 = UInt8((self._value >> 8) & 0xFF)
        let byte3 = UInt8((self._value >> 16) & 0xFF)
        let swappedValue = Int32(byte1) << 16 | Int32(byte2) << 8 | Int32(byte3)
        return Self(swappedValue)
    }
}
