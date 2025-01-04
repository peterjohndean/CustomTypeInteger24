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
    // MARK: Initialisers for literal types
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)    // let a: UInt24 = 123456
    }
    
    public init(floatLiteral value: FloatLiteralType) {
        self.init(value)    // let a: UInt24 = 123.456
    }
    
    // MARK: Initialisers for FixedWidthInteger
    public init<T: FixedWidthInteger>(_ value: T) {
        precondition(
            value >= UInt24.min && value <= UInt24.max,
            "\(value) is outside the representable range of UInt24 (\(UInt24.min)...\(UInt24.max))."
        )
        self.value = UInt32(value)
    }
    
    // MARK: Initialisers for BinaryFloatingPoint
    public init<T: BinaryFloatingPoint>(_ value: T) {
        let roundedValue = UInt32(value.rounded())
        precondition(
            roundedValue >= UInt24.min && roundedValue <= UInt24.max,
            "\(roundedValue) is outside the representable range of UInt24 (\(UInt24.min)...\(UInt24.max))."
        )
        self.value = roundedValue
    }
}
