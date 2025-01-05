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

extension UInt24: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    // MARK: Default
    public init(_ source: Self) {
        _value = source._value
    }
    
    // MARK: Initialisers for literal types
    public init(integerLiteral source: IntegerLiteralType) {
        self.init(source)    // let a: UInt24 = 123456
    }
    
    public init(floatLiteral source: FloatLiteralType) {
        self.init(source)    // let a: UInt24 = 123.456
    }
    
    // MARK: Initialisers for FixedWidthInteger
    public init<T: FixedWidthInteger>(_ source: T) {
        precondition(
            source >= UInt24.minInt && source <= UInt24.maxInt,
            "\(source) is outside the representable range of UInt24 (\(UInt24.min)...\(UInt24.max))."
        )
        self.value = UInt32(source)
    }
    
    // MARK: Initialisers for BinaryFloatingPoint
    public init<T: BinaryFloatingPoint>(_ source: T) {
        let roundedValue = UInt32(source.rounded())
        precondition(
            roundedValue >= UInt24.minInt && roundedValue <= UInt24.maxInt,
            "\(roundedValue) is outside the representable range of UInt24 (\(UInt24.min)...\(UInt24.max))."
        )
        self.value = roundedValue
    }
}
