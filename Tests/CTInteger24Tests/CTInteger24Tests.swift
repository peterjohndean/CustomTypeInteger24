import Testing
import Foundation

@testable import CTInteger24

@Test("Initialisation")
func initialise_tests() async throws {
    
    #expect(Int24().value == 0)
    #expect(Int24((UInt24.max + 1) / 2 - 1).value == 8388607)
    
    #expect(UInt24().value == 0)
    #expect(UInt24((Int24.max + 1) / 2 - 1).value == 4194303)
    
    var a = Int24()
    print(a)
    a = Int24((UInt24.max + 1) / 2 - 1)
    print(a)
    
    var b = UInt24(1234)
    print(b)
    
    b = UInt24((Int24.max + 1) / 2 - 1)
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
