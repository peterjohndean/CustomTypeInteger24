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

import Testing

@testable import CTInteger24

struct Int24_InitialiserTests {

    @Test("Default Initializer - Positive Number")
    func testDefaultInitializerPositive() {
        let a = Int24(123456)
        #expect(a.value == 123456, "Default initializer failed for a positive number")
    }
    
    @Test("Default Initializer - Negative Number")
    func testDefaultInitializerNegative() {
        let b = Int24(-123456)
        #expect(b.value == -123456, "Default initializer failed for a negative number")
    }
    
    @Test("Default Initializer - Zero")
    func testDefaultInitializerZero() {
        let c = Int24()
        #expect(c.value == 0, "Default initializer failed for zero")
    }

    @Test("Truncating Bits - Max Unsigned Value")
    func testTruncatingBitsMaxUnsigned() {
        let a = Int24(_truncatingBits: UInt(0xFF_FFFF))
        #expect(a.value == -1, "Truncating bits failed for max unsigned value")
    }
    
    @Test("Truncating Bits - Zero")
    func testTruncatingBitsZero() {
        let b = Int24(_truncatingBits: UInt(0))
        #expect(b.value == 0, "Truncating bits failed for zero")
    }
    
    @Test("Truncating Bits - Negative One")
    func testTruncatingBitsNegativeOne() {
        let c = Int24(_truncatingBits: UInt(0xFFFF_FFFF))
        #expect(c.value == -1, "Truncating bits failed for negative one")
    }
    
    @Test("Integer Literal - Positive")
    func testIntegerLiteralPositive() {
        let a: Int24 = 123456
        #expect(a.value == 123456, "Integer literal initializer failed for a positive value")
    }
    
    @Test("Integer Literal - Negative")
    func testIntegerLiteralNegative() {
        let b: Int24 = -123456
        #expect(b.value == -123456, "Integer literal initializer failed for a negative value")
    }
    
    @Test("Floating-Point Literal - Positive with Rounding Up")
    func testFloatingPointLiteralRoundUp() {
        let a: Int24 = 123.6
        #expect(a.value == 124, "Floating-point literal initializer failed for rounding up")
    }
    
    @Test("Floating-Point Literal - Negative with Rounding Down")
    func testFloatingPointLiteralRoundDown() {
        let b: Int24 = -123.6
        #expect(b.value == -124, "Floating-point literal initializer failed for rounding down")
    }
    
    @Test("Floating-Point Literal - Zero")
    func testFloatingPointLiteralZero() {
        let c: Int24 = 0.0
        #expect(c.value == 0, "Floating-point literal initializer failed for zero")
    }
    
    @Test("FixedWidthInteger - Int16")
    func testFixedWidthIntegerInt16() {
        let a = Int24(Int16(12345))
        #expect(a.value == 12345, "FixedWidthInteger initializer failed for Int16")
    }
    
    @Test("FixedWidthInteger - UInt8")
    func testFixedWidthIntegerUInt8() {
        let b = Int24(UInt8(255))
        #expect(b.value == 255, "FixedWidthInteger initializer failed for UInt8")
    }
    
//    @Test("FixedWidthInteger - Out-of-Range")
//    func testFixedWidthIntegerOutOfRange() {
//        #expect("FixedWidthInteger initializer didn't throw for out-of-range value") {
//            _ = Int24(Int64(Int24.maxInt) + 1)
//        }
//    }
    
    @Test("BinaryInteger - Positive")
    func testBinaryIntegerPositive() {
        let a = Int24(Int(123456))
        #expect(a.value == 123456, "BinaryInteger initializer failed for positive Int")
    }
    
    @Test("BinaryInteger - Negative")
    func testBinaryIntegerNegative() {
        let b = Int24(Int(-123456))
        #expect(b.value == -123456, "BinaryInteger initializer failed for negative Int")
    }
    
//    @Test("BinaryInteger - Out-of-Range")
//    func testBinaryIntegerOutOfRange() {
//        #expect("BinaryInteger initializer didn't throw for out-of-range value") {
//            _ = Int24(Int64(Int24.maxInt) + 1)
//        }
//    }
    
    @Test("Exactly BinaryInteger - Valid Value")
    func testExactlyBinaryIntegerValid() {
        let a = Int24(exactly: 123456)
        #expect(a?.value == 123456, "BinaryInteger exactly initializer failed for a valid value")
    }
    
    @Test("Exactly BinaryInteger - Out-of-Range")
    func testExactlyBinaryIntegerOutOfRange() {
        let b = Int24(exactly: Int64(Int24.maxInt) + 1)
        #expect(b == nil, "BinaryInteger exactly initializer didn't return nil for out-of-range value")
    }
    
    @Test("Truncating BinaryInteger - Signed Adjusted")
    func testTruncatingBinaryIntegerSignedAdjusted() {
        let a = Int24(truncatingIfNeeded: Int64(Int24.maxInt) + 1)
        let truncatedMasked = Int32((Int64(Int24.maxInt) + 1) & Int64(Int24.maskInt))
        let expected = truncatedMasked > Int24.maxInt ? truncatedMasked - Int32(Int24.maskInt + 1) : truncatedMasked
        #expect(a.value == expected, "Expected \(expected), got \(a)")
    }
    
    @Test("Truncating BinaryInteger - Valid Value")
    func testTruncatingBinaryIntegerValid() {
        let b = Int24(truncatingIfNeeded: 12345)
        #expect(b.value == 12345, "Truncating BinaryInteger initializer failed for valid value")
    }
    
    @Test("Truncating BinaryInteger - Signed Range")
    func testTruncatingBinaryIntegerSignedRange() {
        let a = Int24(truncatingIfNeeded: Int64(Int24.maxInt) + 1)
        let expected = Int24(-8388608)
        #expect(a == expected, "Expected \(expected), got \(a)")
    }
    
    @Test("Truncating BinaryInteger - Negative Range")
    func testTruncatingBinaryIntegerNegativeRange() {
        let b = Int24(truncatingIfNeeded: Int64(Int24.minInt) - 1)
        let expected = Int24(8388607)
        #expect(b == expected, "Expected \(expected), got \(b)")
    }
    
    @Test("Clamping BinaryInteger - Above Range")
    func testClampingBinaryIntegerAboveRange() {
        let a = Int24(clamping: Int64(Int24.maxInt) + 1)
        #expect(a.value == Int24.maxInt, "Clamping BinaryInteger initializer failed for value above range")
    }
    
    @Test("Clamping BinaryInteger - Below Range")
    func testClampingBinaryIntegerBelowRange() {
        let b = Int24(clamping: Int64(Int24.minInt) - 1)
        #expect(b.value == Int24.minInt, "Clamping BinaryInteger initializer failed for value below range")
    }
    
    @Test("Clamping BinaryInteger - Valid Value")
    func testClampingBinaryIntegerValid() {
        let c = Int24(clamping: 12345)
        #expect(c.value == 12345, "Clamping BinaryInteger initializer failed for valid value")
    }
    
    @Test("BinaryFloatingPoint - Positive with Rounding")
    func testBinaryFloatingPointPositive() {
        let a = Int24(Double(123.6))
        #expect(a.value == 124, "BinaryFloatingPoint initializer failed for rounding up")
    }
    
    @Test("BinaryFloatingPoint - Negative with Rounding")
    func testBinaryFloatingPointNegative() {
        let b = Int24(Float(-123.4))
        #expect(b.value == -123, "BinaryFloatingPoint initializer failed for rounding down")
    }
    
//    @Test("BinaryFloatingPoint - Out-of-Range")
//    func testBinaryFloatingPointOutOfRange() {
//        #expectFatalError("BinaryFloatingPoint initializer didn't throw for out-of-range value") {
//            _ = Int24(Double(Int24.maxInt) + 1.0)
//        }
//    }
    
    @Test("Exactly BinaryFloatingPoint - Valid Value")
    func testExactlyBinaryFloatingPointValid() {
        let a = Int24(exactly: Double(123.0))
        #expect(a?.value == 123, "BinaryFloatingPoint exactly initializer failed for a valid value")
    }
    
    @Test("Exactly BinaryFloatingPoint - Out-of-Range")
    func testExactlyBinaryFloatingPointOutOfRange() {
        let b = Int24(exactly: Double(Int24.maxInt) + 1.0)
        #expect(b == nil, "BinaryFloatingPoint exactly initializer didn't return nil for out-of-range value")
    }
}
