//
//  UInt24_Initialisers.swift
//  CTInteger24
//
//  Created by Peter Dean on 4/1/2025.
//

extension UInt24 {
    // MARK: Initialisers for FixedWidthInteger
    public init<T: FixedWidthInteger>(_ value: T) {
        precondition(
            value >= UInt24.min && value <= UInt24.max,
            "\(value) is outside the representable range of UInt24 (\(UInt24.min)...\(UInt24.max))."
        )
        self.value = UInt32(value)
    }
}
