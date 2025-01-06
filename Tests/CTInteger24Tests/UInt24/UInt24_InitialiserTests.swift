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

struct UInt24_InitializerTests {
    
    // MARK: - Default Initializer
    @Test("Default Initializer - Positive Number")
    func testDefaultInitializerPositive() {
        let a = UInt24(123456)
        #expect(a.value == 123456, "Default initializer failed for a positive number")
    }
    
    @Test("Default Initializer - Zero")
    func testDefaultInitializerZero() {
        let a = UInt24()
        #expect(a.value == 0, "Default initializer failed for zero")
    }
    
    // MARK: - Truncating Bits
    @Test("Truncating Bits - Max Unsigned Value")
    func testTruncatingBitsMaxUnsigned() {
        let a = UInt24(_truncatingBits: UInt(0xFF_FFFF))
        #expect(a.value == UInt24.max, "Truncating bits failed for max unsigned value")
    }
    
    @Test("Truncating Bits - Zero")
    func testTruncatingBitsZero() {
        let b = UInt24(_truncatingBits: UInt(0))
        #expect(b.value == 0, "Truncating bits failed for zero")
    }
    
    // MARK: - Integer Literal
    @Test("Integer Literal - Positive")
    func testIntegerLiteralPositive() {
        let a: UInt24 = 123456
        #expect(a.value == 123456, "Integer literal initializer failed for a positive value")
    }
    
    // MARK: - FixedWidthInteger
    @Test("FixedWidthInteger - Int16")
    func testFixedWidthIntegerInt16() {
        let a = UInt24(Int16(12345))
        #expect(a.value == 12345, "FixedWidthInteger initializer failed for Int16")
    }
    
    @Test("FixedWidthInteger - UInt8")
    func testFixedWidthIntegerUInt8() {
        let b = UInt24(UInt8(255))
        #expect(b.value == 255, "FixedWidthInteger initializer failed for UInt8")
    }
    
//    @Test("FixedWidthInteger - Out-of-Range")
//    func testFixedWidthIntegerOutOfRange() {
////        #expectFatalError("FixedWidthInteger initializer didn't throw for out-of-range value") {
////            _ = UInt24(UInt64(UInt24.max) + 1)
////        }
//    }
    
    // MARK: - BinaryInteger
    @Test("BinaryInteger - Positive")
    func testBinaryIntegerPositive() {
        let a = UInt24(Int(123456))
        #expect(a.value == 123456, "BinaryInteger initializer failed for positive Int")
    }
    
//    @Test("BinaryInteger - Out-of-Range")
//    func testBinaryIntegerOutOfRange() {
////        #expectFatalError("BinaryInteger initializer didn't throw for out-of-range value") {
////            _ = UInt24(Int64(UInt24.max) + 1)
////        }
//    }
    
    @Test("Exactly BinaryInteger - Valid Value")
    func testExactlyBinaryIntegerValid() {
        let a = UInt24(exactly: 123456)
        #expect(a?.value == 123456, "BinaryInteger exactly initializer failed for a valid value")
    }
    
    @Test("Exactly BinaryInteger - Out-of-Range")
    func testExactlyBinaryIntegerOutOfRange() {
        let b = UInt24(exactly: Int64(UInt24.max) + 1)
        #expect(b == nil, "BinaryInteger exactly initializer didn't return nil for out-of-range value")
    }
    
    // MARK: - Truncating BinaryInteger
    @Test("Truncating BinaryInteger - Valid Value")
    func testTruncatingBinaryIntegerValid() {
        let b = UInt24(truncatingIfNeeded: 12345)
        #expect(b.value == 12345, "Truncating BinaryInteger initializer failed for valid value")
    }
    
    @Test("Truncating BinaryInteger - Above Range")
    func testTruncatingBinaryIntegerAboveRange() {
        let a = UInt24(truncatingIfNeeded: UInt64(UInt24.max) + 1)
        let expected = (UInt64(UInt24.max) + 1) & UInt64(UInt24.maskInt)
        #expect(a.value == expected, "Truncating BinaryInteger initializer failed for value above range")
    }
    
    // MARK: - Clamping BinaryInteger
    @Test("Clamping BinaryInteger - Above Range")
    func testClampingBinaryIntegerAboveRange() {
        let a = UInt24(clamping: UInt64(UInt24.max) + 1)
        #expect(a.value == UInt24.max, "Clamping BinaryInteger initializer failed for value above range")
    }
    
    @Test("Clamping BinaryInteger - Below Range")
    func testClampingBinaryIntegerBelowRange() {
        let b = UInt24(clamping: -1)
        #expect(b.value == 0, "Clamping BinaryInteger initializer failed for value below range")
    }
    
    @Test("Clamping BinaryInteger - Valid Value")
    func testClampingBinaryIntegerValid() {
        let c = UInt24(clamping: 12345)
        #expect(c.value == 12345, "Clamping BinaryInteger initializer failed for valid value")
    }
    
    // MARK: - BinaryFloatingPoint
    @Test("BinaryFloatingPoint - Positive with Rounding")
    func testBinaryFloatingPointPositive() {
        let a = UInt24(Double(123.6))
        #expect(a.value == 124, "BinaryFloatingPoint initializer failed for rounding up")
    }
    
    @Test("BinaryFloatingPoint - Zero")
    func testBinaryFloatingPointZero() {
        let c = UInt24(0.0)
        #expect(c.value == 0, "BinaryFloatingPoint initializer failed for zero")
    }
    
//    @Test("BinaryFloatingPoint - Out-of-Range")
//    func testBinaryFloatingPointOutOfRange() {
////        #expectFatalError("BinaryFloatingPoint initializer didn't throw for out-of-range value") {
////            _ = UInt24(Double(UInt24.max) + 1.0)
////        }
//    }
    
    @Test("Exactly BinaryFloatingPoint - Valid Value")
    func testExactlyBinaryFloatingPointValid() {
        let a = UInt24(exactly: Double(123.0))
        #expect(a?.value == 123, "BinaryFloatingPoint exactly initializer failed for a valid value")
    }
    
    @Test("Exactly BinaryFloatingPoint - Out-of-Range")
    func testExactlyBinaryFloatingPointOutOfRange() {
        let b = UInt24(exactly: Double(UInt24.max) + 1.0)
        #expect(b == nil, "BinaryFloatingPoint exactly initializer didn't return nil for out-of-range value")
    }
}
