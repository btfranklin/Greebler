//  Created by B.T. Franklin on 2/10/21.

import XCTest
import CoreGraphics
import Aesthete
@testable import Greebler

final class PipeGreeblesTests: XCTestCase {

    func testDraw() {
        let grayThemeColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        let graphicsContext = GreeblesTestUtil.createGraphicsContext()

        for unitSize in stride(from: CGFloat(1), through: CGFloat(1000), by: 100) {
            for pipeCount in stride(from: 1, through: 100, by: 10) {
                let pipeGreebles = PipeGreebles(xUnits: unitSize, yUnits: unitSize, themeColor: grayThemeColor.hsbaColor, pipeCount: pipeCount, allowOffSide: false)
                pipeGreebles.draw(on: graphicsContext)
            }
        }
    }

    func testDrawAllowOffSide() {
        let grayThemeColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        let graphicsContext = GreeblesTestUtil.createGraphicsContext()

        for unitSize in stride(from: CGFloat(1), through: CGFloat(1000), by: 100) {
            for pipeCount in stride(from: 1, through: 100, by: 10) {
                let pipeGreebles = PipeGreebles(xUnits: unitSize, yUnits: unitSize, themeColor: grayThemeColor.hsbaColor, pipeCount: pipeCount, allowOffSide: true)
                pipeGreebles.draw(on: graphicsContext)
            }
        }
    }

}
