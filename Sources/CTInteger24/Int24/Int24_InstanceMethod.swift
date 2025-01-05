//
//  Int24_InstanceMethods.swift
//  CTInteger24
//
//  Created by Peter Dean on 6/1/2025.
//

extension Int24 {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.value)
    }
    
    public func addingReportingOverflow(_ rhs: Int24) -> (partialValue: Int24, overflow: Bool) {
        let result = self.value + rhs.value
        guard result >= Int24.minInt && result <= Int24.maxInt else {
            return (Self(0), true)  // Overflow
        }
        return (Self(result), false)
    }
    
    public func subtractingReportingOverflow(_ rhs: Int24) -> (partialValue: Int24, overflow: Bool) {
        let result = self.value - rhs.value
        guard result >= Int24.minInt && result <= Int24.maxInt else {
            return (Self(0), true)  // Overflow
        }
        return (Self(result), false)
    }
    
    public func multipliedReportingOverflow(by rhs: Int24) -> (partialValue: Int24, overflow: Bool) {
        let result = self.value * rhs.value
        guard result >= Int24.minInt && result <= Int24.maxInt else {
            return (Self(0), true)  // Overflow
        }
        return (Self(result), false)
    }
    
    public func dividedReportingOverflow(by rhs: Int24) -> (partialValue: Int24, overflow: Bool) {
        guard rhs != 0 else {
            return (Self(0), true)  // Division by zero
        }
        let result = self.value / rhs.value
        guard result >= Int24.minInt && result <= Int24.maxInt else {
            return (Self(0), true)  // Overflow
        }
        return (Self(result), false)
    }
    
    public func remainderReportingOverflow(dividingBy rhs: Int24) -> (partialValue: Int24, overflow: Bool) {
        guard rhs != 0 else {
            return (Self(0), true)  // Division by zero
        }
        let result = self.value % rhs.value
        return (Self(result), false)  // No overflow for remainder
    }
    
    public func dividingFullWidth(_ dividend: (high: Int24, low: Int24.Magnitude)) -> (quotient: Int24, remainder: Int24) {
        let fullValue = (Int64(dividend.high.value) << 32) | Int64(dividend.low)
        let divisor = Int64(self.value)
        
        let quotient = fullValue / divisor
        let remainder = fullValue % divisor
        
        guard quotient >= Int24.minInt && quotient <= Int24.maxInt else {
            fatalError("Overflow occurred during full-width division")
        }
        
        return (Self(quotient), Self(remainder))
    }

}
