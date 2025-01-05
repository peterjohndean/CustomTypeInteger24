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

extension Int24: FixedWidthInteger, SignedInteger {
    
    public func addingReportingOverflow(_ rhs: Int24) -> (partialValue: Int24, overflow: Bool) {
        let result = self.value + rhs.value
        guard result >= Int24.minInt && result <= Int24.maxInt else {
            return (Self(0), true)  // Overflow
        }
        return (Self(result), false)
    }
    
    public func subtractingReportingOverflow(_ rhs: Int24) -> (partialValue: Int24, overflow: Bool) {
        let result = self.value - rhs.value
        guard result >= Int24.minInt && result <= Int24.maxInt else {
            return (Self(0), true)  // Overflow
        }
        return (Self(result), false)
    }

    public func multipliedReportingOverflow(by rhs: Int24) -> (partialValue: Int24, overflow: Bool) {
        let fullResult = self.value * rhs.value
        let truncatedResult = fullResult & Int24.maskInt
        let overflow = fullResult > Int24.maxInt
        return (Self(truncatedResult), overflow)
    }

    public func dividedReportingOverflow(by rhs: Int24) -> (partialValue: Int24, overflow: Bool) {
        guard rhs != 0 else {
            return (Self(0), true)  // Division by zero
        }
        let result = self.value / rhs.value
        guard result >= Int24.minInt && result <= Int24.maxInt else {
            return (Self(0), true)  // Overflow
        }
        return (Self(result), false)
    }

    public func remainderReportingOverflow(dividingBy rhs: Int24) -> (partialValue: Int24, overflow: Bool) {
        guard rhs != 0 else {
            return (Self(0), true)  // Division by zero
        }
        let result = self.value % rhs.value
        return (Self(result), false)  // No overflow for remainder
    }

    public func dividingFullWidth(_ dividend: (high: Int24, low: Int24.Magnitude)) -> (quotient: Int24, remainder: Int24) {
        let fullValue = (Int64(dividend.high.value) << 32) | Int64(dividend.low)
        let divisor = Int64(self.value)
        
        let quotient = fullValue / divisor
        let remainder = fullValue % divisor
        
        guard quotient >= Int24.minInt && quotient <= Int24.maxInt else {
            fatalError("Overflow occurred during full-width division")
        }
        
        return (Self(quotient), Self(remainder))
    }

    public var nonzeroBitCount: Int {
        return self._value.nonzeroBitCount
    }

    public var leadingZeroBitCount: Int {
        // if negative, then 0 is the count.
        // else, leadingZeroBitCount - 8 -> (Int32.bitWidth - Int24.bitWidth)
        return (self._value & Self.signedMaskInt) != 0 ? 0 : self._value.leadingZeroBitCount - 8
    }

    public var byteSwapped: Self {
        let byte1 = UInt8(self._value & 0xFF)
        let byte2 = UInt8((self._value >> 8) & 0xFF)
        let byte3 = UInt8((self._value >> 16) & 0xFF)
        let swappedValue = Int32(byte1) << 16 | Int32(byte2) << 8 | Int32(byte3)
        return Self(swappedValue)
    }
}
