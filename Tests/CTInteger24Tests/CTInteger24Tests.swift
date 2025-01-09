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
import Foundation

@testable import CTInteger24

extension FixedWidthInteger {
    var binaryString: String {
        var result: [String] = []
        for i in 0..<(Self.bitWidth / 8) {
            let byte = UInt8(truncatingIfNeeded: self >> (i * 8))
            let byteString = String(byte, radix: 2)
            let padding = String(repeating: "0",
                                 count: 8 - byteString.count)
            result.append(padding + byteString)
        }
        return "0b" + result.reversed().joined(separator: "_")
    }
}


@Test func q0() async throws {
    let a0 = Int24(bitPattern: UInt24(UInt24.max))
    #expect(a0.value == -1)
    print(a0, a0.value, a0.valueRaw)
    
    let a1 = UInt24(bitPattern: Int24(Int24.min))
    #expect(a1.value == 8388608)
    print(a1, a1.value, a1.valueRaw)
    
    print(Int24.min.binaryString)
    print(Int24.max.binaryString)
    
    print((101 as UInt24).binaryString)
    
    print(Int24(1) != UInt32(0))
    print(Int32(-1) != Int24(-2))
    print(Int24(3.12) == 3)
    
    let minValue = Int24(Int24.min)
    #expect(Int24.min == minValue.value)
    #expect(minValue.value == Int24.min)
    #expect(Int24.min == Float(-8388608))
    #expect(Float(-8388608) == Int24.min)
}

@Test func quickie() async throws {
    
    var a1: Int24 = 1234
    var a2: Int24 = 1234
    
    a1 = a1 - a2
    a1 = a1 + 2
    #expect(a1 == 2)
    
    var b1: UInt24 = 1234
    let b2: UInt24 = 1234
    
    b1 = b1 - b2
    b1 = b1 + 2
    #expect(b1 == 2)
    
    _ = a1 = 1
    _ = a2 = 0
    _ = a1 % 1
    _ = a1 / 1
    _ = a1 %= 1
    _ = a1 /= 1
    print(a1, ~a1)
    #expect(a1 == 0)
    #expect(a2 <= 0)
}

@Test("Initialise")
func initialise_tests() async throws {
    // Note: Before protocol Comparable
    #expect(Int24() == 0)
    #expect(Int24((UInt24.maxInt + 1) / 2 - 1).value == 8388607)
    
    #expect(UInt24().value == 0)
    #expect(UInt24((Int24.maxInt + 1) / 2 - 1).value == 4194303)
    
    let a: Int24 = 1234
    
//    var b = UInt24(1234)
//    b = UInt24((Int24.maxInt + 1) / 2 - 1)
    
    #expect(a.description == "\(a)")
//    #expect(b.description == "\(b)")
//    
    #expect(Int24() == 0)
    #expect(UInt24() == 0)
//    
    #expect("\(type(of: a))" == "Int24")
//    #expect("\(type(of: b))" == "UInt24")
//    
//    // ExpressibleByIntegerLiteral
    let a2: Int24 = 1234
//    let b2: UInt24 = 4321
    #expect(a2.value == 1234)
//    #expect(b2.value == 4321)
//    
//    // ExpressibleByFloatLiteral
    let a3: Int24 = 123.456
//    let b3: UInt24 = 432.123
    #expect(a3.value == Int24(123.456).value)
//    #expect(b3.value == Int24(432.123).value)
}

@Test("Comparable") func comparable_tests() async throws {
    // When I added he Comparable protocol, it only required == and < operands.
    let a1: Int24 = 1
    let a2: Int24 = 2
    let a3: Int24 = 3.14159265358979323846
    #expect(a1 < a2)
    #expect(a2 > a1)
    #expect(a1 <= a2)
    #expect(a2 >= a1)
    #expect(a3 == 3)
    #expect(a3 != 3.5)
    #expect(Int24(3) == 3)
    
    let b1: UInt24 = 1
    let b2: UInt24 = 2
    let b3: UInt24 = 3.14159265358979323846
    #expect(b1 < b2)
    #expect(b2 > b1)
    #expect(b1 <= b2)
    #expect(b2 >= b1)
    #expect(b3 == 3)
    #expect(b3 != 3.5)
    #expect(UInt24(3) == 3)
    
    // Other Interchangable operands of other types need to be included.
    #expect(UInt8(13) != a3)
    #expect(a3 != UInt8(13))
    #expect(a3 <= UInt16(13))
    #expect(UInt8(13) != b3)
    #expect(b3 != UInt8(13))
    #expect(b3 <= UInt16(13))
    
    #expect(a1 == b1)
    #expect(a1 < b2)
    #expect(a2 > b1)
    #expect(a1 <= b2)
    #expect(a2 >= b1)
    #expect(a2 != b1)
//
    #expect(b1 == a1)
    #expect(b1 < a2)
    #expect(b2 > a1)
    #expect(b1 <= a2)
    #expect(b2 >= a1)
    #expect(b2 != a1)
}

@Test("AdditiveArithmetic")
func additiveArithmetic_tests() async throws {
    var a1: Int24 = 1
    var a2: Int24 = 2
    a1 += a2
    #expect(a1 == 3)
    
    a1 -= 1
    #expect(a1 == 2)
    
    a2 = a2 + 1
    #expect(a2 == 3)
    
    var b1: UInt24 = 1
    var b2: UInt24 = 2
    b1 += b2
    #expect(b1 == 3)
    
    b1 -= 1
    #expect(b1 == 2)
    
    b2 = b2 + 1
    #expect(b2 == 3)
}

@Test("Numeric")
func numeric_tests() async throws {
    var a1: Int24 = 2
    let a2: Int24 = 3
    
    a1 *= a2
    #expect(a1 == 6)
    
    a1 = a1 * 2
    #expect(a1 == 12)
    
    a1 = -101
    #expect(a1.magnitude == 101)
    
    var b1: UInt24 = 2
    let b2: UInt24 = 3
    
    b1 *= b2
    #expect(b1 == 6)
    
    b1 = b1 * 2
    #expect(b1 == 12)
    
    
    b1 = 101
    #expect(b1.magnitude == 101)
}

@Test("BinaryInteger")
func binaryInteger_tests() async throws {
    let a1: Int24 = 10
    let a2: Int24 = 11
    let a3: Int24 = Int24(clamping: Int32.min)
    
    #expect(a3 == -8388608)
    #expect(a1 & a2 == 10)
    #expect(a1 | a2 == 11)
    #expect(a1 ^ a2 == 1)
    #expect(a1 % a2 == 10)
    #expect(a1 / a2 == 0)
    #expect(a1 << 1 == 20)
    #expect(a1 >> 1 == 5)
    #expect(~a1 == -11)
    
    #expect(Int24(8).trailingZeroBitCount == 3)
    #expect(Int24(Int24.minInt).trailingZeroBitCount == 23)
    #expect(Int24().trailingZeroBitCount == 24)
    
    let b1: UInt24 = 10
    let b2: UInt24 = 11
    let b3: UInt24 = UInt24(clamping: UInt32.max)
    
    #expect(b3 == 16777215)
    #expect(b1 & b2 == 10)
    #expect(b1 | b2 == 11)
    #expect(b1 ^ b2 == 1)
    #expect(b1 % b2 == 10)
    #expect(b1 / b2 == 0)
    #expect(b1 << 1 == 20)
    #expect(b1 >> 1 == 5)
    #expect(~b1 == 16777205)
    
    #expect(UInt24(8).trailingZeroBitCount == 3)
    #expect(UInt24(UInt24.maxInt).trailingZeroBitCount == 0)
    #expect(UInt24().trailingZeroBitCount == 24)
}
