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

struct Int24_ComparatorTests {

    // MARK: Test Cases for == and !=
    @Test("Equality - Equal Positive Values")
    func testEqualityEqualPositive() {
        let a: Int24 = 12345
        let b: Int24 = 12345
        #expect(a == b, "Equality failed for two equal positive values.")
        #expect(!(a != b), "Inequality incorrectly returned true for two equal positive values.")
    }
    
    @Test("Equality - Equal Negative Values")
    func testEqualityEqualNegative() {
        let a: Int24 = -12345
        let b: Int24 = -12345
        #expect(a == b, "Equality failed for two equal negative values.")
        #expect(!(a != b), "Inequality incorrectly returned true for two equal negative values.")
    }
    
    @Test("Equality - Positive and Negative Values")
    func testEqualityPositiveAndNegative() {
        let a: Int24 = 12345
        let b: Int24 = -12345
        #expect(!(a == b), "Equality should fail for a positive and a negative value.")
        #expect(a != b, "Inequality should return true for a positive and a negative value.")
    }
    
    @Test("Equality - Zero")
    func testEqualityZero() {
        let a: Int24 = 0
        let b: Int24 = 0
        #expect(a == b, "Equality failed for two zero values.")
        #expect(!(a != b), "Inequality incorrectly returned true for two zero values.")
    }
    
    @Test("Equality - Max and Min")
    func testEqualityMaxAndMin() {
        let a: Int24 = Int24.max
        let b: Int24 = Int24.min
        #expect(!(a == b), "Equality should fail for max and min values.")
        #expect(a != b, "Inequality should return true for max and min values.")
    }

    // MARK: Test Cases for < and <=
    @Test("Less Than - Positive Comparison")
    func testLessThanPositive() {
        let a: Int24 = 100
        let b: Int24 = 200
        #expect(a < b, "Less-than comparison failed for two positive values.")
        #expect(a <= b, "Less-than-or-equal comparison failed for two positive values.")
    }
    
    @Test("Less Than - Negative Comparison")
    func testLessThanNegative() {
        let a: Int24 = -200
        let b: Int24 = -100
        #expect(a < b, "Less-than comparison failed for two negative values.")
        #expect(a <= b, "Less-than-or-equal comparison failed for two negative values.")
    }
    
    @Test("Less Than - Mixed Sign Comparison")
    func testLessThanMixedSign() {
        let a: Int24 = -100
        let b: Int24 = 100
        #expect(a < b, "Less-than comparison failed for a negative and a positive value.")
        #expect(a <= b, "Less-than-or-equal comparison failed for a negative and a positive value.")
    }
    
    @Test("Less Than - Equal Values")
    func testLessThanEqualValues() {
        let a: Int24 = 123
        let b: Int24 = 123
        #expect(!(a < b), "Less-than comparison should fail for two equal values.")
        #expect(a <= b, "Less-than-or-equal comparison failed for two equal values.")
    }
    
    @Test("Less Than - Max and Min")
    func testLessThanMaxAndMin() {
        let a: Int24 = Int24.min
        let b: Int24 = Int24.max
        #expect(a < b, "Less-than comparison failed for min and max values.")
        #expect(a <= b, "Less-than-or-equal comparison failed for min and max values.")
    }
    
    // MARK: Test Cases for > and >=
    @Test("Greater Than - Positive Comparison")
    func testGreaterThanPositive() {
        let a: Int24 = 200
        let b: Int24 = 100
        #expect(a > b, "Greater-than comparison failed for two positive values.")
        #expect(a >= b, "Greater-than-or-equal comparison failed for two positive values.")
    }
    
    @Test("Greater Than - Negative Comparison")
    func testGreaterThanNegative() {
        let a: Int24 = -100
        let b: Int24 = -200
        #expect(a > b, "Greater-than comparison failed for two negative values.")
        #expect(a >= b, "Greater-than-or-equal comparison failed for two negative values.")
    }
    
    @Test("Greater Than - Mixed Sign Comparison")
    func testGreaterThanMixedSign() {
        let a: Int24 = 100
        let b: Int24 = -100
        #expect(a > b, "Greater-than comparison failed for a positive and a negative value.")
        #expect(a >= b, "Greater-than-or-equal comparison failed for a positive and a negative value.")
    }
    
    @Test("Greater Than - Equal Values")
    func testGreaterThanEqualValues() {
        let a: Int24 = 123
        let b: Int24 = 123
        #expect(!(a > b), "Greater-than comparison should fail for two equal values.")
        #expect(a >= b, "Greater-than-or-equal comparison failed for two equal values.")
    }
    
    @Test("Greater Than - Max and Min")
    func testGreaterThanMaxAndMin() {
        let a: Int24 = Int24.max
        let b: Int24 = Int24.min
        #expect(a > b, "Greater-than comparison failed for max and min values.")
        #expect(a >= b, "Greater-than-or-equal comparison failed for max and min values.")
    }
}
