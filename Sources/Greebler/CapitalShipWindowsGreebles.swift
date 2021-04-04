//  Created by B.T. Franklin on 2/9/21.

import CoreGraphics
import Aesthete

public struct CapitalShipWindowsGreebles: Drawable, Codable, Hashable {

    static public let BLUE_INTERIOR_LIGHT_COLOR = CGColor(#colorLiteral(red: 0.6721253958, green: 0.9103467933, blue: 1, alpha: 1)).hsbaColor
    static public let AMBER_INTERIOR_LIGHT_COLOR = CGColor(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)).hsbaColor

    public let xUnits: CGFloat
    public let yUnits: CGFloat
    public let themeColor: HSBAColor
    public let windowZoneCount: Int
    public let windowColor: HSBAColor

    private typealias WindowZone = (rect: CGRect, columnCount: Int, rowCount: Int)

    static private let WINDOW_ZONE_INSET: CGFloat = 0.01
    static private let WINDOW_SPACING: CGFloat = 0.005
    static private let FLOOR_SPACING: CGFloat = 0.02
    static private let WINDOW_SIZE: CGFloat = 0.01

    private enum WindowEnclosureStyle: CaseIterable {
        case flat
        case recessed
    }

    public init(xUnits: CGFloat = 1,
                yUnits: CGFloat = 1,
                themeColor: HSBAColor,
                windowZoneCount: Int = 3,
                windowColor: HSBAColor = CapitalShipWindowsGreebles.BLUE_INTERIOR_LIGHT_COLOR) {
        self.xUnits = xUnits
        self.yUnits = yUnits
        self.themeColor = themeColor
        self.windowZoneCount = windowZoneCount
        self.windowColor = windowColor
    }

    public func draw(on context: CGContext) {
        context.saveGState()

        context.setAllowsAntialiasing(false)

        var windowZones: [WindowZone] = []

        for _ in 1...windowZoneCount {

            let columnCount = Int.random(in: 3...(60*Int(xUnits.rounded())))
            let rowCount = [1, 1, 1, 2, 2, 3, 3, 3, 4, 5].randomElement()!

            let rectWidth = (CGFloat(columnCount) * CapitalShipWindowsGreebles.WINDOW_SIZE)
                + (CGFloat(columnCount-1) * CapitalShipWindowsGreebles.WINDOW_SPACING)
                + (CapitalShipWindowsGreebles.WINDOW_ZONE_INSET * 2)
            let rectHeight = (CGFloat(rowCount) * CapitalShipWindowsGreebles.WINDOW_SIZE)
                + (CGFloat(rowCount-1) * CapitalShipWindowsGreebles.FLOOR_SPACING)
                + (CapitalShipWindowsGreebles.WINDOW_ZONE_INSET * 2)

            let rect = CGRect(x: CGFloat.random(in: 0.0...(xUnits - rectWidth)),
                              y: CGFloat.random(in: 0.0...(yUnits - rectHeight)),
                              width: rectWidth,
                              height: rectHeight)
            windowZones.append( (rect: rect, columnCount: columnCount, rowCount: rowCount) )
        }

        for windowZone in windowZones {

            switch WindowEnclosureStyle.allCases.randomElement()! {
            case .flat:
                drawFlat(windowZone, on: context)

            case .recessed:
                drawRecessed(windowZone, on: context)
            }

            context.saveGState()
            context.setFillColor(CGColor.make(hsbaColor: windowColor))
            context.setShadow(offset: CGSize(width: 0, height: 0),
                              blur: 8,
                              color: CGColor.make(hsbaColor: windowColor))

            for column in 0..<windowZone.columnCount {
                for row in 0..<windowZone.rowCount {
                    if Bool.random(probability: 33) {
                        let windowX = windowZone.rect.minX + CapitalShipWindowsGreebles.WINDOW_ZONE_INSET
                            + (CGFloat(column) * CapitalShipWindowsGreebles.WINDOW_SIZE)
                            + (CGFloat(column) * CapitalShipWindowsGreebles.WINDOW_SPACING)
                        let windowY = windowZone.rect.minY + CapitalShipWindowsGreebles.WINDOW_ZONE_INSET
                            + (CGFloat(row) * CapitalShipWindowsGreebles.WINDOW_SIZE)
                            + (CGFloat(row) * CapitalShipWindowsGreebles.FLOOR_SPACING)
                        let windowRect = CGRect(x: windowX,
                                                y: windowY,
                                                width: CapitalShipWindowsGreebles.WINDOW_SIZE,
                                                height: CapitalShipWindowsGreebles.WINDOW_SIZE)

                        context.fill(windowRect)
                    }
                }
            }
            context.restoreGState()
        }

        context.restoreGState()
    }

    private func drawFlat(_ windowZone: WindowZone, on context: CGContext) {
        context.saveGState()

        let strokeColor = CGColor.make(hsbaColor: themeColor.withBrightness(adjustedBy: -0.1))
        let backgroundColor = CGColor.make(hsbaColor: themeColor)

        context.setLineWidth(0.002)
        context.setStrokeColor(strokeColor)
        context.setFillColor(backgroundColor)
        context.fill(windowZone.rect)
        context.stroke(windowZone.rect)

        context.restoreGState()
    }

    private func drawRecessed(_ windowZone: WindowZone, on context: CGContext) {
        context.saveGState()

        let zoneRect = windowZone.rect

        let backgroundColor = CGColor.make(hsbaColor: themeColor.withSaturation(adjustedBy: -0.2).withBrightness(adjustedBy: -0.2))

        context.setFillColor(backgroundColor)
        context.fill(zoneRect)

        context.clip(to: zoneRect)

        context.setShadow(offset: CGSize(width: 0, height: -12), blur: 24, color: .black)
        context.fill(CGRect(x: zoneRect.minX,
                            y: zoneRect.minY+zoneRect.height,
                            width: zoneRect.width,
                            height: 0.05))
        context.setShadow(offset: CGSize(width: 12, height: 0), blur: 24, color: .black)
        context.fill(CGRect(x: zoneRect.minX-0.05,
                            y: zoneRect.minY,
                            width: 0.05,
                            height: zoneRect.height))

        context.restoreGState()
    }

}
