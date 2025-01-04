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

extension Int24: Numeric {
    public typealias Magnitude = Self

    public var magnitude: Self.Magnitude {
        return Self(abs(self.value))
    }
    
    public init?<T>(exactly source: T) where T : BinaryInteger {
        guard value >= Int24.minInt && value <= Int24.maxInt else { return nil }
        self.value = Int32(value)
    }

    public static func * (lhs: Self, rhs: Self) -> Self {
        return Self(lhs.value * rhs.value)
    }

    public static func *= (lhs: inout Self, rhs: Self) {
        return lhs.value *= rhs.value
    }
}
