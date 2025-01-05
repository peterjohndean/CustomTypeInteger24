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

extension Int24: AdditiveArithmetic, BinaryInteger {
    
    public typealias Words = [UInt]

    public static var isSigned: Bool { return true }
    
    public var bitWidth: Int { return 24 }

    public var words: Words { [UInt(abs(self.value))] }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.value)
    }
    
    public var trailingZeroBitCount: Int {
        return self._value == 0 ? 24 : self._value.trailingZeroBitCount
    }
    
    public static func -(lhs: Int24, rhs: Int24) -> Int24 {
        let result = lhs.subtractingReportingOverflow(rhs)
        guard !result.overflow else {
            fatalError("\(#function) Overflow in subtraction")
        }
        return result.partialValue
    }
    
    public static func +(lhs: Int24, rhs: Int24) -> Int24 {
        let result = lhs.addingReportingOverflow(rhs)
        guard !result.overflow else {
            fatalError("\(#function) Overflow in addition")
        }
        return result.partialValue
    }
    
    public static func <<=<RHS>(lhs: inout Int24, rhs: RHS) where RHS: BinaryInteger {
        lhs = lhs << Int32(rhs)
    }
    
    public static func >>=<RHS>(lhs: inout Int24, rhs: RHS) where RHS: BinaryInteger {
        lhs = lhs >> Int32(rhs)
    }
    
    public static prefix func ~(x: Int24) -> Int24 {
        return Int24(~x.value)
    }
    
    public static func *(lhs: Int24, rhs: Int24) -> Int24 {
        let fullResult = lhs.multipliedReportingOverflow(by: rhs)
        guard !fullResult.overflow else {
            fatalError("\(#function) Overflow in multiplication")
        }
        return fullResult.partialValue //Int24(truncatingIfNeeded: fullResult.partialValue)
    }
    
    public static func *=(lhs: inout Int24, rhs: Int24) {
        let result = lhs.multipliedReportingOverflow(by: rhs)
        guard !result.overflow else {
            fatalError("\(#function) Overflow in multiplication")
        }
        lhs = Self(result.partialValue)
    }
    
    public static func /(lhs: Int24, rhs: Int24) -> Int24 {
        let result = lhs.dividedReportingOverflow(by: rhs)
        guard !result.overflow else {
            fatalError("\(#function) Overflow in division")
        }
        return result.partialValue
    }
    
    public static func %(lhs: Int24, rhs: Int24) -> Int24 {
        let result = lhs.remainderReportingOverflow(dividingBy: rhs)
        guard !result.overflow else {
            fatalError("Overflow in division")
        }
        return result.partialValue
    }

    public static func /=(lhs: inout Int24, rhs: Int24) {
        lhs = lhs / rhs
    }

    public static func %=(lhs: inout Int24, rhs: Int24) {
        lhs = lhs % rhs
    }

    public static func &= (lhs: inout Int24, rhs: Int24) {
        lhs._value &= rhs._value
    }
    
    public static func |=(lhs: inout Int24, rhs: Int24) {
        lhs._value |= rhs._value
    }
    
    public static func ^=(lhs: inout Int24, rhs: Int24) {
        lhs._value ^= rhs._value
    }
}
