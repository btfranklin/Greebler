//  Created by B.T. Franklin on 12/25/20.

import XCTest
import CoreGraphics
import Aesthete
@testable import Greebler

final class HoseGreeblesTests: XCTestCase {

    func testDraw() {
        let grayThemeColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        let graphicsContext = GreeblesTestUtil.createGraphicsContext()

        let hoseGreebles = HoseGreebles(xUnits: 3, themeColor: grayThemeColor.hsbaColor, hoseCount: 3, allowOffSide: false)
        hoseGreebles.draw(on: graphicsContext)
    }
}
