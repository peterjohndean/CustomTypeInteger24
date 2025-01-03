//
//  Int24.swift
//  CTInteger24
//
//  Created by Peter Dean on 4/1/2025.
//

@frozen
public struct Int24 {
    // Place to hold our 24-bit value. We use the Swift.Int32 to help us out.
    private var _value: Int32 = 0
    
    public internal(set) var value: Int32 {
        get {
            // Ensure the returned Int32 is properly representing our value
            return (self._value & Int24.bit24MaskSigned != 0) ? (self._value | ~Int24.bit24Mask) : self._value
        }
        set {
            self._value = newValue & Int24.bit24Mask
        }
    }
    
    // TODO: These will need to eventually become public static var min: Self to be compliant.
    // Define our bitMasks
    public static var bit24Mask: Int32 { 0x00FF_FFFF }
    public static var bit24MaskSigned: Int32 { 0x0080_0000 }
    
    // Define our min/max values
    public static var min: Int32 { -8_388_608 }     // 2^23
    public static var max: Int32 { 8_388_607 }      // 2^23 - 1

}
