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

extension UInt24: Numeric {
    public typealias Magnitude = Self

    public var magnitude: Self {
        return self // No need for magnitude, as it's already non-negative
    }
    
    public init?<T>(exactly source: T) where T: BinaryInteger {
        guard source >= Self.minInt && source <= Self.maxInt else { return nil }
        self.value = UInt32(source)
    }

    public static func *(lhs: Self, rhs: Self) -> Self {
        let result = Self(lhs).multipliedReportingOverflow(by: Self(rhs))
        guard !result.overflow else {
            fatalError("\(#function) Overflow in multiplication")
        }
        return Self(result.partialValue)
    }
    
    public static func *=(lhs: inout Self, rhs: Self) {
        let result = Self(lhs).multipliedReportingOverflow(by: Self(rhs))
        guard !result.overflow else {
            fatalError("\(#function) Overflow in multiplication")
        }
        lhs = Self(result.partialValue)
    }
}
