//
//  UInt24_Initialisers.swift
//  CTInteger24
//
//  Created by Peter Dean on 4/1/2025.
//

extension UInt24: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    // MARK: Initialisers for literal types
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)    // let a: UInt24 = 123456
    }
    
    public init(floatLiteral value: FloatLiteralType) {
        self.init(value)    // let a: UInt24 = 123.456
    }
    
    // MARK: Initialisers for FixedWidthInteger
    public init<T: FixedWidthInteger>(_ value: T) {
        precondition(
            value >= UInt24.min && value <= UInt24.max,
            "\(value) is outside the representable range of UInt24 (\(UInt24.min)...\(UInt24.max))."
        )
        self.value = UInt32(value)
    }
    
    // MARK: Initialisers for BinaryFloatingPoint
    public init<T: BinaryFloatingPoint>(_ value: T) {
        let roundedValue = UInt32(value.rounded())
        precondition(
            roundedValue >= UInt24.min && roundedValue <= UInt24.max,
            "\(roundedValue) is outside the representable range of UInt24 (\(UInt24.min)...\(UInt24.max))."
        )
        self.value = roundedValue
    }
}
