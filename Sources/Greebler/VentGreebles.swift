//  Created by B.T. Franklin on 10/7/19.

import CoreGraphics
import Aesthete

public struct VentGreebles: Drawable, Codable, Hashable {
    
    public let xUnits: CGFloat
    public let yUnits: CGFloat
    public let themeColor: HSBAColor
    public let ventCount: Int
    
    public init(xUnits: CGFloat = 1,
                yUnits: CGFloat = 1,
                themeColor: HSBAColor,
                ventCount: Int) {
        self.xUnits = xUnits
        self.yUnits = yUnits
        self.themeColor = themeColor
        self.ventCount = ventCount
    }
    
    public func draw(on context: CGContext) {
        context.saveGState()
        
        context.setAllowsAntialiasing(false)

        var rects: [CGRect] = []
        
        for _ in 1...ventCount {
            rects.append(CGRect(x: CGFloat.random(in: 0.0...xUnits - 0.1),
                                y: CGFloat.random(in: 0.0...yUnits - 0.1),
                                width: CGFloat.random(in: 0.05...0.3),
                                height: CGFloat.random(in: 0.05...0.3)))
        }

        let themeCGColor = CGColor.make(hsbaColor: themeColor)
        for rect in rects {
            
            context.setLineWidth(0.001)
            context.setStrokeColor(.black)
            context.setFillColor(themeCGColor)
            context.fill(rect)
            context.stroke(rect)
            
            context.setFillColor(.black)
            let insetRect = rect.insetBy(dx: 0.02, dy: 0.02)
            context.fill(insetRect)
            
            context.setFillColor(themeCGColor)
            
            if rect.orientation == .horizontal {
                for slatX in stride(from: insetRect.minX-0.01, through: insetRect.maxX, by: 0.02) {
                    context.fill(CGRect(x: slatX, y: insetRect.minY, width: 0.01, height: insetRect.height))
                }
            } else {
                for slatY in stride(from: insetRect.minY-0.01, through: insetRect.maxY, by: 0.02) {
                    context.fill(CGRect(x: insetRect.minX, y: slatY, width: insetRect.width, height: 0.01))
                }
            }
        }

        context.restoreGState()
    }
}
