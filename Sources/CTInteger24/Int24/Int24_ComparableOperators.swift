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

// MARK: Comparable with Int24
extension Int24 {
    // MARK: Minimum required
    public static func == (lhs: Int24, rhs: Int24) -> Bool {
        lhs.value == rhs.value
    }
    
    public static func < (lhs: Int24, rhs: Int24) -> Bool {
        lhs.value < rhs.value
    }
}

// MARK: Comparable with UInt24
extension Int24 {
    // This ensures numeric literals like 0 are explicitly handled.
    public static func == (lhs: Int24, rhs: Int) -> Bool {
        lhs.value == rhs
    }
    
    // This ensures numeric literals like 0 are explicitly handled.
    public static func == (lhs: Int24, rhs: UInt) -> Bool {
        lhs.value == Int(rhs)
    }
    
    public static func != (lhs: Int24, rhs: UInt24) -> Bool {
        lhs.value != rhs.value
    }
    
    public static func == (lhs: Int24, rhs: UInt24) -> Bool {
        lhs.value == Int(rhs.value)
    }
    
    public static func <= (lhs: Int24, rhs: UInt24) -> Bool {
        lhs.value <= rhs.value
    }
    
    public static func < (lhs: Int24, rhs: UInt24) -> Bool {
        lhs.value < rhs.value
    }
    
    public static func >= (lhs: Int24, rhs: UInt24) -> Bool {
        lhs.value >= rhs.value
    }
    
    public static func > (lhs: Int24, rhs: UInt24) -> Bool {
        lhs.value > rhs.value
    }
}

// MARK: Comparable with BinaryInteger
extension Int24 {
    // MARK: Int24 to Any BinaryInteger (e.g., Int, UInt, etc.)
    public static func >(lhs: Int24, rhs: some BinaryInteger) -> Bool {
        return lhs.value > rhs
    }
    
    public static func <(lhs: Int24, rhs: some BinaryInteger) -> Bool {
        return lhs.value < rhs
    }
    
    public static func >=(lhs: Int24, rhs: some BinaryInteger) -> Bool {
        return lhs.value >= rhs
    }
    
    public static func <=(lhs: Int24, rhs: some BinaryInteger) -> Bool {
        return lhs.value <= rhs
    }
    
    public static func ==<T: BinaryInteger>(lhs: Int24, rhs: T) -> Bool {
        return lhs.value == rhs
    }
    
    public static func !=(lhs: Int24, rhs: some BinaryInteger) -> Bool {
        return lhs.value != rhs
    }
    
    // MARK: Any BinaryInteger (e.g., Int, UInt, etc.) to Int24
    public static func >(lhs: some BinaryInteger, rhs: Int24) -> Bool {
        return lhs > rhs.value    }
    
    public static func <(lhs: some BinaryInteger, rhs: Int24) -> Bool {
        return lhs < rhs.value    }
    
    public static func >=(lhs: some BinaryInteger, rhs: Int24) -> Bool {
        return lhs >= rhs.value
    }
    
    public static func <=(lhs: some BinaryInteger, rhs: Int24) -> Bool {
        return lhs <= rhs.value
    }
    
    public static func ==(lhs: some BinaryInteger, rhs: Int24) -> Bool {
        return lhs == rhs.value
    }
    
    public static func !=(lhs: some BinaryInteger, rhs: Int24) -> Bool {
        return lhs != rhs.value
    }
}

// MARK: Comparable with BinaryFloatingPoint
extension Int24 {
    // MARK: Int24 to Any BinaryFloatingPoint (e.g., Float16, Float32, etc.)
    public static func ><T: BinaryFloatingPoint>(lhs: Int24, rhs: T) -> Bool {
        return T(lhs.value) > rhs
    }
    
    public static func <<T: BinaryFloatingPoint>(lhs: Int24, rhs: T) -> Bool {
        return T(lhs.value) < rhs
    }
    
    public static func >=<T: BinaryFloatingPoint>(lhs: Int24, rhs: T) -> Bool {
        return T(lhs.value) >= rhs
    }
    
    public static func <=<T: BinaryFloatingPoint>(lhs: Int24, rhs: T) -> Bool {
        return T(lhs.value) <= rhs
    }
    
    public static func ==<T: BinaryFloatingPoint>(lhs: Int24, rhs: T) -> Bool {
        return T(lhs.value) == rhs
    }
    
    public static func !=<T: BinaryFloatingPoint>(lhs: Int24, rhs: T) -> Bool {
        return T(lhs.value) != rhs
    }
    
    // MARK: BinaryFloatingPoint (e.g., Float16, Float32, etc.) to Int24
    public static func ><T: BinaryFloatingPoint>(lhs: T, rhs: Int24) -> Bool {
        return lhs > T(rhs.value)    }
    
    public static func <<T: BinaryFloatingPoint>(lhs: T, rhs: Int24) -> Bool {
        return lhs < T(rhs.value)    }
    
    public static func >=<T: BinaryFloatingPoint>(lhs: T, rhs: Int24) -> Bool {
        return lhs >= T(rhs.value)
    }
    
    public static func <=<T: BinaryFloatingPoint>(lhs: T, rhs: Int24) -> Bool {
        return lhs <= T(rhs.value)
    }
    
    public static func ==<T: BinaryFloatingPoint>(lhs: T, rhs: Int24) -> Bool {
        return lhs == T(rhs.value)
    }
    
    public static func !=<T: BinaryFloatingPoint>(lhs: T, rhs: Int24) -> Bool {
        return lhs != T(rhs.value)
    }
}
