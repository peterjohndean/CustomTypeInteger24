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

extension UInt24 {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.value)
    }
    
    public func addingReportingOverflow(_ rhs: UInt24) -> (partialValue: UInt24, overflow: Bool) {
        let result = (self.value &+ rhs.value) & UInt24.maskInt
        let overflow = self.value > UInt24.maxInt - rhs.value
        return (UInt24(result), overflow)
    }
    
    public func subtractingReportingOverflow(_ rhs: UInt24) -> (partialValue: UInt24, overflow: Bool) {
        let result = (self.value &- rhs.value) & UInt24.maskInt
        let overflow = self.value < rhs.value
        return (UInt24(result), overflow)
    }
    
    public func multipliedReportingOverflow(by rhs: UInt24) -> (partialValue: UInt24, overflow: Bool) {
        let result = UInt64(self.value) * UInt64(rhs.value)
        guard result <= UInt24.maxInt else {
            return (UInt24(0), true)  // Overflow
        }
        return (UInt24(result), false)
    }
    
    public func dividedReportingOverflow(by rhs: UInt24) -> (partialValue: UInt24, overflow: Bool) {
        /*
         In unsigned arithmetic, the division operation cannot produce a result larger than the dividend.
         Therefore, as long as the divisor is non-zero, the operation will never overflow, even when constrained to 24 bits.
         */
        guard rhs != 0 else {
            return (UInt24(0), true)  // Division by zero
        }
        let result = self.value / rhs.value
        return (UInt24(result), false)
    }
    
    public func remainderReportingOverflow(dividingBy rhs: UInt24) -> (partialValue: UInt24, overflow: Bool) {
        /*
         In unsigned arithmetic, the division operation cannot produce a result larger than the dividend.
         Therefore, as long as the divisor is non-zero, the operation will never overflow, even when constrained to 24 bits.
         */
        guard rhs != 0 else {
            return (UInt24(0), true)  // Division by zero
        }
        let result = self.value % rhs.value
        return (UInt24(result), false)  // No overflow for remainder
    }
    
    public func dividingFullWidth(_ dividend: (high: UInt24, low: UInt24.Magnitude)) -> (quotient: UInt24, remainder: UInt24) {
        let fullValue = (UInt64(dividend.high.value) << UInt24.bitWidth) | UInt64(dividend.low)
        let divisor = UInt64(self.value)
        
        let quotient = fullValue / divisor
        let remainder = fullValue % divisor
        
        guard quotient <= UInt24.maxInt else {
            fatalError("Overflow occurred during full-width (quotient) division (\(quotient))")
        }
        guard remainder <= UInt24.maxInt else {
            fatalError("Overflow occurred during remainder calculation (\(remainder))")
        }
        
        return (UInt24(quotient), UInt24(remainder))
    }

}
