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

extension Int24: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    // MARK: Default
    public init(_ source: Self) {
        _value = source._value
    }
    
    // MARK: Initialisers for literal types
    public init(integerLiteral source: IntegerLiteralType) {
        self.init(source)    // let a: Int24 = 123456
    }
    
    public init(floatLiteral source: FloatLiteralType) {
        self.init(source)    // let a: Int24 = -3.1415926
    }

    // MARK: Initialisers for FixedWidthInteger
    public init<T: FixedWidthInteger>(_ source: T) {
        precondition(
            source >= Int24.minInt && source <= Int24.maxInt,
            "\(source) is outside the representable range of Int24 (\(Int24.minInt)...\(Int24.maxInt))."
        )
        self.value = Int32(source)
    }
    
    // MARK: Initialisers for BinaryFloatingPoint
    public init<T: BinaryFloatingPoint>(_ source: T) {
        let roundedValue = Int32(source.rounded())
        precondition(
            roundedValue >= Int24.minInt && roundedValue <= Int24.maxInt,
            "\(roundedValue) is outside the representable range of Int24 (\(Int24.minInt)...\(Int24.maxInt))."
        )
        self.value = roundedValue
    }
}
