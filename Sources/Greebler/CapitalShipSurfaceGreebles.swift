//  Created by B.T. Franklin on 2/9/21.

import CoreGraphics
import Aesthete

public struct CapitalShipSurfaceGreebles: Drawable {

    public let xUnits: CGFloat
    public let yUnits: CGFloat
    public let themeColor: HSBAColor

    public init(xUnits: CGFloat = 1,
                yUnits: CGFloat = 1,
                themeColor: HSBAColor) {
        self.xUnits = xUnits
        self.yUnits = yUnits
        self.themeColor = themeColor
    }

    public func draw(on context: CGContext) {
        let drawingRect = CGRect(x: 0.0, y: 0.0, width: xUnits, height: yUnits)

        context.saveGState()
        context.setAllowsAntialiasing(false)

        context.setFillColor(CGColor.create(from: themeColor))
        context.fill(drawingRect)

        let coverageArea = Int(xUnits * yUnits)
        for _ in 1...(coverageArea * 200) {
            let panelColor = themeColor.saturationAdjusted(by: CGFloat.random(in: -0.05...0.05))
            context.setFillColor(CGColor.create(from: panelColor))

            let panelRect = CGRect(x: CGFloat.random(in: 0..<xUnits),
                                   y: CGFloat.random(in: 0..<yUnits),
                                   width: CGFloat.random(in: 0.05...0.1),
                                   height: CGFloat.random(in: 0.05...0.1))
            context.fill(panelRect)
        }

        context.restoreGState()
    }

}
