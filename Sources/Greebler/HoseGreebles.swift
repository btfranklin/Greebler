//  Created by B.T. Franklin on 10/8/19.

import CoreGraphics
import Aesthete

public struct HoseGreebles: Drawable, Codable, Hashable {
    
    private struct Hose {
        let path: CGPath
        let endPoints: [CGPoint]
        
        init(xUnits: CGFloat = 1,
             yUnits: CGFloat = 1,
             allowOffSide: Bool) {

            let insetRect = CGRect(x: 0, y: 0, width: xUnits, height: yUnits).insetBy(dx: 0.1, dy: 0.1)
            let outsetRect = CGRect(x: 0, y: 0, width: xUnits, height: yUnits).insetBy(dx: -0.3, dy: -0.3)
            var endPoints: [CGPoint] = []
            let constrainingRect = allowOffSide ? outsetRect : insetRect
            let startingPoint = CGPoint.random(inX: constrainingRect.minX...constrainingRect.maxX,
                                               inY: constrainingRect.minY...constrainingRect.maxY)
            endPoints.append(startingPoint)
            let endingPoint = CGPoint.random(inX: constrainingRect.minX...constrainingRect.maxX,
                                             inY: constrainingRect.minY...constrainingRect.maxY)
            endPoints.append(endingPoint)
            
            let path = CGMutablePath()
            path.move(to: startingPoint)
            
            let minX = min(startingPoint.x, endingPoint.x)
            let maxX = max(startingPoint.x, endingPoint.x)
            let minY = min(startingPoint.y, endingPoint.y)
            let maxY = max(startingPoint.y, endingPoint.y)

            path.addCurve(to: endingPoint,
                          control1: CGPoint.random(inX: minX...maxX,
                                                   inY: minY...maxY),
                          control2: CGPoint.random(inX: minX...maxX,
                                                   inY: minY...maxY))
            
            self.path = path.copy()!
            self.endPoints = endPoints
        }
    }
    
    public let xUnits: CGFloat
    public let yUnits: CGFloat
    public let themeColor: HSBAColor
    public let hoseCount: Int
    public let allowOffSide: Bool
    
    public init(xUnits: CGFloat = 1, yUnits: CGFloat = 1, themeColor: HSBAColor, hoseCount: Int, allowOffSide: Bool = true) {
        self.xUnits = xUnits
        self.yUnits = yUnits
        self.themeColor = themeColor
        self.hoseCount = hoseCount
        self.allowOffSide = allowOffSide
    }
    
    public func draw(on context: CGContext) {
        context.saveGState()
        context.setAllowsAntialiasing(true)
        
        var hoses: [Hose] = []
        for _ in 1...hoseCount {
            hoses.append(Hose(xUnits: xUnits, yUnits: yUnits, allowOffSide: allowOffSide));
        }
        
        // Draw all the endpoints first
        let fixtureColor = CGColor.make(hsbaColor: themeColor.withSaturation(adjustedBy: -0.25))
        let endpointRadius = CGFloat(0.04)
        for hose in hoses {
            context.saveGState()
            
            let endPoint1 = hose.endPoints[0]
            let endPoint2 = hose.endPoints[1]
            context.addEllipse(in: CGRect(x: endPoint1.x-endpointRadius,
                                          y: endPoint1.y-endpointRadius,
                                          width: endpointRadius*2,
                                          height: endpointRadius*2))
            context.addEllipse(in: CGRect(x: endPoint2.x-endpointRadius,
                                          y: endPoint2.y-endpointRadius,
                                          width: endpointRadius*2,
                                          height: endpointRadius*2))
            context.setFillColor(fixtureColor)
            context.fillPath()
            
            context.addEllipse(in: CGRect(x: endPoint1.x-endpointRadius,
                                          y: endPoint1.y-endpointRadius,
                                          width: endpointRadius*2,
                                          height: endpointRadius*2))
            context.addEllipse(in: CGRect(x: endPoint2.x-endpointRadius,
                                          y: endPoint2.y-endpointRadius,
                                          width: endpointRadius*2,
                                          height: endpointRadius*2))
            context.setStrokeColor(.black)
            context.setLineWidth(0.003)
            context.strokePath()
            
            context.restoreGState()
        }

        // Now draw all the actual hoses
        let hoseColor = CGColor.make(hsbaColor: themeColor.withBrightness(adjustedBy: -0.4))
        context.setShadow(offset: CGSize(width: 12, height: -6), blur: 12)
        for hose in hoses {
            context.saveGState()
            
            context.setLineCap(.round)
            context.setLineJoin(.round)
            context.setLineWidth(0.05)
            context.setStrokeColor(hoseColor)
            context.addPath(hose.path)
            context.strokePath()
            
            context.restoreGState()
        }

        context.restoreGState()
    }
    
}
