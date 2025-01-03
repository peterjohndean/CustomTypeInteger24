//
//  Int24_Initialisers.swift
//  CTInteger24
//
//  Created by Peter Dean on 4/1/2025.
//

extension Int24: ExpressibleByIntegerLiteral {
    // MARK: Initialisers for literal types
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)    // let a: Int24 = 123456
    }

    // MARK: Initialisers for FixedWidthInteger
    public init<T: FixedWidthInteger>(_ value: T) {
        precondition(
            value >= Int24.min && value <= Int24.max,
            "\(value) is outside the representable range of Int24 (\(Int24.min)...\(Int24.max))."
        )
        self.value = Int32(value)
    }
}
