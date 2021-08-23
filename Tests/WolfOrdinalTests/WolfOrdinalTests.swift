import XCTest
import WolfBase
import WolfOrdinal

final class WolfOrdinalTests: XCTestCase {
    func test1() throws {
        XCTAssertEqual(Ordinal(), [0])
        XCTAssertEqual(Ordinal(1), [1])
        XCTAssertEqual(Ordinal([1, 2, 3]), [1, 2, 3])
        let a: Ordinal = 2
        XCTAssertEqual(a, [2])
    }
    
    func test2() {
        XCTAssertEqual(Ordinal().before, [-1])
        XCTAssertEqual(Ordinal().after, [1])
        XCTAssertEqual(Ordinal([1, 2, 3]).before, [0])
        XCTAssertEqual(Ordinal([1, 2, 3]).after, [2])
    }
    
    func testEqual() {
        let a: Ordinal = [1, 2, 3]
        XCTAssertEqual(Ordinal(after: a, before: a), a)
    }
    
    func testInOrder() {
        let a: Ordinal = [1, 2, 3]
        let b: Ordinal = [1, 2, 4]
        let c = Ordinal(after: a, before: b)
        XCTAssertEqual(c, [1, 2, 3, 1])
        let d = Ordinal(after: c, before: b)
        XCTAssertEqual(d, [1, 2, 3, 2])
    }
    
    func testOutOfOrder() {
        let a: Ordinal = [1, 2, 3]
        let b: Ordinal = [1, 2, 4]
        let c = Ordinal(after: b, before: a)
        XCTAssertEqual(c, [1, 2, 3, 1])
    }
    
    func testLongerFirst() {
        let a: Ordinal = [1, 1, 3]
        let b: Ordinal = [1, 2]
        let c = Ordinal(after: a, before: b)
        XCTAssertEqual(c, [1, 1, 4])
        XCTAssert(a < c)
        XCTAssert(c < b)
    }
    
    func testLongerSecond() {
        let a: Ordinal = [1, 1]
        let b: Ordinal = [1, 2, 3]
        let c = Ordinal(after: a, before: b)
        XCTAssertEqual(c, [1, 2, 2])
        XCTAssert(a < c)
        XCTAssert(c < b)
    }
}
