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
    // MARK: Default
    public init(_ source: Int24) {
        _value = source._value
    }
    
    public init(_truncatingBits bits: UInt) {
        let truncatedBits = Int32(bits & UInt(Int24.maskInt))
//        self.value = (truncatedBits & Int24.signedMaskInt) != 0 ? (truncatedBits | ~Int24.signedMaskInt) : truncatedBits
        self.value = (truncatedBits ^ Int24.signedMaskInt) - Int24.signedMaskInt
    }
    
    // MARK: Bit pattern
    public init(bitPattern source: UInt24) {
        _value = Int32(bitPattern: source._value)
    }
    
    // MARK: Initialisers for literal types.
    //i.e. let a: Int24 = 123456
    // or  let a: Int24 = -3.1415926
    public init(integerLiteral source: IntegerLiteralType) {
        precondition(
            source >= Int24.minInt && source <= Int24.maxInt,
            "\(source) is outside the representable range of Int24 (\(Int24.min)...\(Int24.max))."
        )
        self.value = Int32(source)
    }
    
    public init(floatLiteral source: FloatLiteralType) {
        self.init(source) // Call the `init<T: FixedWidthInteger>` initializer.
    }

    // MARK: Initialisers for FixedWidthInteger
    public init<T: FixedWidthInteger>(_ source: T) {
        precondition(
            source >= Int24.minInt && source <= Int24.maxInt,
            "\(source) is outside the representable range of Int24 (\(Int24.min)...\(Int24.max))."
        )
        self.value = Int32(source)
    }
    
    // MARK: Initialisers for BinaryInteger
    public init<T: BinaryInteger>(_ source: T) {
        precondition(
            source >= Int24.minInt && source <= Int24.maxInt,
            "\(source) is outside the representable range of Int24 (\(Int24.min)...\(Int24.max))."
        )
        self.value = Int32(source)
    }
    
    public init?<T>(exactly source: T) where T: BinaryInteger {
        guard source >= Int24.minInt && source <= Int24.maxInt else { return nil }
        self.value = Int32(source)
    }
    
    public init<T>(truncatingIfNeeded source: T) where T: BinaryInteger {
        // Mask to get the lower 24 bits
        let masked = Int32(source & T(Int24.maskInt))
        
        // Adjust for signed range
        self.value = masked > Int24.maxInt ? masked - Int32(Int24.maskInt + 1) : masked
    }
    
    public init<T>(clamping source: T) where T: BinaryInteger {
        let clampedValue: Int32
        if source < T(Int24.minInt) {
            clampedValue = Int24.minInt
        } else if source > T(Int24.maxInt) {
            clampedValue = Int24.maxInt
        } else {
            clampedValue = Int32(source)
        }
        self.value = clampedValue
    }
    
    // MARK: Initialisers for BinaryFloatingPoint
    public init<T: BinaryFloatingPoint>(_ source: T) {
        let roundedValue = Int32(source.rounded())
        precondition(
            roundedValue >= Int24.minInt && roundedValue <= Int24.maxInt,
            "\(roundedValue) is outside the representable range of Int24 (\(Int24.min)...\(Int24.max))."
        )
        self.value = roundedValue
    }
    
    public init?<T>(exactly source: T) where T: BinaryFloatingPoint {
        guard let integerValue = Int32(exactly: source),
              integerValue >= Int24.minInt && integerValue <= Int24.maxInt else {
            return nil
        }
        self.value = integerValue
    }
}
