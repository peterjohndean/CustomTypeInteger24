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
    print(a)
    a = Int24((UInt24.maxInt + 1) / 2 - 1)
    print(a)
    
    var b = UInt24(1234)
    print(b)
    
    b = UInt24((Int24.maxInt + 1) / 2 - 1)
    print(b)
    
    #expect(a.description == "\(a)")
    #expect(b.description == "\(b)")
    
    print(String("Zero -> \(Int24())"))
    
    #expect("\(type(of: a))" == "Int24")
    #expect("\(type(of: b))" == "UInt24")
    
    // ExpressibleByIntegerLiteral
    let a2: Int24 = 1234
    let b2: UInt24 = 4321
    #expect(a2.value == 1234)
    #expect(b2.value == 4321)
    print(a2)
    print(b2)
    
    // ExpressibleByFloatLiteral
    let a3: Int24 = 123.456
    let b3: UInt24 = 432.123
    #expect(a3.value == Int24(123.456).value)
    #expect(b3.value == Int24(432.123).value)
    print(a3)
    print(b3)
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
    
    // Interchangable operands of other types need to be included.
    //#expect(a1 != b1)
}
