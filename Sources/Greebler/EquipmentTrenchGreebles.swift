//  Created by B.T. Franklin on 2/9/21.

import CoreGraphics
import Aesthete

public struct EquipmentTrenchGreebles: Drawable, Codable, Hashable {

    public let xUnits: CGFloat
    public let yUnits: CGFloat
    public let themeColor: HSBAColor
    public let trenchYPosition: CGFloat
    public let trenchWidth: CGFloat

    public init(xUnits: CGFloat = 1,
                yUnits: CGFloat = 1,
                themeColor: HSBAColor,
                trenchYPosition: CGFloat = 0.5,
                trenchWidth: CGFloat = 1) {

        guard trenchWidth >= 1 else {
            fatalError("trenchWidth must be at least 1.0")
        }
        self.xUnits = xUnits
        self.yUnits = yUnits
        self.themeColor = themeColor
        self.trenchYPosition = trenchYPosition
        self.trenchWidth = trenchWidth
    }

    public func draw(on context: CGContext) {
        context.saveGState()

        let scaleFactor: CGFloat = 0.1
        let equipmentGreebles = EquipmentGreebles(xUnits: xUnits/scaleFactor,
                                                  yUnits: trenchWidth,
                                                  themeColor: themeColor,
                                                  equipmentCount: Int(trenchWidth * xUnits * 100))

        context.translateBy(x: 0, y: trenchYPosition - ((trenchWidth * scaleFactor) / 2))
        context.scaleBy(x: scaleFactor, y: scaleFactor)

        let equipmentTrenchRect = CGRect(x: 0, y: 0.05, width: xUnits/scaleFactor, height: trenchWidth)
        let trenchColor = themeColor.withBrightness(adjustedBy: -0.3)
        context.setFillColor(CGColor.make(hsbaColor: trenchColor))
        context.fill(equipmentTrenchRect)

        context.clip(to: equipmentTrenchRect)

        equipmentGreebles.draw(on: context)

        context.setShadow(offset: CGSize(width: 12, height: -6), blur: 12, color: .black)
        context.fill(CGRect(x: 0.0, y: trenchWidth+0.05, width: xUnits/scaleFactor, height: 0.4))

        context.restoreGState()
    }
}
