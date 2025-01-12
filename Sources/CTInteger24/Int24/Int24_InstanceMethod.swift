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

extension Int24 {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.value)
    }
    
    public func addingReportingOverflow(_ rhs: Int24) -> (partialValue: Int24, overflow: Bool) {
        let result = (self.value &+ rhs.value) & Int24.maskInt
        let overflow =
        (/* Before */ (self.value ^ rhs.value) & Int24.signedMaskInt == 0) &&    // Same sign operands
        (/* After */  (self.value ^ result) & Int24.signedMaskInt != 0)          // Different sign result
        return (Int24((result ^ Int24.signedMaskInt) - Int24.signedMaskInt), overflow)
    }
    
    public func subtractingReportingOverflow(_ rhs: Int24) -> (partialValue: Int24, overflow: Bool) {
        let result = (self.value &- rhs.value) & Int24.maskInt
        let overflow =
        (/* Before */ (self.value ^ rhs.value) & Int24.signedMaskInt != 0) &&   // Different sign operands
        (/* After */  (self.value ^ result) & Int24.signedMaskInt != 0)         // Different sign result
        return (Int24((result ^ Int24.signedMaskInt) - Int24.signedMaskInt), overflow)
    }
    
    public func multipliedReportingOverflow(by rhs: Int24) -> (partialValue: Int24, overflow: Bool) {
//        let result = Int64(self.value) * Int64(rhs.value)
//        guard result >= Int24.minInt && result <= Int24.maxInt else {
//            return (Int24(0), true)  // Overflow
//        }
//        return (Int24(result), false)
        let lhs = self.value
        let rhs = rhs.value
        
        guard lhs != 0 && rhs != 0 else {
            return (Int24(0), false)    // Multiplication by zero
        }
        
        if (lhs ^ rhs) >= 0 { // Same signs
            if ((lhs > 0 && rhs > 0 && lhs > Int24.maxInt / rhs) || // Positive * Positive
                (lhs < 0 && rhs < 0 && lhs < Int24.maxInt / rhs)) { // Negative * Negative
                return (Int24(0), true) // Overflow
            }
        } else { // Opposite signs
            if ((lhs > 0 && rhs < 0 && lhs > Int24.minInt / rhs) || // Positive * Negative
                (lhs < 0 && rhs > 0 && lhs < Int24.minInt / rhs)) { // Negative * Positive
                return (Int24(0), true) // Overflow
            }
        }
        
        return (Int24((lhs * rhs)), false)
    }

    public func dividedReportingOverflow(by rhs: Int24) -> (partialValue: Int24, overflow: Bool) {
        guard rhs.value != 0 else {
            return (Int24(0), true)  // Division by zero
        }
        let result = (self.value / rhs.value) & Int24.maskInt
        let overflow = (self.value & Int24.minInt == Int24.minInt) && (rhs.value == -1) // Bitwise check for Int24.min / -1 overflow
        
        return (Int24((result ^ Int24.signedMaskInt) - Int24.signedMaskInt), overflow)
    }
    
    public func remainderReportingOverflow(dividingBy rhs: Int24) -> (partialValue: Int24, overflow: Bool) {
        /*
         For the remainder operation, you don’t need an explicit overflow check.
         Since the result is always within the bounds of 0 to rhs.value - 1 (which is always less than or equal to rhs.value),
         there is no risk of overflowing beyond Int24’s range. The only exception to handle is division by zero.
         */
        guard rhs.value != 0 else {
            return (Int24(0), true)  // Division by zero
        }
        let result = self.value % rhs.value
        let overflow = (self.value & Int24.minInt == Int24.minInt) && (rhs.value == -1)
        
        return (Int24(result), overflow)
    }
    
    public func dividingFullWidth(_ dividend: (high: Int24, low: Int24.Magnitude)) -> (quotient: Int24, remainder: Int24) {
        let fullValue = (Int64(dividend.high.value) << Int24.bitWidth) | Int64(dividend.low.value)
        let divisor = Int64(self.value)
        
        let quotient = fullValue / divisor
        let remainder = fullValue % divisor
        
        guard quotient >= Int24.minInt && quotient <= Int24.maxInt else {
            fatalError("Overflow occurred during full-width (quotient) division (\(quotient))")
        }
        guard remainder >= Int24.minInt && remainder <= Int24.maxInt else {
            fatalError("Overflow occurred during remainder calculation (\(remainder))")
        }
        
        return (Int24(quotient), Int24(remainder))
    }
}
