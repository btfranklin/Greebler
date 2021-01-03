//  Created by B.T. Franklin on 1/2/21.

import XCTest
import CoreGraphics
import Aesthete
@testable import Greebler

final class WireGreeblesTests: XCTestCase {

    func testDraw() {
        let graphicsContext = GreeblesTestUtil.createGraphicsContext()

        for unitSize in stride(from: CGFloat(1), through: CGFloat(1000), by: 100) {
            for wireCount in stride(from: 1, through: 100, by: 10) {
                let wireGreebles = WireGreebles(xUnits: unitSize, yUnits: unitSize, wireCount: wireCount, allowOffSide: false)
                wireGreebles.draw(on: graphicsContext)
            }
        }

        for unitSize in stride(from: CGFloat(1), through: CGFloat(1000), by: 100) {
            for endPointPairCount in stride(from: 1, through: 100, by: 10) {
                let wireGreebles = WireGreebles(xUnits: unitSize, yUnits: unitSize, wireCount: 100, endPointPairCount: endPointPairCount, allowOffSide: false)
                wireGreebles.draw(on: graphicsContext)
            }
        }
    }

    func testDrawAllowOffSide() {
        let graphicsContext = GreeblesTestUtil.createGraphicsContext()

        for unitSize in stride(from: CGFloat(1), through: CGFloat(1000), by: 100) {
            for wireCount in stride(from: 1, through: 100, by: 10) {
                let wireGreebles = WireGreebles(xUnits: unitSize, yUnits: unitSize, wireCount: wireCount, allowOffSide: true)
                wireGreebles.draw(on: graphicsContext)
            }
        }

        for unitSize in stride(from: CGFloat(1), through: CGFloat(1000), by: 100) {
            for endPointPairCount in stride(from: 1, through: 100, by: 10) {
                let wireGreebles = WireGreebles(xUnits: unitSize, yUnits: unitSize, wireCount: 100, endPointPairCount: endPointPairCount, allowOffSide: true)
                wireGreebles.draw(on: graphicsContext)
            }
        }
    }

}
