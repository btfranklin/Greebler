//  Created by B.T. Franklin on 2/10/21.

import XCTest
import CoreGraphics
import Aesthete
@testable import Greebler

final class CapitalShipSurfaceGreeblesTests: XCTestCase {

    func testDraw() {
        let grayThemeColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        let graphicsContext = GreeblesTestUtil.createGraphicsContext()

        for unitSize in stride(from: CGFloat(1), through: CGFloat(100), by: 10) {
            let capitalShipSurfaceGreebles = CapitalShipSurfaceGreebles(xUnits: unitSize, yUnits: unitSize, themeColor: grayThemeColor.hsbaColor)
            capitalShipSurfaceGreebles.draw(on: graphicsContext)
        }
    }
}
