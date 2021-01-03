//  Created by B.T. Franklin on 12/25/20.

import XCTest
import CoreGraphics
import Aesthete
@testable import Greebler

final class HoseGreeblesTests: XCTestCase {

    func testDraw() {
        let grayThemeColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        let graphicsContext = GreeblesTestUtil.createGraphicsContext()

        for unitSize in stride(from: CGFloat(1), through: CGFloat(1000), by: 100) {
            for hoseCount in stride(from: 1, through: 100, by: 10) {
                let hoseGreebles = HoseGreebles(xUnits: unitSize, yUnits: unitSize, themeColor: grayThemeColor.hsbaColor, hoseCount: hoseCount, allowOffSide: false)
                hoseGreebles.draw(on: graphicsContext)
            }
        }
    }

    func testDrawAllowOffSide() {
        let grayThemeColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        let graphicsContext = GreeblesTestUtil.createGraphicsContext()

        for unitSize in stride(from: CGFloat(1), through: CGFloat(1000), by: 100) {
            for hoseCount in stride(from: 1, through: 100, by: 10) {
                let hoseGreebles = HoseGreebles(xUnits: unitSize, yUnits: unitSize, themeColor: grayThemeColor.hsbaColor, hoseCount: hoseCount, allowOffSide: true)
                hoseGreebles.draw(on: graphicsContext)
            }
        }
    }

}
