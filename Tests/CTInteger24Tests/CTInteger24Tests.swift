import Testing
import Foundation

@testable import CTInteger24

@Test func initialise_tests() async throws {
    
    var a = Int24()
    print(a)
    
    a = Int24((UInt24.max + 1) / 2 - 1)
    print(a)
    
    var b = UInt24(1234)
    print(b)
    
    b = UInt24((Int24.max + 1) / 2 - 1)
    print(b)
    
    print(type(of: a))
    print(type(of: b))
    
    // ExpressibleByIntegerLiteral
    let a2: Int24 = 1234
    print(a2)
    
    let b2: UInt24 = 4321
    print(b2)
}
