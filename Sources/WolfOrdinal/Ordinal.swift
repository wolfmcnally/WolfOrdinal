//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

public struct Ordinal {
    public let elements: [Int]
    
    public init(_ a: Int) {
        self.init([a])
    }

    public init(_ a: [Int]) {
        self.elements = a
    }
    
    public var before: Ordinal {
        Ordinal(after: nil, before: self)
    }
    
    public var after: Ordinal {
        Ordinal(after: self, before: nil)
    }

    public init(after: Ordinal?, before: Ordinal?) {
        if let after = after {
            if let before = before {
                self.init(after: after, before: before)
            } else {
                self.init([after.elements[0] + 1])
            }
        } else if let before = before {
            self.init([before.elements[0] - 1])
        } else {
            self.init([0])
        }
    }

    private init(after ord1: Ordinal, before ord2: Ordinal) {
        var ord1 = ord1
        var ord2 = ord2
        guard ord1 != ord2 else {
            self = ord1
            return
        }
        if ord1 > ord2 {
            swap(&ord1, &ord2)
        }
        let len1 = ord1.elements.count
        let len2 = ord2.elements.count
        if len1 > len2 {
            elements = Array(ord1.elements.dropLast()) + [ord1.elements.last! + 1]
        } else if len1 < len2 {
            elements = Array(ord2.elements.dropLast()) + [ord2.elements.last! - 1]
        } else if ord2.elements.last! - ord1.elements.last! > 1 {
            elements = Array(ord1.elements.dropLast()) + [ord1.elements.last! + 1]
        } else {
            elements = ord1.elements + [1]
        }
    }
}

extension Ordinal: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }
}

extension Ordinal: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Int...) {
        if elements.isEmpty {
            self.init([0])
        } else {
            self.init(elements)
        }
    }
}

extension Ordinal: Comparable {
    public static func == (lhs: Ordinal, rhs: Ordinal) -> Bool {
        return lhs.elements == rhs.elements
    }

    public static func < (lhs: Ordinal, rhs: Ordinal) -> Bool {
        return lhs.elements.lexicographicallyPrecedes(rhs.elements)
    }
}

extension Ordinal: CustomStringConvertible {
    public var description: String {
        return "[" + (elements.map { String(describing: $0) }).joined(separator: ", ") + "]"
    }
}

extension Ordinal: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        elements = try container.decode([Int].self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(elements)
    }
}

extension Ordinal {
    public struct DecodeError: Error { }

    public var encoded: String {
        return try! String(data: JSONEncoder().encode(self), encoding: .utf8)!
    }

    public init(encoded: String) throws {
        guard let data = encoded.data(using: .utf8) else {
            throw DecodeError()
        }

        self = try JSONDecoder().decode(Ordinal.self, from: data)
    }
}

extension Ordinal {
    public static func compare(lhs: Ordinal, rhs: Ordinal) -> ComparisonResult {
        if lhs == rhs {
            return .orderedSame
        } else if lhs < rhs {
            return .orderedAscending
        } else {
            return .orderedDescending
        }
    }
}
