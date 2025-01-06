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

struct Int24_Tests {
    
    // Test quotientAndRemainder
    @Test("Test quotientAndRemainder")
    func testQuotientAndRemainder() {
        let a: Int24 = 25
        let b: Int24 = 4
        let (quotient, remainder) = a.quotientAndRemainder(dividingBy: b)
        #expect(quotient == 6, "Quotient should be 6 for 25 / 4.")
        #expect(remainder == 1, "Remainder should be 1 for 25 % 4.")
        
        let c: Int24 = -25
        let (negQuotient, negRemainder) = c.quotientAndRemainder(dividingBy: b)
        #expect(negQuotient == -6, "Quotient should be -6 for -25 / 4.")
        #expect(negRemainder == -1, "Remainder should be -1 for -25 % 4.")
        
        let d: Int24 = 0
        let (zeroQuotient, zeroRemainder) = d.quotientAndRemainder(dividingBy: b)
        #expect(zeroQuotient == 0, "Quotient should be 0 for 0 / 4.")
        #expect(zeroRemainder == 0, "Remainder should be 0 for 0 % 4.")
    }
    
    @Test func testQuotientAndRemainderInt32() {
        let a: Int32 = 25
        let b: Int32 = 4
        let (quotient, remainder) = a.quotientAndRemainder(dividingBy: b)
        #expect(quotient == 6, "Quotient should be 6 for 25 / 4.")
        #expect(remainder == 1, "Remainder should be 1 for 25 % 4.")
        
        let c: Int32 = -25
        let (negQuotient, negRemainder) = c.quotientAndRemainder(dividingBy: b)
        #expect(negQuotient == -6, "Quotient should be -6 for -25 / 4.")
        #expect(negRemainder == -1, "Remainder should be -1 for -25 % 4.")
        
        let d: Int32 = 0
        let (zeroQuotient, zeroRemainder) = d.quotientAndRemainder(dividingBy: b)
        #expect(zeroQuotient == 0, "Quotient should be 0 for 0 / 4.")
        #expect(zeroRemainder == 0, "Remainder should be 0 for 0 % 4.")
    }
    
    // Test isMultiple
    @Test("Test isMultiple")
    func testIsMultiple() {
        let a: Int24 = 24
        let b: Int24 = 6
        #expect(a.isMultiple(of: b) == true, "24 should be a multiple of 6.")
        
        let c: Int24 = 25
        #expect(c.isMultiple(of: b) == false, "25 should not be a multiple of 6.")
        
        let d: Int24 = 0
        #expect(d.isMultiple(of: b) == true, "0 should be a multiple of 6.")
        
        let e: Int24 = -18
        #expect(e.isMultiple(of: b) == true, "-18 should be a multiple of 6.")
    }
    
    // Test signum
    @Test("Test signum")
    func testSignum() {
        let a: Int24 = 25
        #expect(a.signum() == 1, "Signum should return 1 for positive numbers.")
        
        let b: Int24 = -25
        #expect(b.signum() == -1, "Signum should return -1 for negative numbers.")
        
        let c: Int24 = 0
        #expect(c.signum() == 0, "Signum should return 0 for zero.")
    }

    // Test Negative
    @Test("Test Negative")
    func testNegative() {
        let a: Int24 = -1  // A valid negative value for Int24, should be accepted
        #expect(a.value == -1, "Value should be -1, but got \(a.value)")
        
        let b: Int24 = -0x10000  // Another negative value within the Int24 range
        #expect(b.value == -0x10000, "Value should be -0x10000, but got \(b.value)")
        
        let c: Int24 = -0x7F_FFFF  // This is the minimum negative value that fits in Int24
        #expect(c.value == -0x7F_FFFF, "Value should be -0x7FFFFF, but got \(c.value)")
    }
    
    // Test Magnitude
    @Test("Test Magnitude")
    func testMagnitude() {
        // Positive value
        let a: Int24 = 0x00FF00
        #expect(a.magnitude == UInt24(0x00FF00), "Magnitude should match UInt24 conversion for positive value.")
        
        // Negative value
        let b: Int24 = abs(-0x00FF00)
        #expect(b.magnitude == UInt24(0x00FF00), "Magnitude should match UInt24 conversion for negative value.")
        
        // Zero value
        let c: Int24 = 0
        #expect(c.magnitude == UInt24(0), "Magnitude should be 0 for zero value.")
    }
    
    // Test Words
    @Test("Test Words")
    func testWords() {
        let a: Int24 = 0x00FF00
        #expect(a.words == [UInt(0x00FF00)], "Words should contain the correct value for positive value.")
        
        let b: Int24 = -0x00FF00
        #expect(b.words == [UInt(0x00FF00)], "Words should contain the correct value for negative value.")
        
        let c: Int24 = 0
        #expect(c.words == [UInt(0)], "Words should be 0 for zero value.")
    }
    
    // Test Description
    @Test("Test Description")
    func testDescription() {
        let a: Int24 = 12345
        #expect(a.description == "12345", "Description should correctly convert the value to a string for positive value.")
        
        let b: Int24 = -12345
        #expect(b.description == "-12345", "Description should correctly convert negative value to a string.")
        
        let c: Int24 = 0
        #expect(c.description == "0", "Description should be 0 for zero value.")
    }
    
    // Test Trailing Zero Bit Count
    @Test("Test Trailing Zero Bit Count")
    func testTrailingZeroBitCount() {
        let a: Int24 = 0x00FF00
        #expect(a.trailingZeroBitCount == 8, "Trailing zero bit count should be 8 for value 0x00FF00.")
        
        let b: Int24 = 0
        #expect(b.trailingZeroBitCount == 24, "Trailing zero bit count should be 24 for value 0.")
        
        let c: Int24 = 0x01
        #expect(c.trailingZeroBitCount == 0, "Trailing zero bit count should be 0 for value 0x01.")
    }
    
    // Test Non-Zero Bit Count
    @Test("Test Non-Zero Bit Count")
    func testNonzeroBitCount() {
        let a: Int24 = 0x00FF00
        #expect(a.nonzeroBitCount == 8, "Nonzero bit count should be 8 for value 0x00FF00.")
        
        let b: Int24 = 0
        #expect(b.nonzeroBitCount == 0, "Nonzero bit count should be 0 for zero value.")
        
        let c: Int24 = -1  // Valid negative value, which is 0xFF_FFFF in two's complement
        #expect(c.nonzeroBitCount == 24, "Nonzero bit count should be 24 for value -1 (0xFFFFFF).")
        
    }
    
    // Test Leading Zero Bit Count
    @Test("Test Leading Zero Bit Count")
    func testLeadingZeroBitCount() {
        let a: Int24 = 0x00FF00
        #expect(a.leadingZeroBitCount == 8, "Leading zero bit count should be 16 for value 0x00FF00.")
        
        let b: Int24 = 0
        #expect(b.leadingZeroBitCount == 24, "Leading zero bit count should be 24 for value 0.")
        
        let c: Int24 = 0x01
        #expect(c.leadingZeroBitCount == 23, "Leading zero bit count should be 23 for value 0x01.")
        
        let d: Int24 = -0x01
        #expect(d.leadingZeroBitCount == 0, "Leading zero bit count for negative value should be 0.")
    }
    
    // Test Byte Swapping
    @Test("Test Byte Swapping")
    func testByteSwapped() {
        let a: Int24 = 0x123456
        let swapped = a.byteSwapped
        #expect(swapped.value == 0x563412, "Byte-swapped value should match the expected result for positive value.")
        
        let b: Int24 = 0
        #expect(b.byteSwapped.value == 0, "Byte-swapped value should be 0 for zero value.")
        
        let c: Int24 = -0x123456
        let d: Int24 = c.byteSwapped
        #expect(d.valueRaw == 0xAA_CBED /* -5583891 */, "Byte-swapped value should match the expected result for negative value.")
    }
    
    @Test("Byte-swapped positive value")
    func testByteSwappedPositive() {
        let c: Int24 = 0x123456
        let d = c.byteSwapped
        #expect(d.valueRaw == 0x563412, "Byte-swapped value should match the expected result for positive value.")
    }
    
    @Test("Byte-swapped negative value")
    func testByteSwappedNegative() {
        let c: Int24 = -0x123456
        let d = c.byteSwapped
        #expect(d.valueRaw == 0xAACBED /* -5583891 */, "Byte-swapped value should match the expected result for negative value.")
    }
    
    @Test("Byte-swapped zero")
    func testByteSwappedZero() {
        let c: Int24 = 0
        let d = c.byteSwapped
        #expect(d.valueRaw == 0, "Byte-swapped value of zero should still be zero.")
    }
    
    @Test("Byte-swapped minimum value")
    func testByteSwappedMinimum() {
        let c: Int24 = Int24.min
        let d = c.byteSwapped
        #expect(d.valueRaw == 0x00_0080, "Byte-swapped value of minimum should match the expected result.")
    }
    
    @Test("Byte-swapped maximum value")
    func testByteSwappedMaximum() {
        let c: Int24 = Int24.max
        let d = c.byteSwapped
        debugPrint(c.valueRaw.toFormattedHexString)
        debugPrint(d.valueRaw.toFormattedHexString)
        #expect(d.valueRaw == 0xFF_FF7F, "Byte-swapped value of maximum should match the expected result.")
    }
    
    // Edge case for large values
    @Test("Test Large Values")
    func testLargeValues() {
        let max = Int24.max
        let min = Int24.min
        
        let a: Int32 = Int32.min
        #expect(a.magnitude == UInt32(Int32.max) + 1, "UInt32 representation of Int32.min should match Int32.min.")
        
        // Test magnitude of max and min values
        #expect(max.magnitude == UInt24(Int24.max), "Magnitude of max should match the max int value.")
        #expect(min.magnitude == UInt24(Int24.max) + 1, "Magnitude of min should match the max int value.")

        // Check words for max and min
        #expect(max.words == [UInt(Int24.max)], "Words of max should match the max value.")
        #expect(min.words == [UInt(abs(Int24.max)) + 1], "Words of min should match the max value.")
        
        // Check description for max and min
        #expect(max.description == "\(Int24.maxInt)", "Description of max should be correct.")
        #expect(min.description == "\(Int24.minInt)", "Description of min should be correct.")
    }

}
