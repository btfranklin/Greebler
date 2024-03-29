//  Created by B.T. Franklin on 10/4/19

import CoreGraphics
import Aesthete

public struct PanelGreebles: Drawable, Codable, Hashable {
    
    public let xUnits: CGFloat
    public let yUnits: CGFloat
    public let themeColor: HSBAColor
    public let panelCount: Int
    public let showRivets: Bool
    
    public init(xUnits: CGFloat = 1,
                yUnits: CGFloat = 1,
                themeColor: HSBAColor,
                panelCount: Int,
                showRivets: Bool = false) {
        self.xUnits = xUnits
        self.yUnits = yUnits
        self.themeColor = themeColor
        self.panelCount = panelCount
        self.showRivets = showRivets
    }
    
    public func draw(on context: CGContext) {
        context.saveGState()
        
        context.setAllowsAntialiasing(false)
        context.setLineWidth(0.001)
        context.setStrokeColor(.black)

        let rects = CGRect(x: 0.0, y: 0.0, width: xUnits, height: yUnits).randomlyDivided(into: panelCount)
        
        for rect in rects {
            let panelColor = themeColor.withSaturation(adjustedBy: CGFloat.random(in: -0.1...0.1))
            context.setFillColor(CGColor.make(hsbaColor: panelColor))
            context.fill(rect)
            context.stroke(rect)
            
            if showRivets && rect.width > 0.1 && rect.height > 0.1 {
                context.saveGState()
                context.setLineDash(phase: 0, lengths: [0.005,0.1])
                context.setLineWidth(0.005)
                
                let insetRect = rect.insetBy(dx: 0.02, dy: 0.02)
                context.stroke(insetRect)
                
                context.restoreGState()
            }
        }

        context.restoreGState()
    }
}
