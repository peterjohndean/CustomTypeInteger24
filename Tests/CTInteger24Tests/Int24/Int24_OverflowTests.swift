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

struct Int24_OverflowTests {
    
    @Test
    func testAddingReportingOverflow() {
        let a = Int24(Int24.maxInt)
        let b = Int24(1)
        let c = Int24(-1)
        
        #expect(a.addingReportingOverflow(b).overflow == true)
        #expect(a.addingReportingOverflow(c).overflow == false)
        #expect(a.addingReportingOverflow(c).partialValue == Int24(Int24.maxInt - 1))
        #expect(c.addingReportingOverflow(a).partialValue == Int24(Int24.maxInt - 1))
        
        let zero = Int24(0)
        #expect(zero.addingReportingOverflow(zero).partialValue == zero)
        #expect(zero.addingReportingOverflow(zero).overflow == false)
    }
    
    @Test
    func testSubtractingReportingOverflow() {
        let a = Int24(Int24.min)
        let b = Int24(-1)
        let c = Int24(1)
        
        #expect(a.subtractingReportingOverflow(b).overflow == false)
        #expect(a.subtractingReportingOverflow(c).overflow == true)
        #expect(a.subtractingReportingOverflow(b).partialValue == Int24(Int24.minInt + 1))
        
        let zero = Int24(0)
        #expect(zero.subtractingReportingOverflow(zero).partialValue == zero)
        #expect(zero.subtractingReportingOverflow(zero).overflow == false)
    }
    
    @Test
    func testMultipliedReportingOverflow() {
        let a = Int24(Int24.maxInt)
        let b = Int24(2)
        
        #expect(a.multipliedReportingOverflow(by: b).overflow == true)
        #expect(a.multipliedReportingOverflow(by: Int24(0)).partialValue == Int24(0))
        #expect(a.multipliedReportingOverflow(by: Int24(1)).partialValue == a)
        
        let neg = Int24(-1)
        #expect(a.multipliedReportingOverflow(by: neg).partialValue == Int24(-Int24.maxInt))
    }
    
    @Test
    func testDividedReportingOverflow() {
        let a = Int24(Int24.maxInt)
        let b = Int24(1)
        let c = Int24(0)
        
        #expect(a.dividedReportingOverflow(by: b).partialValue == a)
        #expect(a.dividedReportingOverflow(by: Int24(-1)).partialValue == Int24(-Int24.maxInt))
        #expect(a.dividedReportingOverflow(by: c).overflow == true)
    }
    
    @Test
    func testRemainderReportingOverflow() {
        let a = Int24(Int24.maxInt)
        let b = Int24(2)
        let c = Int24(0)
        
        #expect(a.remainderReportingOverflow(dividingBy: b).partialValue == Int24(1))
        #expect(a.remainderReportingOverflow(dividingBy: c).overflow == true)
    }
    
    @Test
    func testDividingFullWidthNoOverflow() {
        let a = Int24(7)
        let high: Int24 = 0
        let low: UInt24 = 21
        
        let result = a.dividingFullWidth((high: high, low: low))
        
        #expect(result.quotient.value == 3)  // Correct quotient
        #expect(result.remainder.value == 0) // Correct remainder
        
        let resultBig = Int24(10).dividingFullWidth(
            (
                high: Int24(-10_000 >> Int24.bitWidth),  // High part of the negative number
                low: UInt24(abs(-10_000 & Int24.maskInt))  // Low part of the number
            )
        )
        
        #expect(resultBig.quotient.value == -1_000)  // The expected result
        #expect(resultBig.remainder.value == 0)     // No remainder
    }
    
    @Test
    func testDividingFullWidthWithOverflow() {
//        let a = Int24(7)
//        let high = Int24(-100_000_000 >> Int24.bitWidth)
//        let low = UInt24(abs(-100_000_000 & Int24.maskInt))
//        
//        let result = a.dividingFullWidth((high: high, low: low))
    }
}
