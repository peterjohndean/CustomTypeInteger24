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

struct UInt24_Tests {
    
    // Test Positive Values
    @Test("Test Positive Values")
    func testPositiveValues() {
        let a: UInt24 = 1
        #expect(a.value == 1, "Value should be 1, but got \(a.value)")
        
        let b: UInt24 = 0xFF_FFFF  // Maximum value for UInt24
        #expect(b.value == 0xFF_FFFF, "Value should be 0xFF_FFFF, but got \(b.value)")
        
        let c: UInt24 = 0  // Minimum value for UInt24
        #expect(c.value == 0, "Value should be 0, but got \(c.value)")
    }
    
    // Test Magnitude
    @Test("Test Magnitude")
    func testMagnitude() {
        let a: UInt24 = 0x00FF00
        #expect(a.magnitude == UInt24(0x00FF00), "Magnitude should match UInt24 conversion for positive value.")
        
        let b: UInt24 = 0
        #expect(b.magnitude == UInt24(0), "Magnitude should be 0 for zero value.")
    }
    
    // Test Words
    @Test("Test Words")
    func testWords() {
        let a: UInt24 = 0x00FF00
        #expect(a.words == [UInt(0x00FF00)], "Words should contain the correct value for positive value.")
        
        let b: UInt24 = 0
        #expect(b.words == [UInt(0)], "Words should be 0 for zero value.")
    }
    
    // Test Description
    @Test("Test Description")
    func testDescription() {
        let a: UInt24 = 12345
        #expect(a.description == "12345", "Description should correctly convert the value to a string for positive value.")
        
        let b: UInt24 = 0
        #expect(b.description == "0", "Description should be 0 for zero value.")
    }
    
    // Test Trailing Zero Bit Count
    @Test("Test Trailing Zero Bit Count")
    func testTrailingZeroBitCount() {
        let a: UInt24 = 0x00FF00
        #expect(a.trailingZeroBitCount == 8, "Trailing zero bit count should be 8 for value 0x00FF00.")
        
        let b: UInt24 = 0
        #expect(b.trailingZeroBitCount == 24, "Trailing zero bit count should be 24 for value 0.")
        
        let c: UInt24 = 0x01
        #expect(c.trailingZeroBitCount == 0, "Trailing zero bit count should be 0 for value 0x01.")
    }
    
    // Test Non-Zero Bit Count
    @Test("Test Non-Zero Bit Count")
    func testNonzeroBitCount() {
        let a: UInt24 = 0x00FF00
        #expect(a.nonzeroBitCount == 8, "Nonzero bit count should be 8 for value 0x00FF00.")
        
        let b: UInt24 = 0
        #expect(b.nonzeroBitCount == 0, "Nonzero bit count should be 0 for zero value.")
        
        let c: UInt24 = 0xFF_FFFF
        #expect(c.nonzeroBitCount == 24, "Nonzero bit count should be 24 for maximum value 0xFF_FFFF.")
    }
    
    // Test Leading Zero Bit Count
    @Test("Test Leading Zero Bit Count")
    func testLeadingZeroBitCount() {
        let a: UInt24 = 0x00FF00
        #expect(a.leadingZeroBitCount == 8, "Leading zero bit count should be 8 for value 0x00FF00.")
        
        let b: UInt24 = 0
        #expect(b.leadingZeroBitCount == 24, "Leading zero bit count should be 24 for value 0.")
        
        let c: UInt24 = 0x01
        #expect(c.leadingZeroBitCount == 23, "Leading zero bit count should be 23 for value 0x01.")
    }
    
    // Test Byte Swapping
    @Test("Test Byte Swapping")
    func testByteSwapped() {
        let a: UInt24 = 0x123456
        let swapped = a.byteSwapped
        #expect(swapped.value == 0x563412, "Byte-swapped value should match the expected result for positive value.")
        
        let b: UInt24 = 0
        #expect(b.byteSwapped.value == 0, "Byte-swapped value should be 0 for zero value.")
    }
    
    @Test("Byte-swapped maximum value")
    func testByteSwappedMaximum() {
        let c: UInt24 = UInt24.max
        let d = c.byteSwapped
        #expect(d.value == 0xFF_FFFF, "Byte-swapped value of maximum should match the expected result.")
    }
    
    // Edge case for large values
    @Test("Test Large Values")
    func testLargeValues() {
        let max = UInt24.max
        
        let a: UInt32 = UInt32.max
        #expect(a == 0xFFFF_FFFF, "UInt32 representation should match UInt32.max.")
        
        // Check words for max
        #expect(max.words == [UInt(UInt24.max)], "Words of max should match the max value.")
        
        // Check description for max
        #expect(max.description == "\(UInt24.max)", "Description of max should be correct.")
    }
}
