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

extension UInt24 {
    // MARK: Default
    public init(_ source: UInt24) {
        debugPrint(type(of: source), source >= Int24.minInt)
        _value = source._value
    }
    
    public init(_truncatingBits bits: UInt) {
        let truncatedBits = UInt32(bits & UInt(UInt24.maskInt))
        self.value = truncatedBits
    }
    
    // MARK: Initialisers for literal types.
    //i.e. let a: UInt24 = 123456
    // or  let a: UInt24 = -3.1415926
    public init(integerLiteral source: IntegerLiteralType) {
        self.init(source) // Call the `init<T: FixedWidthInteger>` initializer.
    }
    
    public init(floatLiteral source: FloatLiteralType) {
        self.init(source) // Call the `init<T: FixedWidthInteger>` initializer.
    }

    // MARK: Initialisers for FixedWidthInteger
    public init<T: FixedWidthInteger>(_ source: T) {
        precondition(
            source >= UInt24.minInt && source <= UInt24.maxInt,
            "\(source) is outside the representable range of UInt24 (\(UInt24.min)...\(UInt24.max))."
        )
        self.value = UInt32(source)
    }
    
    // MARK: Initialisers for BinaryInteger
    public init<T: BinaryInteger>(_ source: T) {
        precondition(
            source >= UInt24.minInt && source <= UInt24.maxInt,
            "\(source) is outside the representable range of UInt24 (\(UInt24.min)...\(UInt24.max))."
        )
        self.value = UInt32(source)
    }
    
    public init?<T>(exactly source: T) where T: BinaryInteger {
        guard source >= UInt24.minInt && source <= UInt24.maxInt else { return nil }
        self.value = UInt32(source)
    }
    
    public init<T>(truncatingIfNeeded source: T) where T: BinaryInteger {
        // Mask to get the lower 24 bits
        let masked = UInt32(source & T(UInt24.maskInt))
        
        // Adjust for signed range
        self.value = masked > UInt24.maxInt ? masked - UInt32(UInt24.maskInt + 1) : masked
    }
    
    public init<T>(clamping source: T) where T: BinaryInteger {
        let clampedValue: UInt32
        if source < T(UInt24.minInt) {
            clampedValue = UInt24.minInt
        } else if source > T(UInt24.maxInt) {
            clampedValue = UInt24.maxInt
        } else {
            clampedValue = UInt32(source)
        }
        self.value = clampedValue
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
    
    public init?<T>(exactly source: T) where T: BinaryFloatingPoint {
        guard let integerValue = UInt32(exactly: source),
              integerValue >= UInt24.minInt && integerValue <= UInt24.maxInt else {
            return nil
        }
        self.value = integerValue
    }
}
