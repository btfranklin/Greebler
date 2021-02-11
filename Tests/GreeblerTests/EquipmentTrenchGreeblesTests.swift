//  Created by B.T. Franklin on 2/10/21.

import XCTest
import CoreGraphics
import Aesthete
@testable import Greebler

final class EquipmentTrenchGreeblesTests: XCTestCase {

    func testDraw() {
        let grayThemeColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        let graphicsContext = GreeblesTestUtil.createGraphicsContext()

        for unitSize in stride(from: CGFloat(1), through: CGFloat(10), by: 1) {
            for trenchWidth in stride(from: CGFloat(1), through: CGFloat(3), by: 1) {
                let equipmentTrenchGreebles = EquipmentTrenchGreebles(xUnits: unitSize, yUnits: unitSize, themeColor: grayThemeColor.hsbaColor, trenchWidth: trenchWidth)
                equipmentTrenchGreebles.draw(on: graphicsContext)
            }
        }
    }
}
