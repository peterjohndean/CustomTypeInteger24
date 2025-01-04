import Testing
import Foundation

@testable import CTInteger24

@Test("Initialisation")
func initialise_tests() async throws {
    // Note: Before protocol Comparable
    #expect(Int24().value == 0)
    #expect(Int24((UInt24.maxInt + 1) / 2 - 1).value == 8388607)
    
    #expect(UInt24().value == 0)
    #expect(UInt24((Int24.maxInt + 1) / 2 - 1).value == 4194303)
    
    var a = Int24()
    a = Int24((UInt24.maxInt + 1) / 2 - 1)
    
    var b = UInt24(1234)
    b = UInt24((Int24.maxInt + 1) / 2 - 1)
    
    #expect(a.description == "\(a)")
    #expect(b.description == "\(b)")
    
    #expect(Int24() == 0)
    #expect(UInt24() == 0)
    
    #expect("\(type(of: a))" == "Int24")
    #expect("\(type(of: b))" == "UInt24")
    
    // ExpressibleByIntegerLiteral
    let a2: Int24 = 1234
    let b2: UInt24 = 4321
    #expect(a2.value == 1234)
    #expect(b2.value == 4321)
    
    // ExpressibleByFloatLiteral
    let a3: Int24 = 123.456
    let b3: UInt24 = 432.123
    #expect(a3.value == Int24(123.456).value)
    #expect(b3.value == Int24(432.123).value)
}

@Test("Comparable")
func comparable_tests() async throws {
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
//    #expect(UInt8(13) != a3)
//    #expect(a3 != UInt8(13))
//    #expect(a3 <= UInt8(13))
//    #expect(UInt8(13) != b3)
//    #expect(b3 != UInt8(13))
//    #expect(b3 <= UInt16(13))
//    
//    #expect(a1 == b1)
//    #expect(a1 < b2)
//    #expect(a2 > b1)
//    #expect(a1 <= b2)
//    #expect(a2 >= b1)
//    
//    #expect(b1 == a1)
//    #expect(b1 < a2)
//    #expect(b2 > a1)
//    #expect(b1 <= a2)
//    #expect(b2 >= a1)
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
