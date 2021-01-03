//  Created by B.T. Franklin on 1/2/21.

import XCTest
import CoreGraphics
import Aesthete
@testable import Greebler

final class VentGreeblesTests: XCTestCase {

    func testDraw() {
        let grayThemeColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        let graphicsContext = GreeblesTestUtil.createGraphicsContext()

        for unitSize in stride(from: CGFloat(1), through: CGFloat(1000), by: 100) {
            for ventCount in stride(from: 1, through: 100, by: 10) {
                let ventGreebles = VentGreebles(xUnits: unitSize, yUnits: unitSize, themeColor: grayThemeColor.hsbaColor, ventCount: ventCount)
                ventGreebles.draw(on: graphicsContext)
            }
        }
    }
}
