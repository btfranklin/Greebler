//  Created by B.T. Franklin on 2/10/21.

import XCTest
import CoreGraphics
import Aesthete
@testable import Greebler

final class CapitalShipWindowsGreeblesTests: XCTestCase {

    func testDraw() {
        let grayThemeColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        let graphicsContext = GreeblesTestUtil.createGraphicsContext()

        for unitSize in stride(from: CGFloat(1), through: CGFloat(100), by: 10) {
            for windowZoneCount in 1...10 {
                let capitalShipWindowsGreebles = CapitalShipWindowsGreebles(xUnits: unitSize, yUnits: unitSize, themeColor: grayThemeColor.hsbaColor, windowZoneCount: windowZoneCount)
                capitalShipWindowsGreebles.draw(on: graphicsContext)
            }
        }
    }
}
