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

extension UInt24: BinaryInteger {
    
    public typealias Words = [UInt]
    
    public init?<T>(exactly source: T) where T : BinaryFloatingPoint {
        guard let integerValue = UInt32(exactly: source),
              integerValue >= Self.minInt && integerValue <= Self.maxInt else {
            return nil
        }
        self.value = integerValue
    }
    
    public init<T>(_ source: T) where T : BinaryInteger {
        precondition(
            source >= Self.minInt && source <= Self.maxInt,
            "\(source) is outside the representable range of UInt24 (\(UInt24.minInt)...\(UInt24.maxInt))."
        )
        self.init(truncatingIfNeeded: source)
    }
    
    public init<T>(truncatingIfNeeded source: T) where T : BinaryInteger {
        guard source >= Self.minInt && source <= Self.maxInt else {
            self.value = UInt32(source & T(Self.maskInt))
            return
        }
        self.value = UInt32(source)
    }
    
    public init<T>(clamping source: T) where T : BinaryInteger {
        debugPrint(#function, source)
        let clampedValue: UInt32
        if source < T(Self.minInt) {
            clampedValue = Self.minInt
        } else if source > T(Self.maxInt) {
            clampedValue = Self.maxInt
        } else {
            clampedValue = UInt32(source)
        }
        self.value = clampedValue
    }
    
    public static var isSigned: Bool { return false }
    
    public var bitWidth: Int { return 24 }
    
    public var words: Words { [UInt(self.value)] }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.value)
    }
    
    public var trailingZeroBitCount: Int {
        return self._value == 0 ? 24 : self._value.trailingZeroBitCount
    }
    
    public static func <<= <RHS>(lhs: inout Self, rhs: RHS) where RHS : BinaryInteger {
        lhs = Self(lhs.value << UInt32(rhs))
    }
    
    public static func >>= <RHS>(lhs: inout Self, rhs: RHS) where RHS : BinaryInteger {
        lhs = Self(lhs.value >> UInt32(rhs))
    }
    
    public static prefix func ~(x: Self) -> Self {
        return Self(~x.value & Self.maskInt)
    }
    
    public static func /(lhs: Self, rhs: Self) -> Self {
        Self(lhs.value / rhs.value)
    }
    
    public static func %(lhs: Self, rhs: Self) -> Self {
        Self(lhs.value % rhs.value)
    }
    
    public static func /=(lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }
    
    public static func %=(lhs: inout Self, rhs: Self) {
        lhs = lhs % rhs
    }
    
    public static func &=(lhs: inout Self, rhs: Self) {
        lhs = Self(lhs.value & rhs.value)
    }
    
    public static func |=(lhs: inout Self, rhs: Self) {
        lhs = Self(lhs.value | rhs.value)
    }
    
    public static func ^= (lhs: inout Self, rhs: Self) {
        lhs = Self(lhs.value ^ rhs.value)
    }
}
