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

struct UInt24_ArthmeticsTests {

    // MARK: Arithmetic Operators
    struct UInt24_ArithmeticTests {
        
        // MARK: - Addition
        @Test("Addition - No Overflow")
        func testAdditionNoOverflow() {
            let a = UInt24(12345)
            let b = UInt24(54321)
            let result = a + b
            let expected = UInt24(66666)
            #expect(result == expected, "Expected \(expected), got \(result)")
        }
        
        @Test("Addition - Overflow")
        func testAdditionOverflow() {
            let a = UInt24(UInt24.max)
            let b = UInt24(1)
//            _ = a + b // Uncomment to validate overflow
        }
        
        // MARK: - Subtraction
        @Test("Subtraction - No Underflow")
        func testSubtractionNoUnderflow() {
            let a = UInt24(54321)
            let b = UInt24(12345)
            let result = a - b
            let expected = UInt24(41976)
            #expect(result == expected, "Expected \(expected), got \(result)")
        }
        
        @Test("Subtraction - Underflow")
        func testSubtractionUnderflow() {
            let a = UInt24(0)
            let b = UInt24(1)
//            _ = a - b // Uncomment to validate underflow
        }
        
        // MARK: - Multiplication
        @Test("Multiplication - No Overflow")
        func testMultiplicationNoOverflow() {
            let a = UInt24(300)
            let b = UInt24(200)
            let result = a * b
            let expected = UInt24(60000)
            #expect(result == expected, "Expected \(expected), got \(result)")
        }
        
        @Test("Multiplication - Overflow")
        func testMultiplicationOverflow() {
            let a = UInt24(UInt24.max / 2 + 1)
            let b = UInt24(2)
//            _ = a * b // Uncomment to validate overflow
        }
        
        // MARK: - Division
        @Test("Division - No Division by Zero")
        func testDivisionNoZero() {
            let a = UInt24(60000)
            let b = UInt24(200)
            let result = a / b
            let expected = UInt24(300)
            #expect(result == expected, "Expected \(expected), got \(result)")
        }
        
        @Test("Division - Division by Zero")
        func testDivisionByZero() {
            let a = UInt24(12345)
            let b = UInt24(0)
//            _ = a / b // Uncomment to validate division by zero
        }
        
        // MARK: - Remainder
        @Test("Remainder - No Division by Zero")
        func testRemainderNoZero() {
            let a = UInt24(12345)
            let b = UInt24(100)
            let result = a % b
            let expected = UInt24(45)
            #expect(result == expected, "Expected \(expected), got \(result)")
        }
    }

    // MARK: Compound Operators
    struct UInt24_CompoundOperatorsTests {
        
        // MARK: - Addition Assignment
        @Test("Addition Assignment - No Overflow")
        func testAdditionAssignmentNoOverflow() {
            var a = UInt24(12345)
            let b = UInt24(54321)
            a += b
            let expected = UInt24(66666)
            #expect(a == expected, "Expected \(expected), got \(a)")
        }
        
        @Test("Addition Assignment - Overflow")
        func testAdditionAssignmentOverflow() {
            var a = UInt24(UInt24.max)
            let b = UInt24(1)
//            a += b // Uncomment to validate overflow
        }
        
        // MARK: - Subtraction Assignment
        @Test("Subtraction Assignment - No Underflow")
        func testSubtractionAssignmentNoUnderflow() {
            var a = UInt24(54321)
            let b = UInt24(12345)
            a -= b
            let expected = UInt24(41976)
            #expect(a == expected, "Expected \(expected), got \(a)")
        }
        
        @Test("Subtraction Assignment - Underflow")
        func testSubtractionAssignmentUnderflow() {
            var a = UInt24(0)
            let b = UInt24(1)
//            a -= b // Uncomment to validate underflow
        }
    }
    
    // MARK: Bitwise Operators
    struct UInt24_BitwiseOperatorsTests {
        
        // MARK: - AND
        @Test("Bitwise AND")
        func testBitwiseAND() {
            let a = UInt24(0b1100)
            let b = UInt24(0b1010)
            let result = a & b
            let expected = UInt24(0b1000)
            #expect(result == expected, "Expected \(expected), got \(result)")
        }
        
        // MARK: - OR
        @Test("Bitwise OR")
        func testBitwiseOR() {
            let a = UInt24(0b1100)
            let b = UInt24(0b1010)
            let result = a | b
            let expected = UInt24(0b1110)
            #expect(result == expected, "Expected \(expected), got \(result)")
        }
        
        // MARK: - XOR
        @Test("Bitwise XOR")
        func testBitwiseXOR() {
            let a = UInt24(0b1100)
            let b = UInt24(0b1010)
            let result = a ^ b
            let expected = UInt24(0b0110)
            #expect(result == expected, "Expected \(expected), got \(result)")
        }
        
        // MARK: - NOT
        @Test("Bitwise NOT")
        func testBitwiseNOT() {
            let a = UInt24(0b00001111)
            let result = ~a
            let expected = UInt24(0xFFFFF0) // Complement in unsigned 24-bit
            #expect(result == expected, "Expected \(expected), got \(result)")
        }
    }
    
    // MARK: Shift Operators
    struct UInt24_ShiftOperatorsTests {
        
        // MARK: - Left Shift
        @Test("Left Shift")
        func testLeftShift() {
            var a = UInt24(1)
            a <<= 3
            let expected = UInt24(8)
            #expect(a == expected, "Expected \(expected), got \(a)")
        }
        
        // MARK: - Right Shift
        @Test("Right Shift")
        func testRightShift() {
            var a = UInt24(16)
            a >>= 2
            let expected = UInt24(4)
            #expect(a == expected, "Expected \(expected), got \(a)")
        }
    }
}
