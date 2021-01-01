//  Created by B.T. Franklin on 12/25/20.

import CoreGraphics
import DunesailerUtilities
import Aesthete

public struct EquipmentGreebles: Greebles {

    public let xUnits: CGFloat
    public let yUnits: CGFloat
    public let themeColor: HSBAColor
    public let equipmentCount: Int

    public init(xUnits: CGFloat = 1, yUnits: CGFloat = 1, themeColor: HSBAColor, equipmentCount: Int) {
        self.xUnits = xUnits
        self.yUnits = yUnits
        self.themeColor = themeColor
        self.equipmentCount = equipmentCount
    }

    public func draw(on context: CGContext) {
        context.saveGState()
        
        context.setAllowsAntialiasing(true)

        let themeCGColor = CGColor.create(from: themeColor)
        context.setFillColor(themeCGColor)
        context.setLineWidth(0.001)
        context.setStrokeColor(.black)

        for _ in 1...equipmentCount {

            switch Int.random(in: 0...100) {
            case 0...25:
                let width = CGFloat.random(in: 0.2...0.5)
                let height = CGFloat.random(in: 0.2...0.5)
                let rect = CGRect(x: CGFloat.random(in: 0.0...xUnits - width),
                                  y: CGFloat.random(in: 0.0...yUnits - height),
                                  width: width,
                                  height: height)
                drawCentralizedItem(on: context, in: rect, using: themeCGColor)

            case 26...60:
                let width = CGFloat.random(in: 0.2...0.7)
                let height = CGFloat.random(in: 0.2...0.7)
                let rect = CGRect(x: CGFloat.random(in: 0.0...xUnits - width),
                                  y: CGFloat.random(in: 0.0...yUnits - height),
                                  width: width,
                                  height: height)
                drawRowOfItems(on: context, in: rect, using: themeCGColor)

            default:
                let width = CGFloat.random(in: 0.5...0.8)
                let height = CGFloat.random(in: 0.5...0.8)
                let rect = CGRect(x: CGFloat.random(in: 0.0...xUnits - width),
                                  y: CGFloat.random(in: 0.0...yUnits - height),
                                  width: width,
                                  height: height)
                drawScatteredItems(on: context, in: rect, using: themeCGColor)
            }
        }

        context.restoreGState()
    }

    private func drawRowOfItems(on context: CGContext, in rect: CGRect, using themeColor: CGColor) {
        context.saveGState()

        let adjustedColor = themeColor.hsbaColor.brightnessAdjusted(by: 0.1)
        context.setFillColor(CGColor.create(from: adjustedColor))

        let itemCount = Bool.random(probability: 80) ? 3 : 5
        let useRoundItems = Bool.random()
        let addInnerItem = Bool.random(probability: 80)
        let innerLineWidth = CGFloat.random(in: 0.001...0.03)
        let innerItemInset = CGFloat.random(in: 0.01...0.05)
        let useInnerDash = Bool.random()

        let drawItem: (Bool, CGContext, CGRect) -> Void = { useRoundItems, context, itemRect in
            if useRoundItems {
                drawRoundItem(on: context, in: itemRect)

                if addInnerItem {
                    drawRoundItem(on: context,
                                  in: itemRect.insetBy(dx: innerItemInset, dy: innerItemInset),
                                  lineWidth: innerLineWidth,
                                  useDash: useInnerDash)
                }

            } else {
                drawSquareItem(on: context, in: itemRect)

                if addInnerItem {
                    drawSquareItem(on: context,
                                   in: itemRect.insetBy(dx: innerItemInset, dy: innerItemInset),
                                   lineWidth: innerLineWidth,
                                   useDash: useInnerDash)
                }
            }
        }

        if rect.orientation == .horizontal {
            let itemSize = rect.width / CGFloat(itemCount)
            let itemInset = itemSize * 0.05
            let itemY = rect.midY - (itemSize / 2)

            for itemX in stride(from: rect.minX, to: rect.maxX, by: itemSize) {
                let itemRect = CGRect(x: itemX, y: itemY, width: itemSize, height: itemSize).insetBy(dx: itemInset, dy: itemInset)
                drawItem(useRoundItems, context, itemRect)
            }

        } else {
            let itemSize = rect.height / CGFloat(itemCount)
            let itemInset = itemSize * 0.05
            let itemX = rect.midX - (itemSize / 2)

            for itemY in stride(from: rect.minY, to: rect.maxY, by: itemSize) {
                let itemRect = CGRect(x: itemX, y: itemY, width: itemSize, height: itemSize).insetBy(dx: itemInset, dy: itemInset)
                drawItem(useRoundItems, context, itemRect)
            }
        }

        context.restoreGState()
    }

    private func drawScatteredItems(on context: CGContext,
                                    in rect: CGRect,
                                    using themeColor: CGColor) {
        context.saveGState()

        // Underlying panel rectangle
        if Bool.random() {
            context.fill(rect)
            context.stroke(rect)
        }

        let adjustedColor = themeColor.hsbaColor.brightnessAdjusted(by: 0.1)
        context.setFillColor(CGColor.create(from: adjustedColor))
        context.setShadow(offset: CGSize(width: 12, height: -6), blur: 12)

        for _ in 1...Int.random(in: 5...30) {

            let xPos = CGFloat.random(in: rect.minX...rect.maxX)
            let yPos = CGFloat.random(in: rect.minY...rect.maxY)
            let xMax = CGFloat.random(in: xPos...rect.maxX)
            let yMax = CGFloat.random(in: yPos...rect.maxY)
            let width = xMax - xPos
            let height = yMax - yPos
            let itemRect = CGRect(x: xPos, y: yPos, width: width, height: height)

            if Bool.random() {
                drawRowOfItems(on: context, in: itemRect, using: themeColor)
            } else {
                drawCentralizedItem(on: context, in: itemRect, using: themeColor)
            }
        }

        context.restoreGState()
    }

    private func drawCentralizedItem(on context: CGContext,
                                     in rect: CGRect,
                                     using themeColor: CGColor) {
        context.saveGState()

        // Underlying panel rectangle
        if Bool.random() {
            context.fill(rect)
            context.stroke(rect)
        }

        let adjustedColor = themeColor.hsbaColor.brightnessAdjusted(by: 0.1)
        context.setFillColor(CGColor.create(from: adjustedColor))
        context.setShadow(offset: CGSize(width: 12, height: -6), blur: 12)
        
        var itemRect: CGRect
        let itemSize: CGFloat
        if rect.orientation == .horizontal {
            itemSize = rect.height
            let itemX = rect.midX - (itemSize / 2)
            itemRect = CGRect(x: itemX, y: rect.minY, width: itemSize, height: itemSize)
        } else {
            itemSize = rect.width
            let itemY = rect.midY - (itemSize / 2)
            itemRect = CGRect(x: rect.minX, y: itemY, width: itemSize, height: itemSize)
        }

        // Surrounding items
        if Bool.random() {

            let quadrantWidth = itemRect.width / 2
            let quadrantHeight = itemRect.height / 2
            let useRoundItems = Bool.random()
            let addInnerItem = Bool.random(probability: 80)
            let innerLineWidth = CGFloat.random(in: 0.001...0.03)
            let innerItemInset = CGFloat.random(in: 0.01...0.05)
            let useInnerDash = Bool.random()

            let drawSurroundingItem: (CGContext, CGRect) -> Void = { context, itemRect in
                if useRoundItems {
                    drawRoundItem(on: context, in: itemRect)

                    if addInnerItem {
                        drawRoundItem(on: context,
                                      in: itemRect.insetBy(dx: innerItemInset, dy: innerItemInset),
                                      lineWidth: innerLineWidth,
                                      useDash: useInnerDash)
                    }

                } else {
                    drawSquareItem(on: context, in: itemRect)

                    if addInnerItem {
                        drawSquareItem(on: context,
                                       in: itemRect.insetBy(dx: innerItemInset, dy: innerItemInset),
                                       lineWidth: innerLineWidth,
                                       useDash: useInnerDash)
                    }
                }
            }

            let nwRect = CGRect(x: itemRect.minX, y: itemRect.minY, width: quadrantWidth, height: quadrantHeight).insetBy(dx: 0.02, dy: 0.02)
            drawSurroundingItem(context, nwRect)

            let neRect = CGRect(x: itemRect.midX, y: itemRect.minY, width: quadrantWidth, height: quadrantHeight).insetBy(dx: 0.02, dy: 0.02)
            drawSurroundingItem(context, neRect)

            let swRect = CGRect(x: itemRect.minX, y: itemRect.midY, width: quadrantWidth, height: quadrantHeight).insetBy(dx: 0.02, dy: 0.02)
            drawSurroundingItem(context, swRect)

            let seRect = CGRect(x: itemRect.midX, y: itemRect.midY, width: quadrantWidth, height: quadrantHeight).insetBy(dx: 0.02, dy: 0.02)
            drawSurroundingItem(context, seRect)

            itemRect = itemRect.insetBy(dx: 0.1, dy: 0.1)
        }

        var layerRect = itemRect
        var layerLineWidth = CGFloat(0.001)
        var useDash = false
        for _ in 1...Int.random(in: 2...5) {
            let useRoundItem = Bool.random()
            let layerItemInset = CGFloat.random(in: 0.05...0.1)

            if useRoundItem {
                drawSquareItem(on: context, in: layerRect, lineWidth: layerLineWidth, useDash: useDash)
            } else {
                drawRoundItem(on: context, in: layerRect, lineWidth: layerLineWidth, useDash: useDash)
            }
            
            layerRect = layerRect.insetBy(dx: layerItemInset, dy: layerItemInset)
            layerLineWidth = CGFloat.random(in: 0.001...0.01)
            useDash = Bool.random()
        }

        context.restoreGState()
    }

    private func drawSquareItem(on context: CGContext,
                                in rect: CGRect,
                                lineWidth: CGFloat = 0.001,
                                useDash: Bool = false) {
        context.saveGState()

        context.setLineWidth(lineWidth)
        if useDash {
            context.setLineDash(phase: 0, lengths: [0.03,0.01])
        }

        context.setShadow(offset: CGSize(width: 12, height: -6), blur: 8)
        context.fill(rect)
        context.setShadow(offset: CGSize(width: 0, height: 0), blur: 0, color: .clear)
        context.stroke(rect)

        context.restoreGState()
    }

    private func drawRoundItem(on context: CGContext,
                                    in rect: CGRect,
                                    lineWidth: CGFloat = 0.001,
                                    useDash: Bool = false) {
        context.saveGState()

        context.setLineWidth(lineWidth)
        if useDash {
            context.setLineDash(phase: 0, lengths: [0.03,0.01])
        }

        context.setShadow(offset: CGSize(width: 12, height: -6), blur: 8)
        context.fillEllipse(in: rect)
        context.setShadow(offset: CGSize(width: 0, height: 0), blur: 0, color: .clear)
        context.strokeEllipse(in: rect)

        context.restoreGState()
    }

}
