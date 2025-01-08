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

import Testing

@testable import CTInteger24

struct UInt24_OverflowTests {
    @Test
    func testAddingReportingOverflow() {
        let a = UInt24(UInt24.maxInt)
        let b = UInt24(1)
        let c = UInt24(0)
        
        #expect(a.addingReportingOverflow(b).overflow == true) // Overflow on addition
        #expect(a.addingReportingOverflow(c).overflow == false)
        #expect(a.addingReportingOverflow(c).partialValue == UInt24(UInt24.maxInt))
        #expect(c.addingReportingOverflow(a).partialValue == UInt24(UInt24.maxInt))
        
        let zero = UInt24(0)
        #expect(zero.addingReportingOverflow(zero).partialValue == zero)
        #expect(zero.addingReportingOverflow(zero).overflow == false)
    }
    
    @Test
    func testSubtractingReportingOverflow() {
        let a = UInt24(UInt24.minInt) // Minimum value is 0 for UInt24
        let b = UInt24(1)
        
        #expect(a.subtractingReportingOverflow(b).overflow == true) // Underflow on subtraction
        #expect(a.subtractingReportingOverflow(b).partialValue == UInt24(UInt24.maxInt)) // Wrap-around behavior
        
        let c = UInt24(0)
        #expect(c.subtractingReportingOverflow(c).partialValue == UInt24(0))
        #expect(c.subtractingReportingOverflow(c).overflow == false)
    }
    
    @Test
    func testMultipliedReportingOverflow() {
        let a = UInt24(UInt24.maxInt)
        let b = UInt24(2)
        let c = UInt24(1)
        
        #expect(a.multipliedReportingOverflow(by: b).overflow == true) // Overflow on multiplication
        #expect(a.multipliedReportingOverflow(by: c).partialValue == a)
        #expect(a.multipliedReportingOverflow(by: UInt24(0)).partialValue == UInt24(0))
    }
    
    @Test
    func testDividedReportingOverflow() {
        let a = UInt24(UInt24.maxInt)
        let b = UInt24(1)
        let c = UInt24(0)
        
        #expect(a.dividedReportingOverflow(by: b).partialValue == a)
        #expect(a.dividedReportingOverflow(by: c).overflow == true) // Division by zero
    }
    
    @Test
    func testRemainderReportingOverflow() {
        let a = UInt24(UInt24.maxInt)
        let b = UInt24(2)
        let c = UInt24(0)
        
        #expect(a.remainderReportingOverflow(dividingBy: b).partialValue == UInt24(1)) // Remainder test
        #expect(a.remainderReportingOverflow(dividingBy: c).overflow == true) // Division by zero
    }
    
    @Test
    func testDividingFullWidthNoOverflow() {
        let a = UInt24(7)
        let high: UInt24 = 0
        let low: UInt24 = 21
        
        let result = a.dividingFullWidth((high: high, low: low))
        
        #expect(result.quotient.value == 3)  // Correct quotient
        #expect(result.remainder.value == 0) // Correct remainder
        
        let resultBig = UInt24(10).dividingFullWidth(
            (
                high: UInt24(10_000 >> UInt24.bitWidth),    // High part of the negative number
                low: UInt24(10_000 & Int24.maskInt)         // Low part of the number
            )
        )
        #expect(resultBig.quotient.value == 1_000)  // Ensure quotient is computed correctly
        #expect(resultBig.remainder.value == 0) // Ensure remainder is valid
    }
    
    @Test
    func testDividingFullWidthWithOverflow() {
//        let a = UInt24(3)
//        let high = UInt24(100_000_000 >> Int24.bitWidth)
//        let low = UInt24(100_000_000 & Int24.maskInt)
//        
//        let result = a.dividingFullWidth((high: high, low: low))
    }
}
