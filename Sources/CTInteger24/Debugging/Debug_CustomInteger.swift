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

#if DEBUG
/*
 A tool for experimenting with different bit widths, which is also evolving.
 */
struct CustomInteger {
    // Future proofing
    typealias Int = Int64
    typealias UInt = UInt64
    
    /// Integer size in bits
    @inline(__always)
    let bitWidth: Int
    
    struct Ranges {
        /// Signed bitWidth range from -(2^(n - 1)) to 2^(n - 1) - 1
        let signed: ClosedRange<Int>
        
        /// Unsigned bitWidth range from 0 to 2^n - 1
        let unsigned: ClosedRange<UInt>
    }
    
    struct Masks {
        /// Signed bitWidth mask (2^n) - 1
        let signed: Int
        
        /// Signed Bit bitWidth mask 2^(n - 1)
        let signedBit: Int
        
        /// Unsigned bitWidth mask (2^n) - 1
        let unsigned: UInt
    }
    
    let masks: Masks
    let ranges: Ranges
    
    init?(for bits: Int) {
        
        // Support for 1...64 bitWidths
        guard bits >= 1 && bits <= Int.bitWidth else {
            return nil
        }
        
        bitWidth = bits
        
        // Store signed & unsigned ranges
        ranges = Ranges(
            signed: (0 &- (1 << (bitWidth - 1)))...((1 << (bitWidth - 1)) &- 1),
            unsigned: 0...(1 << bitWidth) &- 1
        )
        
        // Store bitWidth masks
        masks = Masks(
            signed: (1 << bits) &- 1,
            signedBit: 1 << (bits &- 1),
            unsigned: (1 << bits) &- 1
        )
    }
}

// MARK: Instance Methods
extension CustomInteger {
    func isSigned<T: BinaryInteger>(_ value: T) -> Bool {
        return T.isSigned /* Unsigned always false */ && (Int(value) & masks.signedBit) != 0
    }
    
    func isInRange<T: BinaryInteger>(_ value: T) -> Bool {
        return T.isSigned
        ? ranges.signed.contains(Int(value))    // Signed
        : ranges.unsigned.contains(UInt(value)) // Unsigned
    }
    
    func isOppositeSigns<T: BinaryInteger>(lhs: T, rhs: T) -> Bool {
        return T.isSigned /* Unsigned always false */ && (lhs ^ rhs) < 0
    }
    
    func isSameSigns<T: BinaryInteger>(lhs: T, rhs: T) -> Bool {
        return !T.isSigned /* Unsigned always true */ || (lhs ^ rhs) >= 0
    }
    
    /// - Returns: true, if value `<<` by will result in a bitwise overflow.
    func leftShiftReportingOverflow<T: BinaryInteger>(_ value: T, by shift: T) -> Bool {
        guard value != 0 && shift > 0 else {
            return false // No overflow
        }
        
        // Adjust bitWidth for signed or unsigned data types.
        let adjustedBitWidth = T.isSigned
        ? bitWidth - 1  // Signed
        : bitWidth      // Unsigned
        
        return shift >= adjustedBitWidth /* Shifts >= bitWidth */ || (value >> (T(adjustedBitWidth) - shift)) != 0 /* Shifts < bitWidth */
    }
    
    func additionReportOverflow<T: BinaryInteger>(lhs: T, rhs: T) -> Bool {
        if T.isSigned {
            let lhs = Int(lhs)
            let rhs = Int(rhs)
            
            // Overflow logic for signed integers
            if (lhs ^ rhs) >= 0 /* lhs & rhs have same signs */ {
                if lhs < ranges.signed.lowerBound - rhs {
                    return true // Negative overflow (lhs < min - rhs)
                } else if lhs > ranges.signed.upperBound - rhs {
                    return true // Positive overflow (lhs > max - rhs)
                }
            }
            return false // No overflow
        } else {
            // Overflow logic for unsigned integers
            return (rhs > (T(ranges.unsigned.upperBound) - lhs)) // rhs > (max - lhs)
        }
    }
    
    func subtractionReportOverflow<T: BinaryInteger>(lhs: T, rhs: T) -> Bool {
        if T.isSigned {
            let lhs = Int(lhs)
            let rhs = Int(rhs)
            
            // Overflow logic for signed integers
            if (lhs ^ rhs) < 0 /* opposite signs */ {
                if lhs & masks.signedBit != 0 {
                    return lhs < ranges.signed.lowerBound + rhs // Negative overflow (lhs < min + rhs)
                } else {
                    return lhs > ranges.signed.upperBound + rhs // Positive overflow (lhs > max + rhs)
                }
            }
            return false // No overflow
        } else {
            // Overflow logic for unsigned integers
            return lhs < rhs // lhs < rhs -> Negative result -> Overflow
        }
    }
    
    /// - Returns: true, if lhs `*` rhs will result in an arithmetic overflow.
    func multiplicationReportOverflow<T: BinaryInteger>(lhs: T, rhs: T) -> Bool {
        guard lhs != 0 && rhs != 0 else {
            return false // Multiplication by zero
        }
        
        if T.isSigned {
            // Overflow logic for signed integers
            let lhs = Int(lhs)
            let rhs = Int(rhs)
            
            if (lhs ^ rhs) >= 0 { // Same signs
                if ((lhs > 0 && rhs > 0 && lhs > ranges.signed.upperBound / rhs) || // Positive * Positive
                    (lhs < 0 && rhs < 0 && lhs < ranges.signed.upperBound / rhs)) { // Negative * Negative
                    return true; // Overflow
                }
            } else { // Opposite signs
                if ((lhs > 0 && rhs < 0 && lhs > ranges.signed.lowerBound / rhs) || // Positive * Negative
                    (lhs < 0 && rhs > 0 && lhs < ranges.signed.lowerBound / rhs)) { // Negative * Positive
                    return true; // Overflow
                }
            }
            
            return false; // No overflow
            
        } else {
            // Overflow logic for unsigned integers
            let rhs = UInt(rhs)
            return lhs > ranges.unsigned.upperBound / rhs
        }
    }
    
    /// - Returns: true, if lhs `/` rhs will result in an arithmetic overflow.
    func divisionReportOverflow<T: BinaryInteger>(lhs: T, rhs: T) -> Bool {
        guard rhs != 0 else {
            return true // Division by zero check
        }
        
        if T.isSigned {
            // Overflow logic for signed integers
            let lhs = Int(lhs)
            let rhs = Int(rhs)
            
            // Overflow occurs when dividing the minimum signed value by -1.
            // i.e. For 8 bit, -128 * -1 = +128 > than 8-bit max of 127.
            if lhs == ranges.signed.lowerBound && rhs == -1 {
                return true
            }
            
            return false // No overflow
            
        } else {
            // Overflow logic for unsigned integers
            return false
        }
    }
}
#endif
