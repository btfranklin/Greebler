//  Created by B.T. Franklin on 12/30/20.

import CoreGraphics
import DunesailerUtilities
import Aesthete

public struct CutawaySectionGreebles: Drawable, Codable, Hashable {

    public let xUnits: CGFloat
    public let yUnits: CGFloat
    public let themeColor: HSBAColor
    public let cutawayCount: Int
    public let backlightColor: HSBAColor

    public init(xUnits: CGFloat = 1,
                yUnits: CGFloat = 1,
                themeColor: HSBAColor,
                cutawayCount: Int,
                backlightColor: HSBAColor = CGColor(#colorLiteral(red: 0.8, green: 0, blue: 0, alpha: 1.0)).hsbaColor) {
        self.xUnits = xUnits
        self.yUnits = yUnits
        self.themeColor = themeColor
        self.cutawayCount = cutawayCount
        self.backlightColor = backlightColor
    }

    public func draw(on context: CGContext) {
        context.saveGState()

        context.setAllowsAntialiasing(true)

        let innardsFillColor = themeColor.brightnessAdjusted(by: -0.2)
        let backlightCGColor = CGColor.create(from: backlightColor)
        context.setLineWidth(0.001)
        context.setStrokeColor(.black)

        for _ in 1...cutawayCount {
            context.saveGState()

            let width = CGFloat.random(in: 0.3...0.7)
            let height = CGFloat.random(in: 0.3...0.7)
            let rect = CGRect(x: CGFloat.random(in: 0.0...xUnits - width),
                              y: CGFloat.random(in: 0.0...yUnits - height),
                              width: width,
                              height: height)

            let clippingShape = createClippingShape(on: context, in: rect)
            context.clip()

            context.setFillColor(backlightCGColor)
            context.fill(rect)

            drawInnards(on: context, in: rect, using: innardsFillColor)

            context.restoreGState()

            context.addPath(clippingShape)
            context.strokePath()
        }

        context.restoreGState()
    }

    private func createClippingShape(on context: CGContext, in rect: CGRect) -> CGPath {

        enum PathPhase {
            case movingRight
            case movingDown
            case movingLeft
            case finished
        }

        var xPos = rect.minX
        var yPos = CGFloat.random(in: rect.midY...rect.maxY)
        context.move(to: CGPoint(x: xPos, y: yPos))

        var pathPhase: PathPhase = .movingRight
        while pathPhase != .finished {
            switch pathPhase {

            case .movingRight:
                if yPos > rect.midY { // Top region, so only move right or down-right
                    if Bool.random() {
                        xPos = CGFloat.random(in: xPos...rect.maxX)
                    } else {
                        let newYPos = CGFloat.random(in: rect.midY...yPos)
                        let delta = yPos - newYPos
                        yPos = newYPos
                        xPos = xPos + delta
                    }

                } else { // Bottom region, so only move right or up-right
                    if Bool.random() {
                        xPos = CGFloat.random(in: xPos...rect.maxX)
                    } else {
                        let newYPos = CGFloat.random(in: yPos...rect.midY)
                        let delta = newYPos - yPos
                        yPos = newYPos
                        xPos = xPos + delta
                    }
                }

                if xPos >= rect.maxX {
                    xPos = rect.maxX
                    pathPhase = .movingDown
                }
                context.addLine(to: CGPoint(x: xPos, y: yPos))

            case .movingDown:
                yPos = CGFloat.random(in: rect.minY...yPos)
                context.addLine(to: CGPoint(x: xPos, y: yPos))
                pathPhase = .movingLeft

            case .movingLeft:
                if yPos > rect.midY { // Top region, so only move left or down-left
                    if Bool.random() {
                        xPos = CGFloat.random(in: rect.minX...xPos)
                    } else {
                        let newYPos = CGFloat.random(in: rect.midY...yPos)
                        let delta = yPos - newYPos
                        yPos = newYPos
                        xPos = xPos - delta
                    }

                } else { // Bottom region, so only move left or up-left
                    if Bool.random() {
                        xPos = CGFloat.random(in: rect.minX...xPos)
                    } else {
                        let newYPos = CGFloat.random(in: yPos...rect.midY)
                        let delta = newYPos - yPos
                        yPos = newYPos
                        xPos = xPos - delta
                    }
                }

                if xPos <= rect.minX {
                    xPos = rect.minX
                    pathPhase = .finished
                }
                context.addLine(to: CGPoint(x: xPos, y: yPos))

            case .finished:
                break
            }
        }

        context.closePath()
        return context.path!
    }

    private func drawInnards(on context: CGContext, in rect: CGRect, using innardsFillColor: HSBAColor) {
        context.saveGState()

        context.translateBy(x: rect.minX, y: rect.minY)
        let scaleFactor = min(rect.width, rect.height)
        context.scaleBy(x: scaleFactor, y: scaleFactor)

        let equipmentGreebles = EquipmentGreebles(xUnits: rect.width * (1.0 / scaleFactor),
                                                  yUnits: rect.height * (1.0 / scaleFactor),
                                                  themeColor: innardsFillColor,
                                                  equipmentCount: 4)
        equipmentGreebles.draw(on: context)

        let pipeGreebles = PipeGreebles(xUnits: rect.width * (1.0 / scaleFactor),
                                        yUnits: rect.height * (1.0 / scaleFactor),
                                        themeColor: innardsFillColor,
                                        pipeCount: 40,
                                        allowOffSide: true)
        pipeGreebles.draw(on: context)

        context.restoreGState()
    }
}
