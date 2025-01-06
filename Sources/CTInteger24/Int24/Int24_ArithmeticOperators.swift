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
    
    public static func -(lhs: Int24, rhs: Int24) -> Int24 {
        let result = lhs.subtractingReportingOverflow(rhs)
        guard !result.overflow else {
            fatalError("\(#function) Overflow in subtraction (\(lhs.value) - \(rhs.value))")
        }
        return result.partialValue
    }
    
    public static func +(lhs: Int24, rhs: Int24) -> Int24 {
        let result = lhs.addingReportingOverflow(rhs)
        guard !result.overflow else {
            fatalError("\(#function) Overflow in addition (\(lhs.value) + \(rhs.value))")
        }
        return result.partialValue
    }
    
    public static func *(lhs: Int24, rhs: Int24) -> Int24 {
        let result = lhs.multipliedReportingOverflow(by: rhs)
        guard !result.overflow else {
            fatalError("\(#function) Overflow in multiplication (\(lhs.value) * \(rhs.value))")
        }
        return result.partialValue
    }
    
    public static func *=(lhs: inout Int24, rhs: Int24) {
        let result = lhs.multipliedReportingOverflow(by: rhs)
        guard !result.overflow else {
            fatalError("\(#function) Overflow in multiplication (\(lhs.value) *= \(rhs.value))")
        }
        lhs = result.partialValue
    }
    
    public static func /(lhs: Int24, rhs: Int24) -> Int24 {
        let result = lhs.dividedReportingOverflow(by: rhs)
        guard !result.overflow else {
            fatalError("\(#function) Overflow in division (\(lhs.value) / \(rhs.value))")
        }
        return result.partialValue
    }
    
    public static func %(lhs: Int24, rhs: Int24) -> Int24 {
        let result = lhs.remainderReportingOverflow(dividingBy: rhs)
        guard !result.overflow else {
            fatalError("Overflow in division (\(lhs.value) % \(rhs.value))")
        }
        return result.partialValue
    }

    public static func /=(lhs: inout Int24, rhs: Int24) {
        let result = lhs.dividedReportingOverflow(by: rhs)
        guard !result.overflow else {
            fatalError("\(#function) Overflow in division (\(lhs.value) /= \(rhs.value))")
        }
        lhs = result.partialValue
    }

    public static func %=(lhs: inout Int24, rhs: Int24) {
        let result = lhs.remainderReportingOverflow(dividingBy: rhs)
        guard !result.overflow else {
            fatalError("Overflow in division (\(lhs.value) %= \(rhs.value))")
        }
        lhs = result.partialValue
    }
    
    // MARK: Bitwise Operators
    public static func <<= <RHS>(lhs: inout Int24, rhs: RHS) where RHS: BinaryInteger {
        precondition(rhs >= 0 && rhs < Int24.bitWidth, "Shift amount out of bounds")
        lhs = lhs << Int32(rhs)
    }
    
    public static func >>= <RHS>(lhs: inout Int24, rhs: RHS) where RHS: BinaryInteger {
        precondition(rhs >= 0 && rhs < Int24.bitWidth, "Shift amount out of bounds")
        lhs = lhs >> Int32(rhs)
    }
    
    public static func << <RHS>(lhs: Int24, rhs: RHS) -> Int24 where RHS : BinaryInteger {
        guard rhs != 0 else { return lhs }
        let shifted = Int32(lhs) << Int32(rhs)
        return Int24(shifted & Int24.maskInt)
    }
    
    public static func >> <RHS>(lhs: Int24, rhs: RHS) -> Int24 where RHS : BinaryInteger {
        guard rhs != 0 else { return lhs }
        let shifted = Int32(lhs) >> Int32(rhs)
        return Int24(shifted & Int24.maskInt)
    }
    
    public static prefix func ~(x: Int24) -> Int24 {
        return Int24(~x.value)
    }
    
    public static func &(lhs: Int24, rhs: Int24) -> Int24 {
        return Int24(lhs.value & rhs.value)
    }
    
    public static func &=(lhs: inout Int24, rhs: Int24) {
        lhs = lhs & rhs
    }
    
    public static func |(lhs: Int24, rhs: Int24) -> Int24 {
        return Int24(lhs.value | rhs.value)
    }
    
    public static func |=(lhs: inout Int24, rhs: Int24) {
        lhs = lhs | rhs
    }
    
    public static func ^(lhs: Int24, rhs: Int24) -> Int24 {
        return Int24(lhs.value ^ rhs.value)
    }
    
    public static func ^=(lhs: inout Int24, rhs: Int24) {
        lhs = lhs ^ rhs
    }
}
