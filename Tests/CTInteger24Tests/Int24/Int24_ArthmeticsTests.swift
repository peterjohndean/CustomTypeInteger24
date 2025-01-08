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

struct Int24_ArthmeticsTests {

    // MARK: Arithmetic Operators
    @Test("Addition - No Overflow")
    func testAdditionNoOverflow() {
        let a = Int24(12345)
        let b = Int24(54321)
        let result = a + b
        let expected = Int24(66666)
        #expect(result == expected, "Expected \(expected), got \(result)")
    }
    
    @Test("Addition - Positive Overflow")
    func testAdditionPositiveOverflow() {
        let a = Int24(Int24.max)
        let b = Int24(1)
//        _ = a + b
    }
    
    @Test("Addition - Negative Overflow")
    func testAdditionNegativeOverflow() {
        let a = Int24(Int24.min)
        let b = Int24(-1)
//        _ = a + b
    }
    
    @Test("Subtraction - No Overflow")
    func testSubtractionNoOverflow() {
        let a = Int24(54321)
        let b = Int24(12345)
        let result = a - b
        let expected = Int24(41976)
        #expect(result == expected, "Expected \(expected), got \(result)")
    }
    
    @Test("Subtraction - Positive Overflow")
    func testSubtractionPositiveOverflow() {
        let a = Int24(Int24.max)
        let b = Int24(-1)
//        _ = a - b
    }
    
    @Test("Subtraction - Negative Overflow")
    func testSubtractionNegativeOverflow() {
        let a = Int24(Int24.min)
        let b = Int24(1)
//        _ = a - b
    }
    
    @Test("Multiplication - No Overflow")
    func testMultiplicationNoOverflow() {
        let a = Int24(300)
        let b = Int24(200)
        let result = a * b
        let expected = Int24(60000)
        #expect(result == expected, "Expected \(expected), got \(result)")
    }
    
    @Test("Multiplication - Positive Overflow")
    func testMultiplicationPositiveOverflow() {
        let a = Int24(Int24.max / 2 + 1)
        let b = Int24(2)
//        _ = a * b
    }
    
    @Test("Multiplication - Negative Overflow")
    func testMultiplicationNegativeOverflow() {
        let a = Int24(Int24.min / 2)
        let b = Int24(3)
//        _ = a * b
//        _ = Int24(Int24.min / 2) * Int24(3)
//        _ = Int32(Int32.min / 2) * Int32(3)
    }
    
    @Test("Division - No Overflow")
    func testDivisionNoOverflow() {
        let a = Int24(60000)
        let b = Int24(200)
        let result = a / b
        let expected = Int24(300)
        #expect(result == expected, "Expected \(expected), got \(result)")
    }
    
    @Test("Division - Division by Zero")
    func testDivisionByZero() {
        let a = Int24(12345)
        let b = Int24(0)
//        _ = a / b
    }
    
    @Test("Remainder - No Overflow")
    func testRemainderNoOverflow() {
        let a = Int24(12345)
        let b = Int24(100)
        let result = a % b
        let expected = Int24(45)
        #expect(result == expected, "Expected \(expected), got \(result)")
    }
    
    @Test("Remainder - Division by Zero")
    func testRemainderDivisionByZero() {
        let a = Int24(12345)
        let b = Int24(0)
//        _ = a % b
//        _ = Int24(Int24.min) % Int24(-1)
    }

    // MARK: Compound Operators
    @Test("Addition Assignment - No Overflow")
    func testAdditionAssignmentNoOverflow() {
        var a = Int24(12345)
        let b = Int24(54321)
        a += b
        let expected = Int24(66666)
        #expect(a == expected, "Expected \(expected), got \(a)")
    }
    
    @Test("Addition Assignment - Overflow")
    func testAdditionAssignmentOverflow() {
        var a = Int24(Int24.max)
        let b = Int24(1)
//        a += b
    }
    
    @Test("Subtraction Assignment - No Overflow")
    func testSubtractionAssignmentNoOverflow() {
        var a = Int24(54321)
        let b = Int24(12345)
        a -= b
        let expected = Int24(41976)
        #expect(a == expected, "Expected \(expected), got \(a)")
    }
    
    @Test("Subtraction Assignment - Overflow")
    func testSubtractionAssignmentOverflow() {
        var a = Int24(Int24.min)
        let b = Int24(1)
//        debugPrint(a.value, a.hex, a.value.toFormattedHexString, b.value, b.value.toFormattedHexString)
//        a -= b
    }
    
    @Test("Multiplication Assignment - No Overflow")
    func testMultiplicationAssignmentNoOverflow() {
        var a = Int24(300)
        let b = Int24(200)
        a *= b
        let expected = Int24(60000)
        #expect(a == expected, "Expected \(expected), got \(a)")
    }
    
    @Test("Multiplication Assignment - Overflow")
    func testMultiplicationAssignmentOverflow() {
        var a = Int24(Int24.max / 2 + 1)
        let b = Int24(2)
//        a *= b
    }
    
    @Test("Division Assignment - No Overflow")
    func testDivisionAssignmentNoOverflow() {
        var a = Int24(60000)
        let b = Int24(200)
        a /= b
        let expected = Int24(300)
        #expect(a == expected, "Expected \(expected), got \(a)")
    }
    
    @Test("Division Assignment - Division by Zero")
    func testDivisionAssignmentDivisionByZero() {
        var a = Int24(12345)
        let b = Int24(0)
//        a /= b
    }
    
    @Test("Remainder Assignment - No Overflow")
    func testRemainderAssignmentNoOverflow() {
        var a = Int24(12345)
        let b = Int24(100)
        a %= b
        let expected = Int24(45)
        #expect(a == expected, "Expected \(expected), got \(a)")
    }
    
    @Test("Remainder Assignment - Division by Zero")
    func testRemainderAssignmentDivisionByZero() {
        var a = Int24(12345)
        let b = Int24(0)
//        a %= b
    }
    
    // MARK: Bitwise Operators
    @Test("Bitwise AND")
    func testBitwiseAND() {
        var a = Int24(0b1100)
        let b = Int24(0b1010)
        var c = a
        a &= b
        let expected = Int24(0b1000)
        #expect(a == expected, "Expected \(expected), got \(a)")
        
        c = c & b
        #expect(c == expected, "Expected \(expected), got \(c)")
    }
    
    @Test("Bitwise OR")
    func testBitwiseOR() {
        var a = Int24(0b1100)
        let b = Int24(0b1010)
        var c = a
        a |= b
        let expected = Int24(0b1110)
        #expect(a == expected, "Expected \(expected), got \(a)")
        
        c = c | b
        #expect(c == expected, "Expected \(expected), got \(c)")
    }
    
    @Test("Bitwise XOR")
    func testBitwiseXOR() {
        var a = Int24(0b1100)
        let b = Int24(0b1010)
        var c = a
        a ^= b
        let expected = Int24(0b0110)
        #expect(a == expected, "Expected \(expected), got \(a)")
        
        c = c ^ b
        #expect(c == expected, "Expected \(expected), got \(c)")
    }
    
    @Test("Bitwise NOT")
    func testBitwiseNOT() {
        let a = Int24(0b00001111)
        let result = ~a
        let expected = Int24(-16) // Complement of 0b00001111 in a signed 24-bit context
        #expect(result == expected, "Expected \(expected), got \(result)")
    }
    
    // MARK: Shift Operators
    @Test("Left Shift")
    func testLeftShift() {
        var a = Int24(1)
        a <<= 3
        let expected = Int24(8)
        #expect(a == expected, "Expected \(expected), got \(a)")
        
        a = a << 3
        #expect(a == 64, "Expected \(expected), got \(a)")
    }
    
    @Test("Right Shift")
    func testRightShift() {
        var a = Int24(16)
        a >>= 2
        let expected = Int24(4)
        #expect(a == expected, "Expected \(expected), got \(a)")
        
        a = a >> 2
        #expect(a == 1, "Expected \(expected), got \(a)")
    }
}
