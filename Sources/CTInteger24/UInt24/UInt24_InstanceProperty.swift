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

extension UInt24 {
    public typealias Magnitude = UInt24
    public var magnitude: Self.Magnitude { UInt24(self.value) }
    
    public typealias Words = [UInt]
    public var words: Words { [UInt(self.value)] }
    
    public var description: String { "\(self.value)" }
    
    public var trailingZeroBitCount: Int {
        return self._value == 0 ? 24 : self._value.trailingZeroBitCount
    }
    
    public var nonzeroBitCount: Int {
        return self._value.nonzeroBitCount
    }
    
    public var leadingZeroBitCount: Int {
        return self._value.leadingZeroBitCount - 8
    }

    public var byteSwapped: UInt24 {
        let byte1 = UInt8(self._value & 0xFF)
        let byte2 = UInt8((self._value >> 8) & 0xFF)
        let byte3 = UInt8((self._value >> 16) & 0xFF)
        let swappedValue = UInt32(byte1) << 16 | UInt32(byte2) << 8 | UInt32(byte3)
        return UInt24(swappedValue)
    }
}
