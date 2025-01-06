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

struct UInt24_ComparatorTests {
    
    // MARK: Test Cases for == and !=
    @Test("Equality - Equal Values")
    func testEqualityEqualValues() {
        let a: UInt24 = 12345
        let b: UInt24 = 12345
        #expect(a == b, "Equality failed for two equal values.")
        #expect(!(a != b), "Inequality incorrectly returned true for two equal values.")
    }
    
    @Test("Equality - Different Values")
    func testEqualityDifferentValues() {
        let a: UInt24 = 12345
        let b: UInt24 = 54321
        #expect(!(a == b), "Equality should fail for two different values.")
        #expect(a != b, "Inequality failed for two different values.")
    }
    
    @Test("Equality - Zero")
    func testEqualityZero() {
        let a: UInt24 = 0
        let b: UInt24 = 0
        #expect(a == b, "Equality failed for two zero values.")
        #expect(!(a != b), "Inequality incorrectly returned true for two zero values.")
    }
    
    @Test("Equality - Max Value")
    func testEqualityMaxValue() {
        let a: UInt24 = UInt24.max
        let b: UInt24 = UInt24.max
        #expect(a == b, "Equality failed for two maximum values.")
        #expect(!(a != b), "Inequality incorrectly returned true for two maximum values.")
    }
    
    // MARK: Test Cases for < and <=
    @Test("Less Than - Smaller and Larger Values")
    func testLessThanSmallerLarger() {
        let a: UInt24 = 100
        let b: UInt24 = 200
        #expect(a < b, "Less-than comparison failed for a smaller and a larger value.")
        #expect(a <= b, "Less-than-or-equal comparison failed for a smaller and a larger value.")
    }
    
    @Test("Less Than - Equal Values")
    func testLessThanEqualValues() {
        let a: UInt24 = 123
        let b: UInt24 = 123
        #expect(!(a < b), "Less-than comparison should fail for two equal values.")
        #expect(a <= b, "Less-than-or-equal comparison failed for two equal values.")
    }
    
    @Test("Less Than - Zero and Positive Value")
    func testLessThanZeroPositive() {
        let a: UInt24 = 0
        let b: UInt24 = 123
        #expect(a < b, "Less-than comparison failed for zero and a positive value.")
        #expect(a <= b, "Less-than-or-equal comparison failed for zero and a positive value.")
    }
    
    @Test("Less Than - Max and Min Values")
    func testLessThanMaxMinValues() {
        let a: UInt24 = 0
        let b: UInt24 = UInt24.max
        #expect(a < b, "Less-than comparison failed for minimum and maximum values.")
        #expect(a <= b, "Less-than-or-equal comparison failed for minimum and maximum values.")
    }
    
    // MARK: Test Cases for > and >=
    @Test("Greater Than - Larger and Smaller Values")
    func testGreaterThanLargerSmaller() {
        let a: UInt24 = 200
        let b: UInt24 = 100
        #expect(a > b, "Greater-than comparison failed for a larger and a smaller value.")
        #expect(a >= b, "Greater-than-or-equal comparison failed for a larger and a smaller value.")
    }
    
    @Test("Greater Than - Equal Values")
    func testGreaterThanEqualValues() {
        let a: UInt24 = 123
        let b: UInt24 = 123
        #expect(!(a > b), "Greater-than comparison should fail for two equal values.")
        #expect(a >= b, "Greater-than-or-equal comparison failed for two equal values.")
    }
    
    @Test("Greater Than - Positive and Zero")
    func testGreaterThanPositiveZero() {
        let a: UInt24 = 123
        let b: UInt24 = 0
        #expect(a > b, "Greater-than comparison failed for a positive value and zero.")
        #expect(a >= b, "Greater-than-or-equal comparison failed for a positive value and zero.")
    }
    
    @Test("Greater Than - Max and Min Values")
    func testGreaterThanMaxMinValues() {
        let a: UInt24 = UInt24.max
        let b: UInt24 = 0
        #expect(a > b, "Greater-than comparison failed for maximum and minimum values.")
        #expect(a >= b, "Greater-than-or-equal comparison failed for maximum and minimum values.")
    }
}

