//
//  UInt24.swift
//  CTInteger24
//
//  Created by Peter Dean on 4/1/2025.
//

@frozen
public struct UInt24 {
    // Place to hold our 24-bit value. We use the Swift.UInt32 to help us out.
    private var _value: UInt32 = 0
    
    public internal(set) var value: UInt32 {
        get {
            return self._value
        }
        set {
            self._value = newValue & UInt24.bit24Mask
        }
    }
    
    // TODO: These will need to eventually become public static var min: Self to be compliant.
    // Define our bitMasks
    public static var bit24Mask: UInt32 { 0x00FF_FFFF }
    
    // Define our min/max values
    public static var min: UInt32 { 0 }            // 0
    public static var max: UInt32 { 16_777_215 }   // 2^24 - 1

}
