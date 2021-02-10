//  Created by B.T. Franklin on 2/9/21.

import CoreGraphics
import Aesthete

public struct EquipmentStripGreebles: Greebles {

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
        context.saveGState()

        let scaleFactor: CGFloat = 0.1

        let equipmentGreebles = EquipmentGreebles(xUnits: xUnits/scaleFactor, themeColor: themeColor, equipmentCount: 100 * Int(xUnits.rounded()))

        context.translateBy(x: 0, y: CGFloat.random(in: 0.0...yUnits))
        context.scaleBy(x: scaleFactor, y: scaleFactor)

        let equipmentTrenchRect = CGRect(x: 0, y: 0.05, width: xUnits/scaleFactor, height: 1.0)
        let trenchColor = themeColor.brightnessAdjusted(by: -0.3)
        context.setFillColor(CGColor.create(from: trenchColor))
        context.fill(equipmentTrenchRect)

        context.clip(to: equipmentTrenchRect)

        equipmentGreebles.draw(on: context)

        context.setShadow(offset: CGSize(width: 12, height: -8), blur: 10, color: .black)
        context.fill(CGRect(x: 0.0, y: 1.05, width: xUnits/scaleFactor, height: 0.4))

        context.restoreGState()
    }
}
